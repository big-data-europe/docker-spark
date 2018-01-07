current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build: download-example-app
	docker build -t bde2020/spark-base:$(current_branch) ./base
	docker build -t bde2020/spark-master:$(current_branch) ./master
	docker build -t bde2020/spark-worker:$(current_branch) ./worker
	docker build -t bde2020/spark-submit:$(current_branch) ./submit
	docker build -t bde2020/spark-example:$(current_branch) ./example-app

test:
	docker-compose -f docker-compose.yml up -d
	docker logs -f spark-app

download-example-app:
	if [ ! -f example-app/SparkWrite.jar ]; then \
	wget -O example-app/SparkWrite.jar https://www.dropbox.com/s/anct7cbd052200a/SparkWrite-1.6.3.jar ; \
	fi
