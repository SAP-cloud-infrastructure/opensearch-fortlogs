#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.8.0
FROM opensearchproject/opensearch@sha256:bcc1797519726ceb6d651d4a3e60b7c30da91793914a8dfe75fd441d4f641509

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.8.0.0-sci-v6/opensearch-alerting-3.8.0.0-sci-v6-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.8.0.0-sci-v7/opensearch-security-analytics-3.8.0.0-sci-v7-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "993cfd85284789e65d4a7c260495ab0e94fa0e96accd35814584dece738d2abe /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "309b4559a2174b002acb1eab838889ba536c4281b39253b50c8aec1166a6f25a  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip
 
# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip