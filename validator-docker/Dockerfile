FROM ubuntu:16.04

MAINTAINER fchalub@br.ibm.com

WORKDIR /root/

RUN apt-get update -y && apt-get install -y git python sbcl screen && apt-get clean

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
  
ADD https://beta.quicklisp.org/quicklisp.lisp /root/quicklisp.lisp
COPY setup-quicklisp.lisp /root/
COPY setup.sh /root/

RUN bash setup.sh

COPY start-server.lisp /root/
COPY start-server.sh /root/

EXPOSE 5000
CMD screen -D -m ./start-server.sh
