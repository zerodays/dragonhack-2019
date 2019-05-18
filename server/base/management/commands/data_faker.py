import datetime
import uuid
from io import BytesIO
from random import randint, uniform

import requests
from PIL import Image
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.core.management import BaseCommand
from django.utils import timezone

from base.models import ScannedPlant


class Command(BaseCommand):
    help = 'Get protected plants'

    def add_arguments(self, parser):
        parser.add_argument('amount', type=int)

    def handle(self, *args, **options):
        for i in range(options['amount']):
            print('Generating {}'.format(i))

            team = randint(0, 1)
            longitude = uniform(14.2, 15.0)
            latitude = uniform(45.7, 46.4)

            names = (
                'taraxacum officinale', 'primula vulgaris', 'allium ursinum', 'convallaria majalis', 'bellis perennis',
                'cyclamen persicum', 'ficus benjamina', 'hedera rhombea',
                'fritillaria meleagris', 'galanthus nivalis', 'ambrosia artemisiifolia', 'amorpha fruticosa',)

            images = ('https://i.ebayimg.com/images/g/MnsAAOSwOA1aPua2/s-l300.jpg',
                      'https://www.thompson-morgan.com/product_images/100/optimised/PRIM-8628-A_h.jpg',
                      'https://img.crocdn.co.uk/images/products2/pl/20/00/03/11/pl2000031122.jpg?width=940&height=940',
                      'https://cdn.shopify.com/s/files/1/1069/2032/products/Convallaria_majalis_1_1024x1024.jpeg?v=1453888584',
                      'https://www.anniesannuals.com/signs/b%20-%20c/images/bellis_perennis_2015.jpg',
                      'https://www.cyclamen.org/wp-content/uploads/2016/09/Description-persicum.jpg',
                      'https://3.imimg.com/data3/AS/YO/MY-6008829/ficus-benjamina-trees-500x500.jpg',
                      'https://live.staticflickr.com/3856/15028952380_f689d59718_b.jpg',
                      'https://cdn.shopify.com/s/files/1/1308/3047/products/fritillaria-meleagris-4_1024x1024.jpg?v=1490797948',
                      'https://lokarochknolar.se/wp-content/uploads/2018/06/Galanthus-Hippolyta-GWI.jpg',
                      'https://keyserver.lucidcentral.org/weeds/data/media/Images/ambrosia_artemisiifolia/ambrosiaartemisiifolia12.jpg',
                      'https://i.etsystatic.com/6879804/r/il/bc5355/1115225345/il_794xN.1115225345_onta.jpg',)

            index = randint(0, len(names) - 1)
            name = names[index]
            image_url = images[index]

            plant = ScannedPlant(name=name, team=team, recognized=True, latitude=latitude, longitude=longitude,
                                 probability=1.0)
            plant.save()

            r = requests.get(image_url)
            image = Image.open(BytesIO(r.content))

            width, height = image.size
            size = min(width, height)
            left = (width - size) / 2
            top = (height - size) / 2
            right = (width + size) / 2
            bottom = (height + size) / 2
            image = image.crop((left, top, right, bottom))

            image_file = BytesIO()
            image.save(fp=image_file, format='JPEG')

            image_name = '{}.jpeg'.format(uuid.uuid4())
            image_path = 'plants/' + image_name
            plant.image.save(image_path,
                             InMemoryUploadedFile(
                                 image_file,
                                 None,
                                 image_name,
                                 'image/jpeg',
                                 image.tell,
                                 None)
                             )
            plant.save()

            start_date = datetime.datetime(year=2019, month=1, day=1)
            end_date = timezone.now()
            max_delta = end_date - start_date

            seconds = randint(0, max_delta.seconds)
            delta = datetime.timedelta(seconds=seconds)
            date = start_date + delta
            plant.date_created = date
            plant.save()
