CREATE SCHEMA master_data;

CREATE TABLE master_data.projects (
    id         BIGSERIAL PRIMARY KEY,
    key        VARCHAR(32) NOT NULL UNIQUE,
    name       VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE master_data.issue_types (
    id    BIGSERIAL PRIMARY KEY,
    key   VARCHAR(32) NOT NULL UNIQUE,
    name  VARCHAR(100) NOT NULL
);

CREATE TABLE master_data.statuses (
    id    BIGSERIAL PRIMARY KEY,
    key   VARCHAR(32) NOT NULL UNIQUE,
    name  VARCHAR(100) NOT NULL
);

CREATE TABLE master_data.priorities (
    id    BIGSERIAL PRIMARY KEY,
    key   VARCHAR(32) NOT NULL UNIQUE,
    name  VARCHAR(100) NOT NULL
);

INSERT INTO master_data.projects (key, name) VALUES
    ('MY', 'My Project'),
    ('DEV', 'Development'),
    ('OPS', 'Operations');

INSERT INTO master_data.issue_types (key, name) VALUES
    ('TASK', 'Task'),
    ('BUG', 'Bug'),
    ('STORY', 'Story');

INSERT INTO master_data.statuses (key, name) VALUES
    ('TODO', 'To Do'),
    ('IN_PROGRESS', 'In Progress'),
    ('DONE', 'Done');

INSERT INTO master_data.priorities (key, name) VALUES
    ('HIGH', 'High'),
    ('MEDIUM', 'Medium'),
    ('LOW', 'Low');
