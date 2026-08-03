# Deploy and Host Friendica on Railway

## About Hosting Friendica

Friendica is a decentralized social network server that interoperates with ActivityPub and other federated protocols. This template deploys stable Friendica 2026.05 with MariaDB, generated administrator credentials, durable media, and the required background daemon.

Sign in with `FRIENDICA_ADMIN_NICK` and the generated `FRIENDICA_ADMIN_PASSWORD` service variable.

## Common Use Cases

- Operate a personal or community federated social server
- Follow and interact with users across compatible federated networks
- Host profiles, posts, media, contacts, and community conversations

## Dependencies for Friendica Hosting

### Deployment Dependencies

- Friendica Apache service with a daily-backed-up application volume
- Private MariaDB 11.8.5 with daily backups
- Optional external SMTP and Redis services

### Implementation Details

The official entrypoint installs or upgrades Friendica against private MariaDB. The adapter then creates the generated administrator, closes public registration, starts Friendica's worker daemon, and starts Apache. Railway health checks use Friendica's database-backed federation discovery route; a lightweight version endpoint supports operational verification.

Friendica is intentionally public for federation. Closed registration does not make federation content private. This is a one-replica topology; validate shared files and locking before scaling.

## Why Deploy Friendica on Railway?

Railway provides managed HTTPS, stable public DNS, generated credentials, private database networking, persistent volumes with backups, and health-checked rollouts for a federated social node.
