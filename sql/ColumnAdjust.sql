-- UPDATE admissioncorepop SET patientID_admissionID = CONCAT(patientID, '-', admissionID)

-- This cammonad change position, use keyword FIRST to change to first column
-- ALTER TABLE table_name MODIFY password varchar(20) AFTER id

-- this is to create column
-- alter table table_name add column new_column int after id

-- ALTER TABLE patientdemo MODIFY patientAge INT after PatientDateOfBirth;