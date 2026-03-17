CREATE TABLE auth.users (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username      VARCHAR(100) NOT NULL UNIQUE,
    email         VARCHAR(255) NOT NULL UNIQUE,
    phone_number  VARCHAR(10) UNIQUE,
    password      VARCHAR(255) NOT NULL,
    display_name  VARCHAR(255),
    role_id       BIGINT NOT NULL REFERENCES auth.roles(id) ON DELETE CASCADE,
    status        INT DEFAULT 1,
    created_at    TIMESTAMPTZ DEFAULT NOW(),
    created_by    VARCHAR(150) DEFAULT 'SYSTEM',
    updated_by    VARCHAR(150),
    updated_at    TIMESTAMPTZ
);

CREATE TABLE auth.roles (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    key         VARCHAR(30) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE auth.user_roles (
    user_id BIGINT NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    role_id BIGINT NOT NULL REFERENCES auth.roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE auth.permissions (
  id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  key        VARCHAR(128) NOT NULL UNIQUE,
  resource   VARCHAR(64) NOT NULL,
  action     VARCHAR(64) NOT NULL,
  description TEXT
);

CREATE TABLE auth.role_permissions (
   role_id       BIGINT NOT NULL REFERENCES auth.roles(id) ON DELETE CASCADE,
   permission_id BIGINT NOT NULL REFERENCES auth.permissions(id) ON DELETE CASCADE,
   PRIMARY KEY (role_id, permission_id)
);
