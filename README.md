# Friendica on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/friendica?referralCode=ZqgrJ0)

Deploy Friendica 2026.05 with generated administrator and MariaDB credentials, a built-in worker daemon, federation endpoints, and daily backups.

The Deploy on Railway button is added after the published route is verified.

## What this deploys

- Friendica `2026.05-apache`, pinned to the official Linux/AMD64 image digest
- MariaDB `11.8.5`, pinned by digest
- Generated administrator and database credentials
- Friendica's background daemon in the same single-replica container
- Daily-backed-up Friendica and MariaDB volumes

## Sign in

Open the generated domain and use `FRIENDICA_ADMIN_NICK` with the generated `FRIENDICA_ADMIN_PASSWORD`. The adapter delegates installation and upgrades to the official entrypoint, idempotently creates the administrator, applies a closed-registration policy, starts the worker daemon, and then starts Apache. Deployment health uses Friendica's database-backed NodeInfo route.

## Federation scope

Friendica is a public federated social server. Its WebFinger, NodeInfo, ActivityPub, and other protocol endpoints must remain reachable for federation. Closed registration prevents anonymous local signups; it does not make posts or federation traffic private. Configure moderation, blocklists, terms, privacy defaults, SMTP, and backups before inviting users.

The template runs one Friendica replica. The worker daemon shares the same filesystem and configuration. Do not horizontally scale this topology without validating sessions, locking, shared media, and worker coordination.

## Updating

Update Friendica and MariaDB tags and digests deliberately, back up both volumes, read release notes, then repeat installation, login, NodeInfo/WebFinger, worker logs, media persistence, database persistence, and redeploy soak tests.

## Validation

```bash
npm test
BASE_URL=https://your-domain.example ADMIN_NICK=admin ADMIN_PASSWORD=... python3 scripts/smoke.py
```

## Upstream

- Source: https://github.com/friendica/friendica/tree/2026.05-1
- Release: https://github.com/friendica/friendica/releases/tag/2026.05-1
- Docker image source: https://github.com/friendica/docker
- Documentation: https://wiki.friendi.ca/
- License: AGPL-3.0-or-later

This repository contains Railway adapters and documentation. Friendica remains copyright its upstream contributors and is not affiliated with Railway.
