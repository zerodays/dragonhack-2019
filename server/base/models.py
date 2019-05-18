from django.db import models


class Plant(models.Model):
    name = models.CharField(max_length=256, unique=True)
    description = models.TextField()


class ScannedPlant(models.Model):
    team = models.IntegerField()  # 0 for one team, 1 for the other
    recognized = models.BooleanField(default=False)

    latitude = models.FloatField()
    longitude = models.FloatField()

    image = models.ImageField(null=True)

    plant = models.ForeignKey(Plant, on_delete=models.CASCADE, null=True)

    date_created = models.DateTimeField(auto_now_add=True)
