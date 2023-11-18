-- DISPLAY NUMBER OF MALES AND FEMALES
SELECT PatientGender, COUNT(PatientGender) 
FROM patientdemo
GROUP BY PatientGender;

-- DISPLAY NUMBER OF MALES AND FEMALES AND ETHNICITY
SELECT PatientGender,PatientRace, COUNT(PatientGender) as NumberOfPatient
FROM patientdemo
GROUP BY PatientGender, PatientRace
ORDER BY PatientGender, NumberOfPatient DESC;

-- DISPLAY NUMBER OF MALES AND FEMALES
SELECT PatientGender, COUNT(PatientGender) 
FROM patientdemo
GROUP BY PatientGender;

-- DISPLAY NUMBER OF MALES AND FEMALES And there Percent Below Poverty
SELECT PatientGender, COUNT(PatientGender) , ROUND(AVG(PatientPopulationPercentageBelowPoverty),2) AS AVG_PatientBelowPovertyPercent, MAX(PatientPopulationPercentageBelowPoverty) AS MAX_PatientBelowPovertyPercent, MIN(PatientPopulationPercentageBelowPoverty) AS MIN_PatientBelowPovertyPercent
FROM patientdemo
GROUP BY PatientGender;

-- Display The same as the top but with PatientRace included
SELECT PatientGender,PatientRace, COUNT(PatientGender) AS numberOfPatient , ROUND(AVG(PatientPopulationPercentageBelowPoverty),2) AS AVG_PatientBelowPovertyPercent, MAX(PatientPopulationPercentageBelowPoverty) AS MAX_PatientBelowPovertyPercent, MIN(PatientPopulationPercentageBelowPoverty) AS MIN_PatientBelowPovertyPercent
FROM patientdemo
GROUP BY PatientGender, PatientRace
ORDER BY PatientGender,numberOfPatient DESC; 

-- DONT RUN UNLESS YOU WANNA CONVERT STR TO DATE
-- UPDATE patientdemo
-- SET PatientDateOfBirth = str_to_date(PatientDateOfBirth,'%c/%d/%Y %H:%i');

-- Get the age of patients TIMESTAMPDIFF(Unit,DATE1,DATE2)
SELECT TIMESTAMPDIFF(YEAR,PatientDateOfBirth,CURDATE()) AS age
FROM patientdemo;

-- BINS BY AGE
SELECT CASE WHEN patientAge BETWEEN 0 AND 18 THEN 'Under 18'
WHEN patientAge BETWEEN 19 AND 36 THEN '19 - 36'
WHEN patientAge BETWEEN 37 AND 60 THEN '37 - 60'
WHEN patientAge BETWEEN 61 AND 80 THEN '61-80'
ELSE '81+' END AS AgeGroup,
COUNT(*) AS total
FROM patientdemo
GROUP BY AGEGroup;


SELECT * 
FROM patientDemo;