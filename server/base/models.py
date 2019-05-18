from django.db import models


class ScannedPlant(models.Model):
    team = models.IntegerField()  # 0 for one team, 1 for the other
    recognized = models.BooleanField(default=False)

    latitude = models.FloatField()
    longitude = models.FloatField()

    image = models.ImageField(null=True, blank=True)

    name = models.CharField(max_length=256, blank=True)
    probability = models.FloatField(null=True, blank=True)

    date_created = models.DateTimeField(auto_now_add=True)


class SpecialPlant(models.Model):
    INVAZIVNE = 'IN'
    ZASCITENE = 'ZA'
    TYPE = (
        (INVAZIVNE, 'invasive'),
        (ZASCITENE, 'protected'),
    )

    name = models.CharField(max_length=256)
    type = models.CharField(max_length=2, choices=TYPE)
