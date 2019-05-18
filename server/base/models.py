from django.db import models


class ScannedPlant(models.Model):
    team = models.IntegerField()  # 0 for one team, 1 for the other
    recognized = models.BooleanField(default=False)

    latitude = models.FloatField()
    longitude = models.FloatField()

    image = models.ImageField(null=True)
