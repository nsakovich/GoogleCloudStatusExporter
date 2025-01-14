app_tag_name = norbega/gcp-status-exporter
version = v1.1.2

build:
	docker build \
		-t $(app_tag_name):$(version) -f docker/Dockerfile .

push:
	docker push $(app_tag_name):$(version)

install-test-requirements:
	pip install -r src/requirements.txt

tests:
	python -m unittest -vvv test.test_main

run-local:
	docker run -d --name gcp-exporter -p '9118:9118' -e MANAGE_ALL_EVENTS=True $(app_tag_name):$(version)

bash-local:
	docker exec -ti gcp-exporter sh

stop-local:
	docker rm -f  gcp-exporter

create-tag:
	git tag -a $(version)
	git push origin --tags

.PHONY: build push run-local stop-local create-tag install-test-requirements tests
