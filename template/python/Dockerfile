FROM bde2020/spark-submit:2.4.4-hadoop2.7

LABEL maintainer="Gezim Sejdiu <g.sejdiu@gmail.com>, Giannis Mouchakis <gmouchakis@gmail.com>"

# Copy the source code
COPY . /app

COPY template.sh /

# Copy the requirements.txt first, for separate dependency resolving and downloading
COPY requirements.txt /app/
RUN cd /app \
      && pip3 install -r requirements.txt

CMD ["/bin/bash", "/template.sh"]
