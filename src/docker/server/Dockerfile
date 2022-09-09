ARG PYTHON_VERSION=3.9.13
ARG APP_ENV=prod

FROM python:${PYTHON_VERSION}-bullseye AS base-builder

ENV DOCKERIZE_VERSION=v0.6.1 \
    TINI_VERSION=v0.19.0 \
    VIRTUAL_ENV=/opt/venv \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.14 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    POETRY_HOME='/usr/local'

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install --no-install-recommends -y git build-essential gettext libpq-dev curl \
    && curl -sSLO "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -C /usr/local/bin -xzvf "dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && dockerize --version \
    && curl -o /usr/local/bin/tini -sSLO "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini" \
    && chmod +x /usr/local/bin/tini \
    && tini --version \
    && curl -sSL 'https://install.python-poetry.org' | python - \
    && poetry --version \
    && python -m venv ${VIRTUAL_ENV}

# ----------------------------------------------------------------------------------------------------------------------

FROM base-builder as dev-builder

WORKDIR /

COPY pyproject.toml poetry.lock ./
COPY --from=base-builder /usr/local/bin/poetry /usr/local/bin/poetry

RUN poetry export --dev --without-hashes -o requirements.txt \
    && ${VIRTUAL_ENV}/bin/pip install -r requirements.txt

# ----------------------------------------------------------------------------------------------------------------------

FROM base-builder as prod-builder

WORKDIR /

COPY pyproject.toml poetry.lock ./
COPY --from=base-builder /usr/local/bin/poetry /usr/local/bin/poetry

RUN poetry export --without-hashes -o requirements.txt \
    && ${VIRTUAL_ENV}/bin/pip install -r requirements.txt

# ---------------------------------------------------------------

FROM ${APP_ENV}-builder AS builder

# ---------------------------------------------------------------
FROM python:${PYTHON_VERSION}-slim-bullseye AS base

ARG APP_ROOT=/opt/app
ARG APP_USER=appuser
ARG APP_USER_UID=1000

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1

RUN useradd --create-home --uid=${APP_USER_UID} ${APP_USER} \
    && mkdir -p ${VIRTUAL_ENV} \
    && chown ${APP_USER}:${APP_USER} ${VIRTUAL_ENV}

WORKDIR ${APP_ROOT}

# ---------------------------------------------------------------

FROM base AS dev

COPY ./docker/django/wait_db.sh /wait_db.sh
RUN chmod +x '/wait_db.sh'

COPY --from=builder --chown=${APP_USER}:${APP_USER} ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY --from=base-builder --chown=${APP_USER}:${APP_USER} /usr/local/bin/tini /usr/local/bin/tini
COPY --from=base-builder --chown=${APP_USER}:${APP_USER} /usr/local/bin/dockerize /usr/local/bin/dockerize
COPY --chown=${APP_USER}:${APP_USER} . ${APP_ROOT}

RUN SECRET_KEY=empty GIT_PYTHON_REFRESH=quiet YANDEX_GEOCODER_APIKEY=empty python src/manage.py collectstatic --noinput
USER ${APP_USER}

ENTRYPOINT ["tini", "--", "/wait_db.sh"]

# ---------------------------------------------------------------

FROM base AS release
COPY --from=builder --chown=${APP_USER}:${APP_USER} ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY --chown=${APP_USER}:${APP_USER} . ${APP_ROOT}

RUN SECRET_KEY=empty GIT_PYTHON_REFRESH=quiet YANDEX_GEOCODER_APIKEY=empty python src/manage.py collectstatic --noinput

USER ${APP_USER}
EXPOSE 8000
