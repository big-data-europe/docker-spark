FROM bde2020/spark-submit:1.5.1-hadoop2.6

MAINTAINER Cecile Tonglet <cecile.tonglet@tenforce.com>

COPY template.sh /

RUN apt-get update \
      && apt-get install -y python3 python3-setuptools python3-pip \
      && chmod +x /template.sh \
      && mkdir /app

# Copy the requirements.txt first, for separate dependency resolving and downloading
ONBUILD COPY requirements.txt /app
ONBUILD RUN cd /app \
      && pip3 install -r requirements.txt

# Copy the source code
ONBUILD COPY . /app

CMD ["/bin/bash", "/template.sh"]
