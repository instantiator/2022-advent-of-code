FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install git

RUN apt-get -y install gcc
RUN apt-get -y install libasound2-dev
RUN apt-get -y install libpulse-dev
RUN apt-get -y install libx11-dev
RUN apt-get -y install libxext-dev
RUN apt-get -y install xvfb
RUN git clone https://github.com/scarybeasts/beebjit.git
RUN cd beebjit && xvfb-run ./build.sh

RUN apt-get -y install perl
COPY scripts/mmb_utils.tar .
RUN mkdir /usr/local/beeb
RUN cd /usr/local/beeb && tar xvf /mmb_utils.tar
RUN ln -s /usr/local/beeb/beeb /usr/local/bin/beeb

COPY  scripts/prep-disk-and-launch.sh /prep-disk-and-launch.sh
ENTRYPOINT [ "./prep-disk-and-launch.sh" ]
