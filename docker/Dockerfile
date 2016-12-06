FROM ubuntu:16.04

MAINTAINER fchalub@br.ibm.com

WORKDIR /root/

RUN apt-get update -y && apt-get install -y bzip2 git python sbcl && apt-get clean
  
ADD https://beta.quicklisp.org/quicklisp.lisp /root/quicklisp.lisp
COPY setup-quicklisp.lisp /root/
COPY setup.sh /root/
COPY start-server.lisp /root/
COPY start-server.sh /root/

RUN bash setup.sh

CMD /root/start-server.sh
