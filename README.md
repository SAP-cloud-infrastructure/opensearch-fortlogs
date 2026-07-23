# opensearch-fortlogs

[![REUSE status](https://api.reuse.software/badge/github.com/SAP-cloud-infrastructure/opensearch-fortlogs)](https://api.reuse.software/info/github.com/SAP-cloud-infrastructure/opensearch-fortlogs)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSES/Apache-2.0.txt)

Custom OpenSearch Docker image that replaces the bundled `opensearch-security-analytics` and `opensearch-alerting` plugins with patched builds containing upstream fixes not yet merged.

## Why

Upstream PRs with critical fixes are open but unmerged. This image ships those fixes by installing plugin ZIPs built from source branches before the patches land in an official release.

## Base image

`opensearchproject/opensearch:3.7.0` (linux/amd64)

## What this image does

1. Removes the stock `opensearch-security-analytics` and `opensearch-alerting` plugins.
2. Installs custom-built plugin ZIPs that include the patches listed below.

> **Order matters.** Do not change the order in the Dockerfile.

## Upstream PRs included

### opensearch-project/alerting

- [PRs by thecodingshrimp](https://github.com/opensearch-project/alerting/pulls/thecodingshrimp)
- [PRs by carmeroa](https://github.com/opensearch-project/alerting/pulls/carmeroa)

### opensearch-project/security-analytics

- [PRs by thecodingshrimp](https://github.com/opensearch-project/security-analytics/pulls/thecodingshrimp)
- [PRs by carmeroa](https://github.com/opensearch-project/security-analytics/pulls/carmeroa)

## Open upstream issues

| Repo | Type | Link | Title |
|------|------|------|-------|
| opensearch-project/alerting | PR | [#2163](https://github.com/opensearch-project/alerting/pull/2163) | fix: stop DestinationMigrationCoordinator cycling on unrelated cluster events |
| opensearch-project/alerting | PR | [#2158](https://github.com/opensearch-project/alerting/pull/2158) | Fix: Skip alias-type fields in doc-level monitor query index mapping |
| opensearch-project/alerting | PR | [#2154](https://github.com/opensearch-project/alerting/pull/2154) | fix: correct inverted condition in DocLevelMonitorQueries causing query index churn |
| opensearch-project/alerting | PR | [#2145](https://github.com/opensearch-project/alerting/pull/2145) | Fix/workflow validation ~10 delegation monitor limit |
| opensearch-project/alerting | PR | [#2150](https://github.com/opensearch-project/alerting/pull/2150) | Fix/doc level monitor sample documents source fields |
| opensearch-project/alerting | Issue | [#2157](https://github.com/opensearch-project/alerting/issues/2157) | [BUG] Doc-level monitor upsertQueryIndex fails with HTTP 500 when source index contains alias-type fields |
| opensearch-project/alerting | Issue | [#2153](https://github.com/opensearch-project/alerting/issues/2153) | [BUG] DocLevelMonitorQueries: inverted condition causes query index to be deleted and recreated on every monitor execution |
| opensearch-project/alerting | Issue | [#2144](https://github.com/opensearch-project/alerting/issues/2144) | [BUG] Workflow Validation Fails for Detectors with More Than 10 Rules |
| opensearch-project/alerting | Issue | [#2149](https://github.com/opensearch-project/alerting/issues/2149) | [BUG] Doc-level monitor action templates cannot reliably access the original matched document for notifications on routed indices |
| opensearch-project/security-analytics | PR | [#1726](https://github.com/opensearch-project/security-analytics/pull/1726) | fix: set deleteQueryIndexInEveryRun=false for chained_findings monitor |
| opensearch-project/security-analytics | Issue | [#1731](https://github.com/opensearch-project/security-analytics/issues/1731) | [BUG] OSMapping uses `timestamp` alias instead of ECS-standard `@timestamp`, breaking time-range filters for ECS-compliant indices |
| opensearch-project/security-analytics | Issue | [#1725](https://github.com/opensearch-project/security-analytics/issues/1725) | [BUG] TransportIndexDetectorAction: chained_findings monitor created with deleteQueryIndexInEveryRun=true causing index churn |
| ~~opensearch-project/security-analytics~~ | ~~PR~~ | [~~#1722~~](https://github.com/opensearch-project/security-analytics/pull/1722) | ~~Fix mutable script params for detector trigger actions~~ |

## Published image
Images are built and pushed to ghcr.io by the [Build Docker images and push to registry workflow](https://github.com/cloudoperators/greenhouse-extensions/actions/workflows/docker-build.yaml) (on pushes to main/version tags, and via manual trigger when an extra tag is needed). Pushed images are automatically mirrored to Keppel Container Image Registry.

## Building locally

```bash
docker build --platform linux/amd64 -t opensearch-fortlogs:3.7.0 .
```

## Removing a patch

Once an upstream PR merges and a new OpenSearch release ships the fix, remove the custom plugin from the build and bump the base image version. When all patches for a plugin are upstreamed, revert to the official plugin.

## Support, Feedback, Contributing

This project is open to feature requests/suggestions, bug reports etc. via [GitHub issues](https://github.com/SAP-cloud-infrastructure/opensearch-fortlogs/issues). Contribution and feedback are encouraged and always welcome. For more information about how to contribute, see our [Contribution Guidelines](CONTRIBUTING.md).

## Security / Disclosure

If you find any bug that may be a security problem, please follow our instructions in the [security policy](SECURITY.md) on how to report it. Please do not create GitHub issues for security-related doubts or problems.

## Code of Conduct

We as members, contributors, and leaders pledge to make participation in our community a harassment-free experience for everyone. By participating in this project, you agree to abide by its [Code of Conduct](CODE_OF_CONDUCT.md) at all times.

## Licensing

Copyright 2026 SAP SE or an SAP affiliate company and opensearch-fortlogs contributors. Please see our [LICENSE](LICENSE) for copyright and license information. Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/SAP-cloud-infrastructure/opensearch-fortlogs).
