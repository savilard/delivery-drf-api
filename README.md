# Сайт доставки еды Star Burger

Это сайт сети ресторанов Star Burger. Здесь можно заказать превосходные бургеры с доставкой на дом.

![скриншот сайта](https://dvmn.org/filer/canonical/1594651635/686/)


Сеть Star Burger объединяет несколько ресторанов, действующих под единой франшизой. У всех ресторанов одинаковое меню и одинаковые цены. Просто выберите блюдо из меню на сайте и укажите место доставки. Мы сами найдём ближайший к вам ресторан, всё приготовим и привезём.

На сайте есть три независимых интерфейса. Первый — это публичная часть, где можно выбрать блюда из меню, и быстро оформить заказ без регистрации и SMS.

Второй интерфейс предназначен для менеджера. Здесь происходит обработка заказов. Менеджер видит поступившие новые заказы и первым делом созванивается с клиентом, чтобы подтвердить заказ. После оператор выбирает ближайший ресторан и передаёт туда заказ на исполнение. Там всё приготовят и сами доставят еду клиенту.

Третий интерфейс — это админка. Преимущественно им пользуются программисты при разработке сайта. Также сюда заходит менеджер, чтобы обновить меню ресторанов Star Burger.

## Подготовительные работы:
1. Установите [docker](https://docs.docker.com/get-docker/) и [docker compose v2](https://docs.docker.com/compose/cli-command/#installing-compose-v2);
2. Скачайте код:
```shell
git clone https://github.com/savilard/delivery-drf-api.git
```
3. Перейдите в каталог проекта:
```shell
cd  delivery-drf-api
```

## Как запустить dev-версию
1. Для запуска dev версии сайта выполните команду:
```shell
make docker-dev
```
2. В новом терминале не выключая сайт запустите команды для настройки базы данных:
```shell
make migrate-dev
make createsuperuser-dev
```

## Как запустить prod-версию в docker
1. Настройте ssl сертификат с помощью [certbot](https://certbot.eff.org/);
2. Переименуйте файл nginx.conf.example в nginx.conf;
3. Замените example.com на адрес своего сайта, example_ip на ip хостинга;
4. Выполните команду:
```bash
make docker-prod
```

## Как настроить Rollbar

1. Зарегистрируйтесь в [Rollbar](https://rollbar.com/);
2. Когда речь зайдёт о SDK, выбирайте Django;
3. В `.env` файл добавьте:
- `ROLLBAR_ACCESS_TOKEN` - токен для доступа к Rollbar,
- `ROLLBAR_ENVIRONMENT` - название окружения.


## Переменные окружения
`SECRET_KEY` -- обязательная секретная настройка Django. Это соль для генерации хэшей. Значение может быть любым, важно лишь, чтобы оно никому не было известно. [Документация Django](https://docs.djangoproject.com/en/3.2/ref/settings/#secret-key).

`DEBUG` -- настройка Django для включения отладочного режима. Принимает значения `TRUE` или `FALSE`. [Документация Django](https://docs.djangoproject.com/en/3.2/ref/settings/#std:setting-DEBUG).

`ALLOWED_HOSTS` -- настройка Django со списком разрешённых адресов. Если запрос прилетит на другой адрес, то сайт ответит ошибкой 400. Можно перечислить несколько адресов через запятую, например `127.0.0.1,192.168.0.1,site.test`. [Документация Django](https://docs.djangoproject.com/en/3.2/ref/settings/#allowed-hosts).

`DATABASE_URL` -- адрес для подключения к базе данных PostgreSQL. Другие СУБД сайт не поддерживает. [Формат записи](https://github.com/jacobian/dj-database-url#url-schema).

`POSTGRES_PASSWORD` -- пароль от postgresql.

`YANDEX_GEOCODER_APIKEY` - API ключ от Яндекс-геокодера. Получаем [тут](https://developer.tech.yandex.ru/).



## Как деплоить
```shell
./deploy.sh
```
