# Set base image
FROM ubuntu:18.04
#Set the working directory in the container
COPY . /

RUN apt-get update && apt-get install -y lsb-release \
  && apt-get install -y wget \
  && apt-get install -y gnupg2

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -


RUN apt-get update -y && apt-get install -y curl \
  && apt-get install -y python3-pip \
  && apt-get -y install libpq-dev \
  && apt-get -y install git \
  && apt-get -y install postgresql-client-14

RUN psql -V
RUN pg_dump -V
  
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN pip3 install boto3 \
  && pip3 install botocore \
  && pip3 install psycopg2-binary \ 
  && pip3 install --no-cache-dir rfc5424-logging-handler

WORKDIR /
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
