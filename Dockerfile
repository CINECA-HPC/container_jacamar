FROM ubuntu:latest

WORKDIR /root

RUN apt-get -y update \
&& apt-get install -y make git golang libseccomp2 \
&& git clone https://gitlab.com/ecp-ci/jacamar-ci.git \
&& cd jacamar-ci \
&& make \
&& make install PREFIX=/usr/local
RUN groupadd slurm --gid 12202
RUN adduser slurm000 --uid 6003 --group slurm --gid 12202
RUN cd /etc/gitlab-runner
RUN gitlab-runner --version
RUN /opt/jacamar/bin/jacamar --version
RUN id slurm000
RUN apt-get remove -y git
