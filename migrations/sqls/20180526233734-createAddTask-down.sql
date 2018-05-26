DROP FUNCTION public.create_task(character varying, integer, boolean, smallint);

DROP VIEW public.mtl;

CREATE OR REPLACE VIEW public.mtl AS
WITH RECURSIVE subtasks AS (
  SELECT 
	id,
	name,
	parent_id,
	complete_date,
	discrete,
	project_id,
	0 AS depth,
	ARRAY[id] AS path
  FROM
	tasks
  WHERE
  	parent_id IS NULL
 UNION
  SELECT
	p.id,
	p.name,
	p.parent_id,
	p.complete_date,
	p.discrete,
	p.project_id,
	s.depth + 1,
	s.path || s.parent_id
  FROM
	tasks p
  INNER JOIN
	subtasks s on s.parent_id = p.id	
) SELECT
 proj.id AS project_id,
 proj.name AS project_name,
 subtasks.id,
 subtasks.name,
 subtasks.complete_date,
 subtasks.discrete
FROM
  subtasks
INNER JOIN
  projects proj
ON proj.id = subtasks.project_id
ORDER BY proj.id ASC, subtasks.path ASC, subtasks.id ASC;

ALTER TABLE public.mtl
    OWNER TO xfp;