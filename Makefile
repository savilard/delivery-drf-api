run-docker-dev:
	sudo DOCKER_BUILDKIT=1 docker compose up --build

migrate-dev:
	sudo docker compose run server ./manage.py migrate

createsuperuser-dev:
	sudo docker compose run server ./manage.py createsuperuser

docker-prod:
	sudo DOCKER_BUILDKIT=1 docker compose -f docker-compose.prod.yml up -d --build

secretkey:
	@poetry run python -c 'from django.utils.crypto import get_random_string; print(get_random_string(40))'
