import urllib.parse

import requests
from bs4 import BeautifulSoup
from django.conf import settings


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
