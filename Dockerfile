FROM python:3.6
ENV PYTHONUNBUFFERED 1
ENV TERM xterm

COPY ./requirements.txt /
RUN pip install -r /requirements.txt

COPY . /
