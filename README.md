# django-celery-docker-example [![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

**ARCHIVED**: this example is no longer maintained as of 2020-01-19

A very minimal demonstration of how both Django HTTP servers and Celery workers can be run inside Docker containers based off of the same image.

All Django/Celery configuration is under `config/` - there is one example Celery task in `example/celery.py`.

A virtual machine in the form of a Vagrantbox is used as the 'host' system for the Docker daemon and all other needed services (PostgresQL, Redis and RabbitMQ) - so this example should be able to be run on any system.

## Requirements

- Vagrant
- Virtualbox

## Set up

1. Do `vagrant up` in this directory to build and start up the VM - this can take a while. You can look at `Vagrantfile` to see what the set up involves - it installs needed services, builds the Docker image and initializes the database.
2. Do `vagrant ssh`
3. Run `docker run --rm -it --net=host webapp ./manage.py createsuperuser` to create an admin user (optional)

## Running

### Django

Run `docker run --rm --net=host webapp ./manage.py runserver 0.0.0.0:8080` and you should be able to access the website at `localhost:8080` on your local machine.

### Celery

Run `docker run --rm --net=host webapp celery -A config worker` to launch a Celery worker.

### Shell

Run `docker run --rm -it --net=host webapp ./manage.py shell_plus` to get access to a bpython shell. Note that this command may not work from within a `tmux` session.

Assuming you have a Celery worker running, you can despatch the example task with `say_hello.delay()` and see the output in the terminal pane/logs for your Celery worker.

## Development

`pip-tools` is used to manage Python dependencies. Add requirements to `requirements.in` then run `pip-tools compile` or `pip-tools compile --upgrade` to update the `requirements.txt` file.
