FROM openjdk:11
MAINTAINER <innocentakomagbe@gmail.com>

RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    supervisor \
    apt-utils \
    curl \
    wget \
    && rm -r /var/lib/apt/lists/*

# Import GPG key
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list

# elasticsearch
RUN apt-get update && \
    apt-get install --no-install-recommends -y elasticsearch && \
    apt-get clean

COPY elasticsearch/config/elasticsearch.yml /etc/elasticsearch/

# nginx
RUN apt-get update && apt-get install -y --no-install-recommends nginx openssl coreutils

# kibana
RUN apt-get update && apt-get install --no-install-recommends -y kibana
RUN echo "root:HXRhDv0apO5.g" | tee -a /etc/nginx/htpasswd.users

COPY kibana/kiabana.conf /etc/nginx/sites-available/
COPY nginx.conf /etc/nginx/
RUN rm /etc/nginx/sites-available/default
RUN  ln -s /etc/nginx/sites-available/kiabana.conf /etc/nginx/sites-enabled/kiabana.conf


# logstash
RUN apt-get update && apt-get install --no-install-recommends -y logstash
COPY logstash/pipelines.yml /usr/share/logstash/config/pipelines.yml

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV JAVA_HOME /usr/local/openjdk-11/
ENV discovery.type single-node

EXPOSE 80 9200
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]