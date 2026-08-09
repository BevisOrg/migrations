CREATE SCHEMA auth;

CREATE TABLE auth.users (
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username            VARCHAR(100)    NOT NULL UNIQUE,
    "password"          VARCHAR(255)    NOT NULL,
    email               VARCHAR(255)    UNIQUE,
    phone_number        VARCHAR(20)     UNIQUE,
    display_name        VARCHAR(50),
    "status"            VARCHAR(20)     NOT NULL DEFAULT 'INACTIVE',
    created_at          TIMESTAMPTZ     DEFAULT NOW(),
    created_by          VARCHAR(150)    DEFAULT 'SYSTEM',
    updated_by          VARCHAR(150),
    updated_at          TIMESTAMPTZ
);

CREATE TABLE auth.providers (
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code                VARCHAR(100) NOT NULL UNIQUE,
    "name"              VARCHAR(255) UNIQUE,
    auth_type           VARCHAR(20) UNIQUE,
    "status"            VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at          TIMESTAMPTZ DEFAULT NOW(),
    created_by          VARCHAR(150) DEFAULT 'SYSTEM',
    updated_by          VARCHAR(150),
    updated_at          TIMESTAMPTZ
);


CREATE TABLE auth.user_identities (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username      VARCHAR(100) NOT NULL UNIQUE,
    email         VARCHAR(255) UNIQUE,
    phone_number  VARCHAR(20) UNIQUE,
    password      VARCHAR(255) NOT NULL,
    display_name  VARCHAR(255),
    status        INT DEFAULT 1,
    created_at    TIMESTAMPTZ DEFAULT NOW(),
    created_by    VARCHAR(150) DEFAULT 'SYSTEM',
    updated_by    VARCHAR(150),
    updated_at    TIMESTAMPTZ
);


CREATE TABLE auth.roles (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code            VARCHAR(30)     NOT NULL UNIQUE,
    "name"          VARCHAR(100)    NOT NULL,
    "description"   VARCHAR(255),
    "status"        VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE'
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    created_by      VARCHAR(150)    NOT NULL DEFAULT 'SYSTEM',
    updated_at      TIMESTAMPTZ,
    updated_by      VARCHAR(150)
);

CREATE TABLE auth.permissions (
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code                VARCHAR(128) NOT NULL UNIQUE,
    "name"              VARCHAR(64) NOT NULL,
    action              VARCHAR(64) NOT NULL,
    "description"       VARCHAR(255),
    "status"            VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE'
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by          VARCHAR(150) NOT NULL DEFAULT 'SYSTEM',
    updated_at          TIMESTAMPTZ,
    updated_by          VARCHAR(150),
);

CREATE TABLE auth.resources (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    key           VARCHAR(128) NOT NULL UNIQUE,
    resource      VARCHAR(64) NOT NULL,
    action        VARCHAR(64) NOT NULL,
    description   VARCHAR(255)
);

CREATE TABLE auth.user_roles (
    user_id B           BIGINT NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    role_id             BIGINT NOT NULL REFERENCES auth.roles(id) ON DELETE CASCADE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by          VARCHAR(150) NOT NULL DEFAULT 'SYSTEM',
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id)
        REFERENCES auth.users(id)
        ON DELETE CASCADE,
    FOREIGN KEY (role_id)
        REFERENCES auth.roles(id)
        ON DELETE CASCADE
);


CREATE TABLE auth.role_permissions (
   role_id       BIGINT NOT NULL REFERENCES auth.roles(id) ON DELETE CASCADE,
   permission_id BIGINT NOT NULL REFERENCES auth.permissions(id) ON DELETE CASCADE,
   PRIMARY KEY (role_id, permission_id)
);
