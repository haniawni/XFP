CREATE OR REPLACE VIEW public.mtl AS
WITH RECURSIVE subtasks AS (
  SELECT 
	id,
	name,
	parent_id,
	complete_date,
	discrete,
	project_id
  FROM
	tasks
--  WHERE
--	<stuff if needed>
  UNION
  SELECT
	p.id,
	p.name,
	p.parent_id,
	p.complete_date,
	p.discrete,
	p.project_id
  FROM
	tasks p
  INNER JOIN
	subtasks s on s.parent_id = p.id	
) SELECT
 *
FROM
  subtasks;

ALTER TABLE public.mtl
    OWNER TO xfp;