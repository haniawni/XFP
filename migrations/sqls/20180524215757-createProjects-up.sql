CREATE TABLE public.projects
(
    id smallint NOT NULL,
    name character varying(50) NOT NULL,
    PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.projects
    OWNER to xfp;

ALTER TABLE public.tasks
    ADD CONSTRAINT project_exists FOREIGN KEY (project_id)
    REFERENCES public.projects (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;