network:
	docker network create spark-net

spark:
	docker-compose -f docker-compose-minimal.yml build
	docker-compose -f docker-compose-minimal.yml up -d

spark-app:
	docker-compose -f docker-compose-spark-app.yml build
	docker-compose -f docker-compose-spark-app.yml up
