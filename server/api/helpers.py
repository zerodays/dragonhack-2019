import json
import time
import urllib.parse

import requests
from bs4 import BeautifulSoup
from django.conf import settings
from django.http import HttpResponse

from base.models import SpecialPlant


def get_flower_description(name):
    query_param = urllib.parse.urlencode({'q': name})
    url = 'https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/WebSearchAPI?autoCorrect=true&pageNumber=1&pageSize=1&safeSearch=false&{}'.format(
        query_param)
    headers = {
        'X-RapidAPI-Host': 'contextualwebsearch-websearch-v1.p.rapidapi.com',
        'X-RapidAPI-Key': settings.RAPID_API_KEY,
    }

    r = requests.get(url, headers=headers)
    data = r.json()
    results = data.get('value', [])
    if len(results) == 0:
        return 'Missing description'

    description = results[0]['description']

    soup = BeautifulSoup(description, 'html.parser')
    description = soup.get_text()

    return description


def plant_to_dictionary(plant):
    invasive = SpecialPlant.objects.filter(name=plant.name, type=SpecialPlant.INVAZIVNE).exists()
    protected = SpecialPlant.objects.filter(name=plant.name, type=SpecialPlant.ZASCITENE).exists()

    return {
        'name': plant.name.title(),
        'description': get_flower_description(plant.name),
        'image_url': plant.image.url,
        'latitude': plant.latitude,
        'longitude': plant.longitude,
        'date_scanned': plant.date_created.strftime('%d. %b %Y %H:%M'),
        'invasive': invasive,
        'protected': protected,
        'team': plant.team,
    }


def dictionary_to_response(dictonary):
    return HttpResponse(json.dumps(dictonary), content_type='application/json')


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
