from django.core.management import BaseCommand

from bs4 import BeautifulSoup
import requests

from base.models import SpecialPlant


class Command(BaseCommand):
    help = 'Get protected plants'

    def handle(self, *args, **options):
        r = requests.get('https://sl.wikipedia.org/wiki/Seznam_zavarovanih_domorodnih_rastlinskih_vrst_v_Sloveniji')
        soup = BeautifulSoup(r.text, 'html.parser')

        table_data = soup.find_all('td')
        for data in table_data:
            contents = data.contents
            if len(contents) == 0:
                continue

