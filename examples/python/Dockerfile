FROM bde2020/spark-python-template:3.1.1-hadoop3.2
	  
COPY wordcount.py /app/

ENV SPARK_APPLICATION_PYTHON_LOCATION /app/wordcount.py
ENV SPARK_APPLICATION_ARGS "/spark/README.md"