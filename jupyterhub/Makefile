.PHONY: build-cpu build-gpu run clean deep-clean test run-jupyterlab

VOLUME_MAC="/Volumes/shared"
VOLUME_LIMUX="/mnt/shared"

build-cpu:
	docker build -t jupyter-cpu -f lab/Dockerfile_cpu lab/.

build-gpu:
	docker build -t jupyter-gpu -f lab/Dockerfile_gpu lab/.

run:
		if [ "$(shell uname -s)" == "Darwin" ]; \
		then \
			LOCAL_VOLUME=$(VOLUME_MAC) docker-compose up; \
		else \
			LOCAL_VOLUME=$(VOLUME_LIMUX) docker-compose up; \
		fi

clean:
	docker-compose down -v

deep-clean:
	docker rmi -f jupyter-cpu

run-jupyterlab:
	docker run \
	-dp 8888:8888 \
	-v $(shell pwd)/../../../:/lab \
	-v $(VOLUME_MAC):/home/jovyan/shared \
	--name jupyterlab \
	jupyter-cpu
