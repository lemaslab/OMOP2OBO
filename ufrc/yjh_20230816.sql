/*set default schema*/
USE omop;

 
WITH 
  condition_concepts
  AS (SELECT
        c1.concept_id AS CONCEPT_ID,
        c1.concept_name AS CONCEPT_LABEL,
		GROUP_CONCAT(DISTINCT CONCAT(LOWER(v.vocabulary_id), ":", c1.concept_code) SEPARATOR " | ") AS CONCEPT_SOURCE_CODE,
        GROUP_CONCAT(DISTINCT c1.concept_name SEPARATOR ' | ') AS CONCEPT_SOURCE_LABEL,
        GROUP_CONCAT(DISTINCT v.vocabulary_id SEPARATOR ' | ') AS CONCEPT_VOCAB,
        GROUP_CONCAT(DISTINCT v.vocabulary_version SEPARATOR ' | ') AS CONCEPT_VOCAB_VERSION
      FROM 
        concept c1
        JOIN vocabulary v ON v.vocabulary_id = c1.vocabulary_id
      WHERE 
        c1.concept_name != "No matching concept" 
        AND c1.domain_id = "Condition"
        AND c1.vocabulary_id = "SNOMED"
      GROUP BY CONCEPT_ID, CONCEPT_LABEL, STANDARD_CONCEPT),
  
   
  condition_ancestors
  AS (SELECT
        ca.descendant_concept_id AS CONCEPT_ID,
        GROUP_CONCAT(DISTINCT c1.concept_id SEPARATOR ' | ') AS ANCESTOR_CONCEPT_ID,
        GROUP_CONCAT(DISTINCT c1.concept_code SEPARATOR ' | ') AS ANCESTOR_SOURCE_CODE,
        GROUP_CONCAT(DISTINCT c1.concept_name SEPARATOR ' | ') AS ANCESTOR_LABEL,
        GROUP_CONCAT(DISTINCT c1.vocabulary_id SEPARATOR ' | ') AS ANCESTOR_VOCAB,
        GROUP_CONCAT(DISTINCT v.vocabulary_version SEPARATOR ' | ') AS ANCESTOR_VOCAB_VERSION
      FROM 
       concept_ancestor ca
        JOIN concept c1 ON ca.ancestor_concept_id = c1.concept_id
        JOIN vocabulary v ON c1.vocabulary_id = v.vocabulary_id
      WHERE 
        ca.descendant_concept_id IN (SELECT CONCEPT_ID FROM condition_concepts)
        AND c1.concept_name != "No matching concept"
        AND c1.concept_id IS NOT NULL
        AND c1.domain_id = "Condition"
      GROUP BY CONCEPT_ID),
  
  condition_synonyms
  AS (SELECT 
        s.concept_id AS CONCEPT_ID,
        GROUP_CONCAT(DISTINCT s.concept_synonym_name SEPARATOR ' | ') AS CONCEPT_SYNONYM
        FROM concept_synonym s 
        WHERE s.concept_id in (SELECT CONCEPT_ID FROM condition_concepts)
        GROUP BY CONCEPT_ID)

SELECT
  c.CONCEPT_ID,
  c.CONCEPT_SOURCE_CODE, 
  c.CONCEPT_LABEL,
  c.CONCEPT_SOURCE_LABEL,
  c.CONCEPT_VOCAB,
  c.CONCEPT_VOCAB_VERSION,
  s.CONCEPT_SYNONYM,
  a.ANCESTOR_CONCEPT_ID,
  a.ANCESTOR_SOURCE_CODE, 
  a.ANCESTOR_LABEL,
  a.ANCESTOR_VOCAB,
  a.ANCESTOR_VOCAB_VERSION
FROM condition_concepts c
LEFT JOIN condition_ancestors a ON c.CONCEPT_ID = a.CONCEPT_ID
LEFT JOIN condition_synonyms s ON c.CONCEPT_ID = s.CONCEPT_ID
UNION
SELECT
  c.CONCEPT_ID,
  c.CONCEPT_SOURCE_CODE, 
  c.CONCEPT_LABEL,
  c.CONCEPT_SOURCE_LABEL,
  c.CONCEPT_VOCAB,
  c.CONCEPT_VOCAB_VERSION,
  s.CONCEPT_SYNONYM,
  a.ANCESTOR_CONCEPT_ID,
  a.ANCESTOR_SOURCE_CODE, 
  a.ANCESTOR_LABEL,
  a.ANCESTOR_VOCAB,
  a.ANCESTOR_VOCAB_VERSION
  FROM condition_ancestors a
RIGHT JOIN condition_concepts c ON a.CONCEPT_ID = c.CONCEPT_ID
RIGHT JOIN condition_synonyms s ON a.CONCEPT_ID = s.CONCEPT_ID;
  

