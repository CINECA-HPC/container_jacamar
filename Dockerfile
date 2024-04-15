Bootstrap: docker
From: registry.gitlab.com/ecp-ci/ecp-ci.gitlab.io/jacamar-quick-start:latest

%files
	jacamar-ci-0.14.0-1.el7.x86_64.rpm /etc/gitlab-runner/
%post
	apt-get -y update
	apt-get -y git
	git clone https://gitlab.com/ecp-ci/jacamar-ci.git
	cd jacamar-ci
	make build
	make install PREFIX=/usr/local
	groupadd slurm --gid 12202
	adduser slurm000 --uid 6003 --group slurm --gid 12202
	cd /etc/gitlab-runner
	rpm -qlp jacamar-ci-*.rpm
	rpm -i jacamar-ci-*.el7.x86_64.rpm
	gitlab-runner --version
	/opt/jacamar/bin/jacamar --version
	id slurm000