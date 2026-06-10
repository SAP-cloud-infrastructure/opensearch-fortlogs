# IMPORTANT!
Dockerfile moved to [greenhouse-extentions/opensearch/build](https://github.com/cloudoperators/greenhouse-extensions/pull/1715)

# opensearch-fortlogs

Custom OpenSearch Docker image that replaces the bundled `opensearch-security-analytics` and `opensearch-alerting` plugins with patched builds containing upstream fixes not yet merged.

## Why

Upstream PRs with critical fixes are open but unmerged. This image ships those fixes by building the plugins from source branches before the patches land in an official release.

## Base image

`opensearchproject/opensearch:3.6.0` (linux/amd64)

## What this image does

1. Removes the stock `opensearch-security-analytics` and `opensearch-alerting` plugins.
2. Installs custom-built plugin ZIPs that include the patches listed below.

> **Order matters.** `opensearch-alerting` must be removed and installed before `opensearch-security-analytics`. Do not change the order in the Dockerfile.

## Upstream PRs included

### opensearch-project/alerting

- [PRs by thecodingshrimp](https://github.com/opensearch-project/alerting/pulls/thecodingshrimp)
- [PRs by carmeroa](https://github.com/opensearch-project/alerting/pulls/carmeroa)

### opensearch-project/security-analytics

- [PRs by thecodingshrimp](https://github.com/opensearch-project/security-analytics/pulls/thecodingshrimp)
- [PRs by carmeroa](https://github.com/opensearch-project/security-analytics/pulls/carmeroa)

## Published image
Images are build and push to Keppel Container Image Registry using [Concourse](https://ci1.eu-de-2.cloud.sap/teams/monitoring/pipelines/opensearch-logs?group=build-images).

All published versions are [here](https://dashboard.eu-de-1.cloud.sap/ccadmin/master/keppel/#/repo/ccloud/opensearch-fortlogs).

## Building locally

```bash
docker build --platform linux/amd64 -t opensearch-fortlogs:3.6.0 .
```

## Removing a patch

Once an upstream PR merges and a new OpenSearch release ships the fix, remove the custom plugin from the build and bump the base image version. When all patches for a plugin are upstreamed, revert to the official plugin.
