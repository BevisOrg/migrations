# Database Migrations Repository

This repository stores database migration scripts used to manage schema changes across all environments.

The repository is organized by schema, and each schema contains versioned migration files.

## Purpose

* Version control database schema changes
* Keep environments in sync
* Support CI/CD deployment
* Allow rollback when needed
* Separate migrations by schema

## Folder Structure

Migrations are grouped by schema.

```
./<schema>/<version>_<description>.up.sql
./<schema>/<version>_<description>.down.sql
```

Example:

```
migrations/
├── core/
│   ├── 0001_init.up.sql
│   ├── 0001_init.down.sql
│   ├── 0002_add_rules.up.sql
│   ├── 0002_add_rules.down.sql
│
├── auth/
│   ├── 0001_init.up.sql
│   ├── 0001_init.down.sql
│   ├── 0002_add_users.up.sql
│   ├── 0002_add_users.down.sql
│
├── billing/
│   ├── 0001_init.up.sql
│   ├── 0001_init.down.sql
```

## Naming Convention

Format:

```
<version>_<description>.up.sql
<version>_<description>.down.sql
```

Rules:

* version must be incremental per schema
* description should be short and clear
* use lowercase and underscore

Example:

```
0001_init.up.sql
0002_add_table_rules.up.sql
0003_add_index_rule_name.up.sql
```

## Migration Rules

* Do NOT modify old migrations
* Always create a new version
* Each migration should have up and down
* One logical change per migration
* Version numbering is per schema

## Running migrations

Example using migrate:

```
migrate -path migrations/core \
  -database "postgres://user:pass@host:5432/db?sslmode=disable" \
  up
```

Run specific schema:

```
migrate -path migrations/auth up
```

Rollback:

```
migrate down 1
```

## Environments

| Environment | Database |
| ----------- | -------- |
| local       | postgres |
| dev         | postgres |
| uat         | postgres |
| prod        | postgres |

## Best Practices

* Test locally before commit
* Never edit applied migrations
* Avoid breaking changes in production
* Backup before destructive changes
* Keep migrations small

## Maintainers

* Backend Team
* DevOps Team
* DBA
