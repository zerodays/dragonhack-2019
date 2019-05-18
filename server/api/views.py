import base64
import json
import uuid
from io import BytesIO

import requests
from PIL import Image
from django.conf import settings
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.http import HttpResponseBadRequest
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt

from api.helpers import plant_to_dictionary, dictionary_to_response, check_identification
from base.models import ScannedPlant


@csrf_exempt
def scan_view(request):
    if request.method.lower() != 'post':
        return HttpResponseBadRequest('tole pa ni post decko')

    data = json.loads(request.body)
    image_b64 = data['image']
    latitude = data['lat']
    longitude = data['lon']
    team = data['team']

    scanned = ScannedPlant(team=team, latitude=latitude, longitude=longitude)
    scanned.save()

    image = Image.open(BytesIO(base64.b64decode(image_b64)))

    width, height = image.size
    size = min(width, height)
    left = (width - size) / 2
    top = (height - size) / 2
    right = (width + size) / 2
    bottom = (height + size) / 2
    image = image.crop((left, top, right, bottom))

    if size > 512:
        image = image.resize((512, 512), Image.ANTIALIAS)

    image_file = BytesIO()
    image.save(fp=image_file, format='JPEG')

    image_name = '{}.jpeg'.format(uuid.uuid4())
    image_path = 'plants/' + image_name
    scanned.image.save(image_path,
                       InMemoryUploadedFile(
                           image_file,
                           None,
                           image_name,
                           'image/jpeg',
                           image.tell,
                           None)
                       )
    scanned.save()

    body = {
        'key': settings.PLANT_ID_API_KEY,
        'custom_id': scanned.pk,
        'latitude': latitude,
        'longitude': longitude,
        'date': int(timezone.now().timestamp() * 1000),
        'images': [
            image_b64,
        ],
    }

    r = requests.post(url='https://api.plant.id/identify', data=json.dumps(body),
                      headers={'Content-Type': 'application/json'})

    if r.status_code != 200:
        res = {
            'success': False,
            'plant': None,
            'probability': None,
        }

        return dictionary_to_response(res)

    scanned_id = r.json()['id']

    count = 0
    suggestions = check_identification(scanned_id, sleep=1)
    while len(suggestions) == 0:
        if count > 5:
            break
        count += 1

        suggestions = check_identification(scanned_id, sleep=0.5)

    if len(suggestions) == 0:
        res = {
            'success': False,
            'plant': None,
            'probability': None,
        }
    else:
        suggestion = suggestions[0]
        print('recognized!')
        print(suggestion)

        plant_name = suggestion['plant']['name'].lower()

        scanned.recognized = True
        scanned.name = plant_name
        scanned.probability = suggestion['probability']
        scanned.save()

        res = {
            'success': True,
            'plant': plant_to_dictionary(scanned),
            'probability': scanned.probability,
        }

    return dictionary_to_response(res)


def history_view(request):
    plants_query = ScannedPlant.get_recognized().order_by('-date_created')
    plants = list(map(plant_to_dictionary, plants_query))

    res = {
        'plants': plants,
    }

    return dictionary_to_response(res)


def percentage_view(request):
    plants = ScannedPlant.get_recognized()
    total_number = plants.count()

    team_0_num = plants.filter(team=0).count()
    team_0_perc = round(total_number / team_0_num * 100)
    team_1_perc = 100 - team_0_perc

    return dictionary_to_response({
        '0': team_0_perc,
        '1': team_1_perc,
    })
