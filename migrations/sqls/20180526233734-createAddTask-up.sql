CREATE OR REPLACE FUNCTION public.create_task(IN name character varying, IN parent_id integer, IN discrete boolean, IN project_id smallint)
    RETURNS void
AS $$
INSERT INTO tasks (name, parent_id, complete_date, discrete, project_id, subtask_ordinal)
SELECT 
	name,
	parent_id,
	NULL as complete_date,
	discrete,
	project_id,
	(SELECT MAX(subtask_ordinal)+1 
	from tasks t
	WHERE t.parent_id = parent_id
	GROUP BY t.parent_id) AS subtask_ordinal
FROM tasks
$$ LANGUAGE 'sql';

ALTER FUNCTION public.create_task(character varying, integer, boolean, smallint)
    OWNER TO xfp;

CREATE OR REPLACE VIEW public.mtl AS
WITH RECURSIVE subtasks AS (
  SELECT 
	id,
	name,
	parent_id,
	complete_date,
	discrete,
	project_id,
	subtask_ordinal,
	0 AS depth,
	ARRAY[subtask_ordinal] AS path
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
	p.subtask_ordinal,
	s.depth + 1,
	s.path || p.subtask_ordinal
  FROM
	subtasks s
  INNER JOIN
	tasks p on s.parent_id = p.id	
) SELECT
 proj.id AS project_id,
 proj.name AS project_name,
 st.id,
 st.name,
 st.complete_date,
 st.discrete,
 st.parent_id,
 st.subtask_ordinal,
 st.depth
FROM
  subtasks st
INNER JOIN
  projects proj
ON proj.id = st.project_id
ORDER BY proj.id ASC, st.path ASC;
