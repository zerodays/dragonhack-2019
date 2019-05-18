import requests
from bs4 import BeautifulSoup
from django.core.management import BaseCommand

from base.models import SpecialPlant


class Command(BaseCommand):
    help = 'Get invasive plants'

    def handle(self, *args, **options):
        r = requests.get('https://www.tujerodne-vrste.info/tujerodne-vrste/tujerodne-rastline/')
        soup = BeautifulSoup(r.text, 'html.parser')

        saved = 0
        ignored = 0
        for vrsta in soup.find_all('span', 'gdlr-core-portfolio-info'):
            name = vrsta.contents[0].contents[0].lower()

            if not SpecialPlant.objects.filter(name=name, type=SpecialPlant.INVAZIVNE).exists():
                SpecialPlant(name=name, type=SpecialPlant.INVAZIVNE).save()

                print("Saving '{}'".format(name))
                saved += 1
            else:
                print("'{}' exists. Skipping...".format(name))
                ignored += 1

        print("Saved {} invasive species, already had {} species".format(saved, ignored))
