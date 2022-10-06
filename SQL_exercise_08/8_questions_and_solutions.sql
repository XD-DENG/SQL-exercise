-- 8.1
-- Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
SELECT NAME 
FROM
	Physician 
WHERE
	EmployeeID IN ( SELECT Physician FROM Undergoes U WHERE NOT EXISTS ( SELECT * FROM Trained_In WHERE Treatment = Procedures AND Physician = U.Physician ) ); 


-- 8.2
-- Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
SELECT
	P.NAME AS Physician,
	Pr.NAME AS `procedure`,
	U.DateUndergoes,
	Pt.NAME AS Patient 
FROM
	Physician P,
	Undergoes U,
	Patient Pt,
	Procedures Pr 
WHERE
	U.Patient = Pt.SSN 
	AND U.Procedures = Pr.CODE 
	AND U.Physician = P.EmployeeID 
	AND NOT EXISTS ( SELECT * FROM Trained_In T WHERE T.Treatment = U.Procedures AND T.Physician = U.Physician );


-- 8.3
-- Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
SELECT
	P.NAME 
FROM
	Physician AS P,
	Trained_In T,
	Undergoes AS U 
WHERE
	T.Physician = U.Physician 
	AND T.Treatment = U.Procedures
	AND U.DateUndergoes > T.CertificationExpires 
	AND P.EmployeeID = U.Physician


-- 8.4
-- Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
SELECT
	P.NAME AS Physician,
	Pr.NAME AS `PROCEDURE`,
	U.DateUndergoes,
	Pt.NAME AS Patient,
	T.CertificationExpires 
FROM
	Physician P,
	Undergoes U,
	Patient Pt,
	Procedures Pr,
	Trained_In T 
WHERE
	U.Patient = Pt.SSN 
	AND U.Procedures = Pr.CODE 
	AND U.Physician = P.EmployeeID 
	AND Pr.CODE = T.Treatment 
	AND P.EmployeeID = T.Physician 
	AND U.DateUndergoes > T.CertificationExpires;


-- 8.5
-- Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
SELECT
	Pt.NAME AS Patient,
	Ph.NAME AS Physician,
	N.NAME AS Nurse,
	A.START,
	A.END,
	A.ExaminationRoom,
	PhPCP.NAME AS PCP 
FROM
	Patient Pt,
	Physician Ph,
	Physician PhPCP,
	Appointment A
	LEFT JOIN Nurse N ON A.PrepNurse = N.EmployeeID 
WHERE
	A.Patient = Pt.SSN 
	AND A.Physician = Ph.EmployeeID 
	AND Pt.PCP = PhPCP.EmployeeID 
	AND A.Physician <> Pt.PCP;


-- 8.6
-- The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
SELECT
	* 
FROM
	Undergoes U 
WHERE
	Patient <> ( SELECT Patient FROM Stay S WHERE U.Stay = S.StayID );


-- 8.7
-- Obtain the names of all the nurses who have ever been on call for room 123.
SELECT
	N.NAME 
FROM
	Nurse N 
WHERE
	EmployeeID IN (
	SELECT
		OC.Nurse 
	FROM
		On_Call OC,
		Room R 
	WHERE
		OC.BlockFloor = R.BlockFloor 
		AND OC.BlockCode = R.BlockCode 
	AND R.RoomNumber = 123 
	);


-- 8.8
-- The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
SELECT ExaminationRoom, COUNT(*) AS Number FROM Appointment
GROUP BY ExaminationRoom;


-- 8.9
-- Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
-- 
-- The patient has been prescribed some medication by his/her primary care physician.
-- The patient has undergone a procedure with a cost larger that $5,000
-- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
-- The patient's primary care physician is not the head of any department.
SELECT
	Pt.NAME,
	PhPCP.NAME 
FROM
	Patient Pt,
	Physician PhPCP 
WHERE
	Pt.PCP = PhPCP.EmployeeID 
	AND EXISTS ( 
		SELECT * FROM Prescribes Pr WHERE 
			Pr.Patient = Pt.SSN 
			AND Pr.Physician = Pt.PCP 
	) 
	AND EXISTS (
		SELECT * FROM Undergoes U, Procedures Pr WHERE 
			U.Procedures = Pr.CODE 
			AND U.Patient = Pt.SSN 
			AND Pr.Cost > 5000 
	) 
	AND 2 <= (
		SELECT COUNT( A.AppointmentID ) FROM Appointment A, Nurse N WHERE
			A.PrepNurse = N.EmployeeID 
			AND N.Registered = 1 
	) 
	AND NOT Pt.PCP IN ( 
		SELECT Head FROM Department 
	);