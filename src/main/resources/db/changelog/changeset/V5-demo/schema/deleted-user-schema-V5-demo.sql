--liquibase formatted sql
--changeset Maslyna:5

CREATE TABLE deleted_user
(
    id                BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    time_to_delete    TIMESTAMP WITHOUT TIME ZONE,
    user_id           BIGINT,
    uuid_for_activate VARCHAR(255),
    CONSTRAINT pk_deleteduser PRIMARY KEY (id)
);

ALTER TABLE deleted_user
    ADD CONSTRAINT FK_DELETEDUSER_ON_USER FOREIGN KEY (user_id) REFERENCES users_info (id);