LOAD DATA LOCAL 
INFILE 'D:/Data_Analysis_Job_Resources/Data_Analysis_Dataset/100000-Patients/csv/AdmissionsCorePopulatedTable.csv'
INTO TABLE admissioncorepop
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;