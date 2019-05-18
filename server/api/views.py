import base64
import json
import time
import uuid
from io import BytesIO

import requests
from PIL import Image
from django.conf import settings
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.http import HttpResponse, HttpResponseBadRequest
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt

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
        print('neki nije bilo vrejdi pa ne prepozna')

        res = {
            'success': False,
            'plant': None,
            'probability': None,
        }

        return HttpResponse(json.dumps(res), content_type='application/json')

    scanned_id = r.json()['id']

    count = 0
    suggestions = check_identification(scanned_id, sleep=1)
    while len(suggestions) == 0:
        if count > 5:
            break
        count += 1

        suggestions = check_identification(scanned_id, sleep=0.5)

    if len(suggestions) == 0:
        print('timeoutov suggestion (upsi)')

        res = {
            'success': False,
            'plant': None,
            'probability': None,
        }
    else:
        suggestion = suggestions[0]

        plant_name = suggestion['plant']['name'].lower()

        scanned.recognized = True
        scanned.plant_name = plant_name
        scanned.probability = suggestion['probability']
        scanned.save()

        res = {
            'success': True,
            'plant': {
                'name': plant_name.title(),
                'description': 'Lorem ipsum',
                'image_url': scanned.image.url,
            },
            'probability': scanned.probability,
        }

    return HttpResponse(json.dumps(res), content_type='application/json')


def check_identification(scanned_id, sleep=None):
    if sleep is not None:
        time.sleep(sleep)

    body = {
        'key': settings.PLANT_ID_API_KEY,
        'ids': [
            scanned_id,
        ],
    }

    r = requests.post(url='https://api.plant.id/check_identifications', data=json.dumps(body),
                      headers={'Content-Type': 'application/json'})

    return r.json()[0].get('suggestions', [])
