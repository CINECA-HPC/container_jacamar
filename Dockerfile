FROM ubuntu:latest

WORKDIR /root

RUN curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | bash \
&& apt-get update \
&& apt-get install -y make git golang libseccomp-dev gitlab-runner \
&& git clone https://gitlab.com/ecp-ci/jacamar-ci.git \
&& cd jacamar-ci \
&& make \
&& make install PREFIX=/usr/local \
&& groupadd slurm --gid 12202 \
&& adduser --disabled-password --gecos "" --uid 6003 --ingroup slurm slurm000 \
&& cd /etc/gitlab-runner \
&& gitlab-runner --version \
&& /opt/jacamar/bin/jacamar --version \
&& id slurm000 \
&& apt-get remove -y git make
