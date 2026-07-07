#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.7.0
FROM opensearchproject/opensearch@sha256:123e6591a47b1d54686890551bdb35739c85193ecded381219fc9e059e18128f

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.7.0.0-sci-v5/opensearch-alerting-3.7.0.0-sci-v5-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.7.0.0-sci-v2/opensearch-security-analytics-3.7.0.0-sci-v2-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "2d0d7f413de7ec30713b995ae24c517b59bebb45ca51e656a50870371d3421bf  /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "67d7dcf47a250f1034fd02f840b19525812799e84e9d753cf77876a7328c94fc  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
