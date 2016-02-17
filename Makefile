default:
	echo "Do nothing by default, see Makefile"

run-spark-master:
	echo "Spark master WebUI is exposed on 8080 port"
	docker run -d -p 8080:8080 --name spark-master -h spark-master bde2020/spark-master:1.5.1-hadoop2.6

run-spark-worker-cluster:
	echo "Runs 4 Spark workers 3GB RAM(12GB total), 1 core each"
	for number in 1 2 3 4 ; do \
		docker run -d --cpuset-cpus="$$number" --memory="3072M" --memory-swap="3072M" --name spark-worker-$$number --link spark-master:spark-master bde2020/spark-worker:1.5.1-hadoop2.6 ;\
	done

run-cluster: run-spark-master run-spark-worker-cluster

rm-cluster:
	docker stop spark-master
	docker rm spark-master
	for number in 1 2 3 ; do \
		docker stop spark-worker-$$number ;\
		docker rm spark-worker-$$number ;\
	done
