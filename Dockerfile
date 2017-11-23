FROM python:3
ENV PYTHONUNBUFFERED 1
ENV TERM xterm

COPY ./requirements.txt /
RUN pip install -r /requirements.txt

COPY . /
