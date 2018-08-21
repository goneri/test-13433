FROM       centos
MAINTAINER Gonéri Le Bouder <goneri@lebouder.net>

RUN yum -y update && yum clean all
RUN yum install -y https://packages.distributed-ci.io/dci-release.el7.noarch.rpm
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y dci-ansible-agent && yum clean all

COPY dcirc.sh /etc/dci-ansible-agent/dcirc.sh
COPY test-13433.yml /usr/share/dci-ansible-agent
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

RUN cd /usr/lib/python2.7/site-packages && curl 'https://softwarefactory-project.io/r/changes/13433/revisions/391ff541ef45306991a30d91340e035bad185cdb/archive?format=tar'| tar x
USER dci-ansible-agent
WORKDIR /usr/share/dci-ansible-agent
CMD ["/usr/bin/ansible-playbook",  "-vv", "/usr/share/dci-ansible-agent/test-13433.yml"]
