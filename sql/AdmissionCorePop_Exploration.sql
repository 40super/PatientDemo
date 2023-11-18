-- Display All Unique ICD-10 Diagnosis Code
SELECT DISTINCT PrimaryDiagnosisCode , PrimaryDiagnosisDescription
FROM admissiondiagnosiscorepop;

-- Displays the Number of times a diagnosis appears.
SELECT PrimaryDiagnosisCode,PrimaryDiagnosisDescription,COUNT(PrimaryDiagnosisDescription) AS NumberOfDiagnoses
FROM admissiondiagnosiscorepop
GROUP BY PrimaryDiagnosisDescription , PrimaryDiagnosisCode
ORDER BY NumberOfDiagnoses DESC; 

-- Check the total of diagnosis
WITH cte AS
(
SELECT PrimaryDiagnosisCode,PrimaryDiagnosisDescription,COUNT(PrimaryDiagnosisDescription) AS NumberOfDiagnoses  
FROM admissiondiagnosiscorepop
GROUP BY PrimaryDiagnosisDescription , PrimaryDiagnosisCode
ORDER BY NumberOfDiagnoses DESC 
)
SELECT SUM(NumberOfDiagnoses)
FROM cte;
-- Checks the max visit based on Patient
SELECT PatientID, MAX(AdmissionID) AS MAX_VISIT
FROM admissiondiagnosiscorepop
GROUP BY PatientID
ORDER BY MAX_VISIT DESC;