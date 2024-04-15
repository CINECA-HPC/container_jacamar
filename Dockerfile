FROM registry.gitlab.com/ecp-ci/ecp-ci.gitlab.io/jacamar-quick-start:latest

WORKDIR /root

RUN apt-get -y update
RUN apt-get install -y git
RUN git clone https://gitlab.com/ecp-ci/jacamar-ci.git
RUN cd jacamar-ci
RUN make build
RUN make install PREFIX=/usr/local
RUN groupadd slurm --gid 12202
RUN adduser slurm000 --uid 6003 --group slurm --gid 12202
RUN cd /etc/gitlab-runner
RUN gitlab-runner --version
RUN /opt/jacamar/bin/jacamar --version
RUN id slurm000
RUN apt-get remove -y git
