#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.9.0
FROM opensearchproject/opensearch@sha256:3b55f6b6249cfdb92b52ee59adc8a266203ba9ef9f5d82544fad6f1af2f3609e

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.9.0.0-sci-v1/opensearch-alerting-3.9.0.0-sci-v1-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.9.0.0-sci-v1/opensearch-security-analytics-3.9.0.0-sci-v1-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "ba1e295e32c04ea41b13c9d168f9fa0485418ec1a234cb74ac1574c56fb7a4d2 /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "80f222d8b05a69d570a903b0cc65350247b167d406b8c13415612f7dc33090f0  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
