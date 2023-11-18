-- Displays Number of admission and Age
WITH cte AS
(
SELECT *
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
)
SELECT PatientID, PatientAgeRange, MAX(AdmissionID) AS Number_Of_Admission
INTO OUTFILE 'D:/Data_Analysis_Job_Resources/Data_Analysis_Dataset/100000-Patients/csv/TableauFinalData/AllPatientMaxNumAdmission.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM cte
GROUP BY PatientID, PatientAgeRange
ORDER BY Number_Of_Admission DESC;

-- UPDATE admissioncorepop
-- SET AdmissionStartDate = str_to_date(AdmissionStartDate,'%c/%d/%Y %H:%i');

WITH cte AS
(
SELECT admissiondiagnosiscorepop.PatientID, admissiondiagnosiscorepop.AdmissionID,AdmissionEndDate,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,PatientGender, PatientDateOfBirth,patientAge,patientAgeRange,PatientRace,PatientPopulationPercentageBelowPoverty
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
INNER JOIN admissioncorepop USING(PatientID_AdmissionID)
)
SELECT *
INTO OUTFILE 'D:/Data_Analysis_Job_Resources/Data_Analysis_Dataset/100000-Patients/csv/TableauFinalData/PatientInfo.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM CTE;


-- Dsiplays the Race with the most diagnosis(Counts the Amount of patients in total
WITH cte AS
(
SELECT admissiondiagnosiscorepop.PatientID, admissiondiagnosiscorepop.AdmissionID,AdmissionEndDate,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,PatientGender, PatientDateOfBirth,patientAge,patientAgeRange,PatientRace,PatientPopulationPercentageBelowPoverty
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
INNER JOIN admissioncorepop USING(PatientID_AdmissionID)
)
SELECT PatientRace,count(PrimaryDiagnosisDescription) as Number_Of_Patients
FROM CTE
GROUP BY  PatientRace;




-- Display Top 10 DiagnosisDescription based on race

WITH cte AS
(
SELECT admissiondiagnosiscorepop.PatientID, admissiondiagnosiscorepop.AdmissionID,AdmissionEndDate,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,PatientGender, PatientDateOfBirth,patientAge,patientAgeRange,PatientRace,PatientPopulationPercentageBelowPoverty
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
INNER JOIN admissioncorepop USING(PatientID_AdmissionID)
),
DIAG AS
(
	SELECT PatientRace,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,count(PrimaryDiagnosisCode) as CountOfDiagnosis
    FROM cte
    GROUP BY PatientRace,PrimaryDiagnosisCode,PrimaryDiagnosisDescription
),
rowN AS
(
 SELECT*, ROW_NUMBER() OVER (PARTITION BY PatientRace ORDER BY CountOfDiagnosis DESC) AS Rank_D
 FROM DIAG
)
SELECT *
FROM rowN
WHERE Rank_D <= 10
ORDER BY Rank_D,CountOfDiagnosis DESC;



-- Display the top 10 Diagnosis based on age range

WITH cte AS
(
SELECT admissiondiagnosiscorepop.PatientID, admissiondiagnosiscorepop.AdmissionID,AdmissionEndDate,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,PatientGender, PatientDateOfBirth,patientAge,patientAgeRange,PatientRace,PatientPopulationPercentageBelowPoverty
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
INNER JOIN admissioncorepop USING(PatientID_AdmissionID)
),
DIAG AS
(
	SELECT PatientageRange,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,count(PrimaryDiagnosisCode) as CountOfDiagnosis
    FROM cte
    GROUP BY PatientageRange,PrimaryDiagnosisCode,PrimaryDiagnosisDescription
),
rowN AS
(
 SELECT*, ROW_NUMBER() OVER (PARTITION BY PatientageRange ORDER BY CountOfDiagnosis DESC) AS Rank_D
 FROM DIAG
)
SELECT *
FROM rowN
WHERE Rank_D <= 10
ORDER BY Rank_D,PatientAgeRange DESC;



-- Display top 10 diagnosis based on gender

WITH cte AS
(
SELECT admissiondiagnosiscorepop.PatientID, admissiondiagnosiscorepop.AdmissionID,AdmissionEndDate,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,PatientGender, PatientDateOfBirth,patientAge,patientAgeRange,PatientRace,PatientPopulationPercentageBelowPoverty
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
INNER JOIN admissioncorepop USING(PatientID_AdmissionID)
),
DIAG AS
(
	SELECT PatientGender,PrimaryDiagnosisCode,PrimaryDiagnosisDescription,count(PrimaryDiagnosisCode) as CountOfDiagnosis
    FROM cte
    GROUP BY PatientGender,PrimaryDiagnosisCode,PrimaryDiagnosisDescription
),
rowN AS
(
 SELECT *, ROW_NUMBER() OVER (PARTITION BY PatientGender ORDER BY CountOfDiagnosis DESC) AS Rank_D
 FROM DIAG
)
SELECT *
FROM rowN
WHERE Rank_D <= 10
ORDER BY Rank_D,CountOfDiagnosis DESC;

-- TODO Change order by for all possibly based on the first column for each rather than the count of diagnosis


SELECT patientAgeRange,PatientRace, ROUND(AVG(AdmissionID),2) AS Average_Admission_Times
FROM admissiondiagnosiscorepop
LEFT JOIN patientdemo USING(PatientID)
GROUP BY patientAgeRange,PatientRace
ORDER BY Average_Admission_Times DESC;


