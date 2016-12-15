from celery import Celery, shared_task
from django.conf import settings

app = Celery('webapp')
app.config_from_object('config:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@shared_task
def say_hello():
    print("Hello")
    return True
