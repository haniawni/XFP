ALTER TABLE public.tasks
    ADD CONSTRAINT tree_internal FOREIGN KEY (parent_id)
    REFERENCES public.tasks (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;