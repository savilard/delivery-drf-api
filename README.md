# Star Burger food delivery website

This is the website of the Star Burger restaurant chain. Here you can order excellent burgers with home delivery.

![скриншот сайта](https://dvmn.org/filer/canonical/1594651635/686/)

---

![code climate](https://img.shields.io/codeclimate/maintainability/savilard/delivery-drf-api?style=for-the-badge)
![github actions](https://img.shields.io/github/actions/workflow/status/savilard/delivery-drf-api/main.yml?branch=main)
![python](https://img.shields.io/badge/python-3.9-brightgreen?style=for-the-badge)
![license](https://img.shields.io/github/license/savilard/delivery-drf-api?style=for-the-badge)
[![wemake-python-styleguide](https://img.shields.io/badge/style-wemake-000000.svg?style=for-the-badge)](https://github.com/wemake-services/wemake-python-styleguide)


The Star Burger chain consists of several restaurants operating under a single franchise. All restaurants have the same menu and the same prices. Just choose a dish from the menu on the site and specify the place of delivery. We will find the nearest restaurant to you, prepare everything and bring it to you.

The site has three independent interfaces. The first is the public part, where you can select dishes from the menu and quickly place an order without registration and SMS.

The second interface is designed for the manager. This is where the processing of orders takes place. The manager sees new orders and first of all calls the client to confirm the order. After that, the operator chooses the nearest restaurant and passes the order for execution there. There everything is prepared and the food is delivered to the client.

The third interface - this is the admin panel. It is mainly used by programmers when developing the site. The manager also comes here to update the menu of Star Burger restaurants.

## Contents

<!-- TOC -->
  * [Preparatory works](#preparatory-works)
  * [How to configure the dev version of the site](#how-to-configure-the-dev-version-of-the-site)
  * [How to update the database schema](#how-to-update-the-database-schema)
  * [How to run a prod-version in docker](#how-to-run-a-prod-version-in-docker)
  * [How to configure Rollbar](#how-to-configure-rollbar)
  * [How to run flake8](#how-to-run-flake8)
  * [Environment variables](#environment-variables)
  * [How to Deploy](#how-to-deploy)
<!-- TOC -->


## Preparatory works
1. Setup [docker](https://docs.docker.com/get-docker/) and [docker compose v2](https://docs.docker.com/compose/cli-command/#installing-compose-v2);
2. Download the code:
```shell
git clone https://github.com/savilard/delivery-drf-api.git
```
3. Go to the project directory:
```shell
cd  delivery-drf-api
```

## How to configure the dev version of the site
1. To configure the dev version of the site run the command:
```shell
./scripts/setup.sh
```
As a result of the script:
- The database will be filled with test data;
- will create a superuser with login `superuser` and password `superpassword` (or the ones set in the environment variables `DJANGO_SUPERUSER_USERNAME` and `DJANGO_SUPERUSER_PASSWORD`).
2. Start the docker containers:
```shell
docker compose up
```

The site will be available at [127.0.0.1:8080](http://127.0.0.1:8080). Login to the admin area at [http://127.0.0.1:8080/admin/](http://127.0.0.1:8080/admin/). Order list at [http://127.0.0.1:8080/manager/orders/](http://127.0.0.1:8080/manager/orders/)

To fine-tune the site, use environment variables, as is common with Docker Compose. A list of available variables can be found inside the `docker-compose.yml` file.


## How to update the database schema
1. Start the docker containers (if they are not running):
```shell
docker compose up --build
```
2. In a new terminal tab, without shutting down the site, run the command:
```shell
docker-compose run --rm backend ./manage.py migrate
```

## How to run a prod-version in docker
1. Configure the ssl certificate with [certbot](https://certbot.eff.org/);
2. Rename the nginx.conf.example file to nginx.conf;
3. Replace example.com with the address of your site, example_ip with the hosting ip;
4. Run the command:
```bash
make docker-prod
```


## How to configure Rollbar

1. Sign up at [Rollbar](https://rollbar.com/);
2. When it comes to SDKs, choose Django;
3. In the `.env` file add:
- `ROLLBAR_ACCESS_TOKEN` - token to access Rollbar;
- `ROLLBAR_ENVIRONMENT` - environment name.


## How to run flake8
```shell
docker compose run --rm backend sh -c "flake8"
```


## Environment variables
`SECRET_KEY` is Django's mandatory secret setting. This is salt for hash generation. The value can be anything, as long as it is not known to anyone. [Django documentation](https://docs.djangoproject.com/en/3.2/ref/settings/#secret-key).

`DEBUG` -- Django setting to enable debug mode. Accepts `TRUE` or `FALSE`. [Django documentation](https://docs.djangoproject.com/en/3.2/ref/settings/#std:setting-DEBUG).

`ALLOWED_HOSTS` -- a Django setting with a list of allowed addresses. If the request arrives at a different address, the site will respond with a 400 error. You can list multiple addresses separated by commas, such as `127.0.0.1,192.168.0.1,site.test`. [Django documentation](https://docs.djangoproject.com/en/3.2/ref/settings/#allowed-hosts).

`DATABASE_URL` -- the address to connect to a PostgreSQL database. Other DBMS site does not support. [Record format](https://github.com/jacobian/dj-database-url#url-schema).

`POSTGRES_PASSWORD` -- password from postgresql.

`YANDEX_GEOCODER_APIKEY` -- API key from Yandex geocoder. Get it [here](https://developer.tech.yandex.ru/).

`DJANGO_SUPERUSER_USERNAME` -- username of the superuser account.

`DANGO_SUPERUSER_EMAIL` -- email of the superuser account.

`DANGO_SUPERUSER_PASSWORD` -- password for the superuser account.


## How to Deploy
```shell
./deploy.sh
```
