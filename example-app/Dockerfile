FROM bde2020/spark-submit:1.6.3-hadoop2.8-hive-java8

RUN mkdir -p /app
COPY SparkWrite.jar /app/

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/SparkWrite.jar
ENV SPARK_APPLICATION_MAIN_CLASS org.ermilov.SparkWriteApplication
