# syntax = docker/dockerfile:1.3-labs

ARG PYTHON_VERSION=3.9.6

FROM python:${PYTHON_VERSION}-slim-buster AS base

ENV DOCKERIZE_VERSION=v0.6.1 \
    TINI_VERSION=v0.19.0 \
    VIRTUAL_ENV=/opt/venv

RUN <<EOF
  apt-get update
  apt-get install --no-install-recommends -y git build-essential gettext libpq-dev wget
  wget "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz"
  tar -C /usr/local/bin -xzvf "dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz"
  dockerize --version
  wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini"
  chmod +x /usr/local/bin/tini
  tini --version
  python -m venv ${VIRTUAL_ENV}
EOF

COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip \
    ${VIRTUAL_ENV}/bin/pip install -r requirements.txt

# ---------------------------------------------------------------

FROM python:${PYTHON_VERSION}-slim-buster AS final

ARG APP_ROOT=/opt/app

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1        \
    GIT_PYTHON_REFRESH=quiet

RUN mkdir -p ${VIRTUAL_ENV}
WORKDIR ${APP_ROOT}

COPY ./docker/server/wait_db.sh /wait_db.sh
RUN chmod +x '/wait_db.sh'

COPY --from=base ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY --from=base /usr/local/bin/tini /usr/local/bin/tini
COPY --from=base /usr/local/bin/dockerize /usr/local/bin/dockerize
COPY . ${APP_ROOT}

RUN python manage.py collectstatic --noinput

ENTRYPOINT ["tini", "--", "/wait_db.sh"]
