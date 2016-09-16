rmi: stop-test
	docker rmi valudio/docker-sinopia 2>&1 > /dev/null

build:
	docker build -t valudio/docker-sinopia:latest .

start-test: stop-test build
	docker run -p 4873:4873 --name sinopia-test -v /home/docker/sinopia-test:/opt/sinopia/storage valudio/docker-sinopia:latest
	docker logs sinopia-test

stop-test:
	-docker rm -f sinopia-test 2>&1 > /dev/null

test: build
	docker run --rm -i -t valudio/docker-sinopia:latest

shell: build
	docker run --rm -i -t valudio/docker-sinopia:latest /bin/bash

logs:
	docker logs sinopia-test

publish:
	docker push valudio/docker-sinopia:latest

test: start-test