#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.7.0
FROM opensearchproject/opensearch@sha256:123e6591a47b1d54686890551bdb35739c85193ecded381219fc9e059e18128f

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.7.0.0-sci-v6/opensearch-alerting-3.7.0.0-sci-v6-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.7.0.0-sci-v3/opensearch-security-analytics-3.7.0.0-sci-v3-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "4baf0f27a47a2082f8d2402c5fcda4212cd99d97a99f7ce029900f7d03abef85  /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "741c6aa79e69f23ad1cbd5b949c9bed40b1444471cb854516494fbadb525c814  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
