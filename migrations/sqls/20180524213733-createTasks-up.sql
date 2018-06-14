CREATE TABLE tasks
(
    id serial NOT NULL,
    name character varying(200) NOT NULL,
    parent_id integer NULL,
    complete_date timestamp without time zone NULL,
    discrete boolean NULL,
    project_id smallint NOT NULL,
    PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.tasks
    OWNER to xfp;