from django.urls import path

from . import views

urlpatterns = [
    path('scan', views.scan_view, name='api_scan'),
    path('history', views.history_view, name='api_history'),
    path('percentage', views.percentage_view, name='api_percentage'),
]
