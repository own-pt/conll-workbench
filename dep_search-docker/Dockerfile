FROM ubuntu:16.04

MAINTAINER fchalub@br.ibm.com

WORKDIR /root/

RUN apt-get update -y && apt-get install -y git libsqlite3-dev python-dev cython uwsgi python-flask python3-flask build-essential python3-requests python-requests python-yaml python3-yaml && apt-get clean

COPY setup.sh /root/
COPY setup.bosque.sh /root/
RUN bash setup.sh
RUN bash setup.bosque.sh
COPY corpora.yaml /root/dep_search/webui/
COPY corpus_groups.yaml /root/dep_search/webui/
COPY config_local.py /root/dep_search_serve/
COPY update.bosque.sh /root/
RUN bash update.bosque.sh
COPY run.sh /root/
COPY my_server.py /root/dep_search_serve/
EXPOSE 5000
CMD bash /root/run.sh
