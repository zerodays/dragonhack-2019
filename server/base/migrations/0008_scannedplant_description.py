# Generated by Django 2.1.8 on 2019-05-19 00:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0007_specialplant'),
    ]

    operations = [
        migrations.AddField(
            model_name='scannedplant',
            name='description',
            field=models.TextField(blank=True),
        ),
    ]
