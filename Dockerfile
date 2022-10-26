FROM python:3.10.4

ENV PYTHONBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /app

RUN apt-get -y update \
    && apt-get install -y build-essential \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/

RUN python -m pip install --upgrade pip  \
    && pip install -r requirements.txt \
    && useradd -ms /bin/bash 1000

COPY --chown=1000:1000 . /app/

CMD python manage.py runserver 0.0.0.0:8000

USER 1000