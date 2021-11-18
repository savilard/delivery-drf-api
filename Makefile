docker-dev:
	sudo DOCKER_BUILDKIT=1 docker compose up -d --build

docker-prod:
	sudo DOCKER_BUILDKIT=1 docker compose -f docker-compose.prod.yml up -d --build

secretkey:
	@poetry run python -c 'from django.utils.crypto import get_random_string; print(get_random_string(40))'
