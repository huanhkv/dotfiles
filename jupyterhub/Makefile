.PHONY: build
build:
	docker build -t jupyter-cpu -f lab/Dockerfile lab/.

.PHONY: run
run:
	docker-compose up

.PHONY: clean
clean:
	docker-compose down -v

.PHONY: deep-clean
deep-clean:
	docker rmi -f jupyter-cpu
