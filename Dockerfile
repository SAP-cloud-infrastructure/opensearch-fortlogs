#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.7.0
FROM opensearchproject/opensearch@sha256:123e6591a47b1d54686890551bdb35739c85193ecded381219fc9e059e18128f

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.7.0.0-sci-v8/opensearch-alerting-3.7.0.0-sci-v8-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.7.0.0-sci-v6/opensearch-security-analytics-3.7.0.0-sci-v6-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "0c7e629389e35c6e3cf1862f2a0181594a8f58b6f4b9ab38c06a7c352f40c302 /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "99f74502b8561049b7289e0fe9fb1ee0c29caef8d1ef154c20a16437db287bbc  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
