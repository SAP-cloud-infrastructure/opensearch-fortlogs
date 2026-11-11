#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.8.0
FROM opensearchproject/opensearch@sha256:bcc1797519726ceb6d651d4a3e60b7c30da91793914a8dfe75fd441d4f641509

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.8.0.0-sci-v4/opensearch-alerting-3.8.0.0-sci-v4-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.8.0.0-sci-v5/opensearch-security-analytics-3.8.0.0-sci-v5-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "5a85e766b87f822d1220f0b72b700d82537df622ec982fa7e48452305c9409c2 /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "e24c8e9d4abdc5dbf92da051390146edee24af53397ebb89e2728be115b29627  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
