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

        saved, ignored = 0, 0
        for data in table_data:
            contents = data.contents
            if len(contents) == 0:
                continue

            content = contents[0]
            if content.name != 'i':
                continue

            contents = content.contents
            if len(contents) == 0:
                continue

            content = contents[0]
            if content.name != 'a':
                continue

            name = content.contents[0].lower().strip()

            if not SpecialPlant.objects.filter(name=name, type=SpecialPlant.ZASCITENE).exists():
                SpecialPlant(name=name, type=SpecialPlant.ZASCITENE).save()

                print("Saving '{}'".format(name))
                saved += 1
            else:
                print("'{}' exists. Skipping...".format(name))
                ignored += 1

        print("Saved {} protected species, already have {} species".format(saved, ignored))
