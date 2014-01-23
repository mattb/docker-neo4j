FROM stackbrew/ubuntu:raring

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://us.archive.ubuntu.com/ubuntu raring main universe" > /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu raring main" > /etc/apt/sources.list.d/webupd8team-java-raring.list
RUN apt-get update

# accept java license
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections

# basic stuff
RUN apt-get install -y --force-yes curl oracle-java7-installer 

RUN curl -o /opt/neo4j.tar.gz 'http://download.neo4j.org/artifact?edition=community&version=2.0.0&distribution=tarball&dlid=3123375'
RUN cd /opt ; tar xzf /opt/neo4j.tar.gz

EXPOSE 7474

CMD ["/opt/neo4j-community-2.0.0/bin/neo4j","console"]

