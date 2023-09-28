/*Import concept*/
create table omop.concept(concept_id VARCHAR(255), concept_name VARCHAR(255), domain_id VARCHAR(255), vocabulary_id VARCHAR(255),
							 concept_class_id VARCHAR(255), standard_concept VARCHAR(255), concept_code VARCHAR(255), 
                             valid_start_date date, valid_end_date date, invalid_reason VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CONCEPT.csv'
	into table omop.concept
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines
    (concept_id, concept_name, domain_id, vocabulary_id, concept_class_id, standard_concept, concept_code, @valid_start_date, @valid_end_date, invalid_reason)
	set valid_start_date=NUllIF(@valid_start_date, ''), valid_end_date=NUllIF(@valid_end_date, '');


/*Import concept_ancestor*/
create table omop.concept_ancestor(ancestor_concept_id VARCHAR(255), descendant_concept_id VARCHAR(255),
									  min_levels_of_separation int, max_levels_of_separation int);
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CONCEPT_ANCESTOR.csv'
	 into table omop.concept_ancestor
	 FIELDS TERMINATED BY ',' 
	 LINES TERMINATED BY '\n' 
	 ignore 1 lines;
  
  
/*Import concept_class*/
create table omop.concept_class(concept_class_id VARCHAR(255), concept_class_name VARCHAR(255), concept_class_concept_id VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CONCEPT_CLASS.csv'
	into table omop.concept_class
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines;
  
  
  
/*Import concept_relationship*/
create table omop.concept_relationship(concept_id_1 VARCHAR(255), concept_id_2 VARCHAR(255), relationship_id VARCHAR(255),
										  valid_start_date date, valid_end_date date, invalid_reason VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CONCEPT_RELATIONSHIP.csv'
	into table omop.concept_relationship
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines
    (concept_id_1, concept_id_2, relationship_id, @valid_start_date, @valid_end_date, invalid_reason)
	set valid_start_date=NUllIF(@valid_start_date, ''), valid_end_date=NUllIF(@valid_end_date, '');
   
   
   
/*Import concept_synonym*/
create table omop.concept_synonym(concept_id VARCHAR(255), concept_synonym_name VARCHAR(255), language_concept_id VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CONCEPT_SYNONYM.csv'
	into table omop.concept_synonym
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines;
    
    
    
/*Import condition_era*/
create table omop.condition_era(condition_era_id VARCHAR(255), person_id VARCHAR(255), condition_concept_id VARCHAR(255), condition_era_start_date date,
							   condition_era_end_date date, condition_occurrence_count int);
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/condition_era.csv'
	into table omop.condition_era
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines
    (condition_era_id, person_id, condition_concept_id, @condition_era_start_date, @condition_era_end_date, condition_occurrence_count)
	set condition_era_start_date=NUllIF(@condition_era_start_date, ''), condition_era_end_date=NUllIF(@condition_era_end_date, '');
   



    
/*Import condition_occurrence*/
create table omop.condition_occurrence(condition_occurrence_id VARCHAR(255), person_id VARCHAR(255), condition_concept_id VARCHAR(255), condition_start_date date, 
                                          condition_start_datetime date, condition_end_date date, condition_end_datetime date, condition_type_concept_id VARCHAR(255),
                                          stop_reason VARCHAR(255), provider_id VARCHAR(255), visit_occurrence_id VARCHAR(255), visit_detail_id VARCHAR(255), 
                                          condition_source_value VARCHAR(255), condition_source_concept_id VARCHAR(255), condition_status_source_value VARCHAR(255),
                                          condition_status_concept_id VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/condition_occurrence.csv'
	into table omop.condition_occurrence
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines
    (condition_occurrence_id, person_id, condition_concept_id, @condition_start_date, @condition_start_datetime, @condition_end_date, @condition_end_datetime, condition_type_concept_id,
    stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value, condition_status_concept_id)
	set condition_start_date=NUllIF(@condition_start_date, ''), condition_start_datetime=NUllIF(@condition_start_datetime, ''), 
    condition_end_date=NUllIF(@condition_end_date, ''), condition_end_datetime=NUllIF(@condition_end_datetime, '');    



/*Import domain*/
create table omop.domain(domain_id VARCHAR(255), domain_name VARCHAR(255), domain_concept_id VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DOMAIN.csv'
	into table omop.domain
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines;
    


    
/*Import vocabulary*/
create table omop.vocabulary(vocabulary_id VARCHAR(255), vocabulary_name VARCHAR(255), vocabulary_reference VARCHAR(255), 
                                vocabulary_version VARCHAR(255), vocabulary_concept_id VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/VOCABULARY.csv'
	into table omop.vocabulary
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines;    




/*Import relationship*/
create table omop.relationship(relationship_id VARCHAR(255), relationship_name VARCHAR(255), is_hierarchical TINYINT(1), 
                                defines_ancestry TINYINT(1), reverse_relationship_id VARCHAR(255), relationship_concept_id int);
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/RELATIONSHIP.csv'
	into table omop.relationship
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines;    




/*Import drug_strength*/
create table omop.drug_strength(drug_concept_id VARCHAR(255), ingredient_concept_id VARCHAR(255), amount_value VARCHAR(255), 
                                amount_unit_concept_id VARCHAR(255), numerator_value VARCHAR(255), numerator_unit_concept_id VARCHAR(255),
                                denominator_value VARCHAR(255), denominator_unit_concept_id VARCHAR(255), box_size VARCHAR(255), valid_start_date date,
                                valid_end_date date, invalid_reason VARCHAR(255));
Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DRUG_STRENGTH.csv'
	into table omop.drug_strength
    FIELDS TERMINATED BY ',' 
	LINES TERMINATED BY '\n' 
    ignore 1 lines 
     (drug_concept_id, ingredient_concept_id, amount_value, amount_unit_concept_id, numerator_value, numerator_unit_concept_id,
     denominator_value, denominator_unit_concept_id, box_size, @valid_start_date, @valid_end_date, invalid_reason)
	set valid_start_date=NUllIF(@valid_start_date, ''), valid_end_date=NUllIF(@valid_end_date, '');
    
    


