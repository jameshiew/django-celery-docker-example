# webapp
Example web app composed of Docker containers - spin up both Django and Celery workers from the same image.

## Preparation
Run `docker build . -t webapp` to build the image.

As a privileged Postgres user (e.g. `postgres`), run the following SQL in `psql` to create the database (adapted from https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-django-application-on-ubuntu-14-04). 

```sql
CREATE DATABASE webapp_db;
CREATE USER webapp with password 'webapp';
ALTER ROLE webapp SET client_encoding TO 'utf8';
ALTER ROLE webapp SET default_transaction_isolation TO 'read committed';
ALTER ROLE webapp SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE webapp_db TO webapp;
```

## Running
The following commands assume you have Redis, RabbitMQ and Postgres running on your localhost with the default settings. If not, you can use the provided Vagrant configuration to build a Vagrantbox with all needed services. The commands should be the same. At the time of writing, host networking is broken on Docker for Mac - see https://forums.docker.com/t/should-docker-run-net-host-work/14215 .

### Django
Run `docker run --rm --net=host webapp ./manage.py migrate` to migrate the database.

Run `docker run --rm --net=host webapp ./manage.py runserver 0.0.0.0:8080` and you should be able to access the website at `localhost:8080`.

### Celery
Run `docker run --rm --net=host webapp celery -A config worker` to launch a Celery worker.

### Shell
Run `docker run --rm -it --net=host webapp ./manage.py shell_plus` to get access to a bpython shell.
