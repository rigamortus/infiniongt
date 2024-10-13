ARG PYTHON_VERSION=3.13.0b3
FROM python:${PYTHON_VERSION}-alpine3.19 AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
#ENV DJANGO_SETTINGS_MODULE=quickstartproject.production
RUN apk update && apk add --no-cache strace libcap gcc musl-dev
WORKDIR /app

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

USER appuser

COPY . /app

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "quickstartproject.wsgi:application", "--access-logfile", "-", "--error-logfile", "-"]