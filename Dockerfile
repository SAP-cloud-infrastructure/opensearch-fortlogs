#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.7.0
FROM opensearchproject/opensearch@sha256:bcc1797519726ceb6d651d4a3e60b7c30da91793914a8dfe75fd441d4f641509

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.8.0.0-sci-v1/opensearch-alerting-3.8.0.0-sci-v1-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.8.0.0-sci-v3/opensearch-security-analytics-3.8.0.0-sci-v3-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "a0a96da9153ebe2bed15e22b36a5e8f84f0c086c2c04fd0c9c59cf78304af551 /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "3836d69c8f6457e719aff0465b224996bebb2eb070dcd48278a0f7388be38e28  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
