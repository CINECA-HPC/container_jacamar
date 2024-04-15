FROM registry.gitlab.com/ecp-ci/ecp-ci.gitlab.io/jacamar-quick-start:latest

WORKDIR /root

RUN apt-get -y update \
&& apt-get install -y git \
&& git clone https://gitlab.com/ecp-ci/jacamar-ci.git \
&& cd jacamar-ci \
&& make build \
&& make install PREFIX=/usr/local \
&& groupadd slurm --gid 12202 \
&& adduser slurm000 --uid 6003 --group slurm --gid 12202 \
&& cd /etc/gitlab-runner \
&& gitlab-runner --version \
&& /opt/jacamar/bin/jacamar --version \
&& id slurm000 \
&& apt-get remove -y git
