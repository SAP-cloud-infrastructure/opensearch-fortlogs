FROM --platform=linux/amd64 keppel.eu-de-1.cloud.sap/ccloud-dockerhub-mirror/opensearchproject/opensearch:3.6.0

LABEL maintainer="Zuzanna Tomaszewska" \
      source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

USER root

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin install --batch https://github.com/thecodingshrimp/opensearch-plugins-alerting/releases/download/v2-custom/opensearch-alerting-3.6.0.0-SNAPSHOT.zip 
RUN /usr/share/opensearch/bin/opensearch-plugin install --batch https://github.com/thecodingshrimp/opensearch-plugin-security-analytics/releases/download/v2-custom/opensearch-security-analytics-3.6.0.0-SNAPSHOT.zip

USER opensearch