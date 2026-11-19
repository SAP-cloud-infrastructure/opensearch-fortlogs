#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.9.0
FROM opensearchproject/opensearch@sha256:3b55f6b6249cfdb92b52ee59adc8a266203ba9ef9f5d82544fad6f1af2f3609e

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.9.0.0-sci-v5/opensearch-alerting-3.9.0.0-sci-v5-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.9.0.0-sci-v4/opensearch-security-analytics-3.9.0.0-sci-v4-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "f1cd44dd7573d4b6d7f1b852e3aa69e8607c77b5ac336909bd6bf17796ea7d42 /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "cafc6fbd14a599cf3e83a691e87c652557928fe1bf06a2a2e3cfdcf0ba5c89b8 /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
