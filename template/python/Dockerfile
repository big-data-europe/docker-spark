FROM bde2020/spark-submit:3.1.1-hadoop3.2

LABEL maintainer="Gezim Sejdiu <g.sejdiu@gmail.com>, Giannis Mouchakis <gmouchakis@gmail.com>"

# Copy the source code
COPY . /app

COPY template.sh /

# Copy the requirements.txt first, for separate dependency resolving and downloading
COPY requirements.txt /app/
RUN cd /app \
      && pip3 install -r requirements.txt

CMD ["/bin/bash", "/template.sh"]
