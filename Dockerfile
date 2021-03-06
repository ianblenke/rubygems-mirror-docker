FROM eg5846/ubuntu-docker:trusty 
MAINTAINER Andreas Egner <andreas.egner@web.de>

#ENV http_proxy http://192.168.1.10:800/
#ENV https_proxy https://192.168.1.10:800/
ENV HOME /root

# Update system and install packages
RUN \
  apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install -y --no-install-recommends git ruby && \
  apt-get autoremove -y && \
  apt-get clean

# Install ruby gems
RUN \
  /usr/bin/gem install rake -v 10.4.2 --no-rdoc --no-ri && \
  /usr/bin/gem install hoe -v 3.8.1 --no-rdoc --no-ri && \
  /usr/bin/gem install net-http-persistent -v 2.9.4 --no-rdoc --no-ri

# Install and configure rubygems-mirror
RUN \
  git clone https://github.com/huacnlee/rubygems-mirror.git && \
  mkdir -p /mirror/rubygems.org
ADD mirrorrc /root/.gem/.mirrorrc

# Install run.sh
ADD run.sh /run.sh
RUN chmod 0755 /run.sh

VOLUME ["/mirror/rubygems.org"]

CMD ["/run.sh"]
