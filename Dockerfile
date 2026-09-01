#  SPDX-FileCopyrightText: 2026 SAP SE or an SAP affiliate company
#  SPDX-License-Identifier: Apache-2.0

# OpenSearch 3.7.0
FROM opensearchproject/opensearch@sha256:123e6591a47b1d54686890551bdb35739c85193ecded381219fc9e059e18128f

LABEL source_repository="https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs.git"

# Download and verify plugin archives
RUN curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-alerting/releases/download/3.7.0.0-sci-v10/opensearch-alerting-3.7.0.0-sci-v10-SNAPSHOT.zip -o /tmp/opensearch-alerting.zip \
 && curl -fsSL https://github.com/SAP-cloud-infrastructure/opensearch-security-analytics/releases/download/3.7.0.0-sci-v10/opensearch-security-analytics-3.7.0.0-sci-v10-SNAPSHOT.zip -o /tmp/opensearch-security-analytics.zip \
 && echo "c6fde6ab78ba0c27add7ed2e22c4363a55318e55ca60a47ab0b27fcf4759f09f /tmp/opensearch-alerting.zip" | sha256sum -c - \
 && echo "8c163deaffba4f45f940216ca8655c8bbb7908c75fbaafdce0fac4668db966e1  /tmp/opensearch-security-analytics.zip" | sha256sum -c -

# Don't change the order!
RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security-analytics \
 && /usr/share/opensearch/bin/opensearch-plugin remove opensearch-alerting \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-alerting.zip \
 && /usr/share/opensearch/bin/opensearch-plugin install --batch file:///tmp/opensearch-security-analytics.zip

# Clean up
RUN rm /tmp/opensearch-alerting.zip /tmp/opensearch-security-analytics.zip
