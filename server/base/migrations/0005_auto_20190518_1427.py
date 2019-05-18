# Generated by Django 2.1.8 on 2019-05-18 14:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0004_auto_20190518_1235'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='scannedplant',
            name='plant',
        ),
        migrations.AddField(
            model_name='scannedplant',
            name='plant_name',
            field=models.CharField(blank=True, max_length=256),
        ),
        migrations.AddField(
            model_name='scannedplant',
            name='probability',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='scannedplant',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to=''),
        ),
        migrations.DeleteModel(
            name='Plant',
        ),
    ]
