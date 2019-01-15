#------------------------------------------Database----------------------------------------------
DROP DATABASE IF EXISTS MedicalInterpreter;
CREATE DATABASE IF NOT EXISTS MedicalInterpreter;
USE MedicalInterpreter;

#------------------------------------------Tables------------------------------------------------
CREATE TABLE IF NOT EXISTS Hospital
(
	hospital_id				   		MEDIUMINT		PRIMARY KEY AUTO_INCREMENT,
    hospital_name 				VARCHAR(45)	NOT NULL, 
    hospital_location 			VARCHAR(200)	NOT NULL
);

CREATE TABLE IF NOT EXISTS agency
(
	agency_id			MEDIUMINT		PRIMARY KEY AUTO_INCREMENT,
    agency_name 		VARCHAR(45)		NOT NULL, 
    agency_location 	VARCHAR(200)	NOT NULL, 
    agency_phone		CHAR(10)		NOT NULL
);

CREATE TABLE IF NOT EXISTS invoice
(
	invoice_id			MEDIUMINT		PRIMARY KEY AUTO_INCREMENT,
    invoice_amount 		DECIMAL(7,2)	NOT NULL, 
    invoice_date 		DATETIME		NOT NULL, 
    hospital_id			MEDIUMINT		NOT NULL,
    agency_id			MEDIUMINT		NOT NULL,
    CONSTRAINT hospital_invoice_fk
    FOREIGN KEY (hospital_id)
    REFERENCES hospital (hospital_id), 
		CONSTRAINT agency_invoice_fk
		FOREIGN KEY (agency_id)
		REFERENCES agency (agency_id)
);

CREATE TABLE IF NOT EXISTS Patient
(
	patient_id						MEDIUMINT		PRIMARY KEY AUTO_INCREMENT,
    patient_fname 				VARCHAR(45)	NOT NULL, 
    patient_lname 				VARCHAR(45)	NOT NULL, 
    patient_phone					CHAR(10)			NOT NULL,
    patient_language			VARCHAR(45)	NOT NULL,
    hospital_id						MEDIUMINT		NOT NULL,
		CONSTRAINT FK_patient_hospital_id
		FOREIGN KEY (hospital_id)
		REFERENCES hospital (hospital_id)
);


CREATE TABLE IF NOT EXISTS interpreter
(
	interpreter_id			MEDIUMINT	PRIMARY KEY AUTO_INCREMENT,
    interpreter_fname		VARCHAR(45)	NOT NULL,
    interpreter_lname		VARCHAR(45)	NOT NULL,
    interpreter_phone		CHAR(10)	NOT NULL,
    interpreter_language	VARCHAR(45)	NOT NULL,
    agency_id				MEDIUMINT	NOT NULL,
    CONSTRAINT agency_interpreter_fk
		FOREIGN KEY (agency_id)
        REFERENCES agency(agency_id)
);

CREATE TABLE IF NOT EXISTS appointment
(
	patient_id			MEDIUMINT	AUTO_INCREMENT,
    schedule_datetime	DATETIME	NOT NULL,
    schedule_endtime	DATETIME	NOT NULL,
    interpreter_id		MEDIUMINT	NOT NULL,
    CONSTRAINT patient_schedule_datetime_appointment_pk
		PRIMARY KEY (patient_id, schedule_datetime),
    CONSTRAINT patient_appointment_fk 
		FOREIGN KEY (patient_id)
		REFERENCES patient(patient_id),
	CONSTRAINT interpreter_appointment_fk
		FOREIGN KEY (interpreter_id)
        REFERENCES interpreter(interpreter_id)
);

CREATE TABLE IF NOT EXISTS voucher
(
	voucher_id			MEDIUMINT		PRIMARY KEY	AUTO_INCREMENT,
    voucher_duration	MEDIUMINT		NOT NULL, 
    voucher_mileage		DECIMAL(3,1), 
    interpreter_id		MEDIUMINT		NOT NULL,
    hospital_id			MEDIUMINT		NOT NULL,
    agency_id			MEDIUMINT		NOT NULL,
    CONSTRAINT interpreter_voucher_fk
    FOREIGN KEY (interpreter_id)
    REFERENCES interpreter (interpreter_id), 
		CONSTRAINT hospital_voucher_fk
		FOREIGN KEY (hospital_id)
		REFERENCES hospital (hospital_id), 
			CONSTRAINT agency_voucher_fk
			FOREIGN KEY (agency_id)
			REFERENCES agency (agency_id)
);

#--------------------------------------Values---------------------------------------------
INSERT Hospital
VALUES 	
		(1001, 'Virginia Mason', 	'1100 9th Ave, Seattle, WA 98101'),
		(1002, 		'VA Hospital', 	'1660 S Columbian Way, Seattle, WA 98108'), 
        (DEFAULT,	'Skyline Hospital', '211 NE Skyline Dr, White Salmon, WA 98672'), 
        (DEFAULT, 	'Group Health', '20200 54th Ave W, Lynnwood, WA 98036'), 
        (DEFAULT, 	'Harborview Medical Center', '325 9th Ave, Seattle, WA 98104'),
        (DEFAULT, 	'Northwest Hospital', '1550 N 115th St, Seattle, WA 98133'), 
        (DEFAULT, 	'Seattle Childrens', '4800 Sand Point Way NE, Seattle, WA 98105');

INSERT agency
VALUES 	(6001, 		'Lakeshore Medical', 	'605 N. Mechanic Street New Orleans, LA 70115', '6335634043'),
		(6002, 		'Gratitude Medical', 	'56 Rockwell St.Hartford, CT 06106', 			'3898641786'), 
        (DEFAULT,	'GoodNews Interpreter', '128 E. Catherine Street Lynn, MA 01902', 		'7798186811'), 
        (DEFAULT, 	'Interpreter Recall', 	'33 Brown Rd. Howell, NJ 07731', 				'6325040693'), 
        (DEFAULT, 	'Help Define', 			'349 Argyle Ave. Morrisville, PA 19067', 		'2054961314'),
        (DEFAULT, 	'Just Help', 			'885 Hilltop Drive Glen Burnie, MD 21060', 		'8674054096'), 
        (DEFAULT, 	'Window Sycamore', 		'9453 Cardinal Court Sulphur, LA 70663', 		'6305532045');
        
INSERT invoice 
VALUES  (7001, 	  12742.23, '2017-06-06 18:58:01', 1002, 6005),
		(7002 ,   5689.23, 	'2002-02-08 10:53:42', 1002, 6005),
		(7003 ,   2589.25, 	'2018-06-02 00:03:52', 1004, 6007),
		(DEFAULT, 14785.36, '2017-03-27 11:51:12', 1007, 6006),
		(DEFAULT, 235.9, 	'2016-02-22 02:24:36', 1001, 6001),
		(DEFAULT, 8995.36, 	'2014-03-13 22:05:30', 1004, 6003),
		(DEFAULT, 895.36, 	'2017-09-06 17:59:36', 1006, 6004),
		(DEFAULT, 1457.1, 	'2012-10-21 19:03:16', 1003, 6002),
		(DEFAULT, 2563.2, 	'2013-08-24 17:43:04', 1003, 6001),
		(DEFAULT, 1422.2, 	'2015-08-13 11:21:23', 1001, 6006),
		(DEFAULT, 14589.21, '2004-08-26 17:40:36', 1007, 6005),
		(DEFAULT, 99852.0, 	'2007-11-23 06:12:48', 1004, 6001),
		(DEFAULT, 1458.41, 	'2011-07-17 11:14:51', 1006, 6002),
		(DEFAULT, 1278.3, 	'2015-10-16 07:13:20', 1005, 6003),
		(DEFAULT, 14721.2, 	'2012-03-28 09:12:58', 1006, 6007);
        
INSERT Patient
VALUES  
		(2001, 'Emma', 'Smith', '2065532045', 'Korean', 1001),
		(2002, 'Olivia', 'Jones', '2063192988', 'Chinese',	1002),
		(2003 , 'Ava', 	'King', '2065039788', 'Spanish',1005),
		(DEFAULT, 'Hill', 'Scott', '2068025643', 'Spanish',	1007),
		(DEFAULT, 'Sophia', 'Adam', '2067798342', 'Korean',1006	),
		(DEFAULT, 'Mia', 'Baker', '2063248569', 'Arabic', 1003),
		(DEFAULT, 'Amelia', 'Perez', '2065779836', 'Russian',	1004),
		(DEFAULT, 'Evelyn', 'Turner', '5092291341', 'Japanese',	1006),
		(DEFAULT, 'Harper', 'Carter', '5095679832', 'German',	1007),
		(DEFAULT, 'Ella', 'Garcia', '2067834389', 'Korean',1006),
		(DEFAULT, 'Grace', 'Phillips', '2069874354', 'French',	1001),
		(DEFAULT, 'Leah', 'White', '2067896472', 'Chinese', 1005),
		(DEFAULT, 'Luna', 'Clark', '2069358453', 'Chinese', 1004),
		(DEFAULT, 'Hazel', 'Harris', '2066941221', 'Russian', 1003),
		(DEFAULT, 'Anna', 	'Reed', '4253945496', 'French',	1002),
        (DEFAULT, 'Lucy', 'Cooper', '4256785498', 'Russian', 1003),
        (DEFAULT, 'Bella', 'Cox', '4259802131', 'Arabic',	1006),
        (DEFAULT, 'Sarah', 'Gray', '4259874567', 'Japanese', 1007),
        (DEFAULT, 'Maya', 	'Bell', '4255643246', 'Arabic', 1005),
        (DEFAULT, 'Alexa', 'Allen', '4259874358', 'French', 1004);
        
INSERT interpreter
	VALUES
    (4001,    'Charles', 'Chan', 	 '2062348909', 'Chinese',   6002),
    (DEFAULT, 'Jill', 'Lee', 		 '4252343534', 'Korean',    6004),
    (DEFAULT, 'Natalia', 'Pavlosky', '3603458909', 'Russian',   6001),
    (DEFAULT, 'Adrian', 'Rodriguez', '4251239087', 'Spanish',   6003),
    (DEFAULT, 'Jennifer', 'Lopez', 	 '2552456509', 'Spanish',   6007),
    (DEFAULT, 'Anushka', 'Sharma', 	 '2062128349', 'Arabic', 	6005),
    (DEFAULT, 'Renata', 'Oliveira',  '4251341909', 'Japanese',  6002),
    (DEFAULT, 'Tony', 'Kim', 		 '2122328127', 'Korean',    6006),
    (DEFAULT, 'Gordon', 'Bigfoot', 	 '2062347123', 'Russian',   6004),
    (DEFAULT, 'Sabrina', 'Tzu', 	 '2062378754', 'Chinese',   6002);
    
INSERT appointment
	VALUES
    (2001, 	  '2017-07-05 10:30:00', '2017-07-05 11:00:00', 4002),
    (2002, '2017-06-29 11:30:00', '2017-06-29 12:00:00', 4001),
    (2007, '2017-06-30 13:30:00', '2017-06-30 15:00:00', 4009),
    (2010, '2017-07-08 08:30:00', '2017-07-08 12:30:00', 4008),
    (2003, '2017-07-08 09:30:00', '2017-07-08 10:00:00', 4003),
    (2017, '2017-07-12 07:00:00', '2017-07-12 11:00:00', 4006),
    (2018, '2017-07-14 14:00:00', '2017-07-14 16:30:00', 4007),
    (2004, '2017-07-14 14:30:00', '2017-07-14 17:00:00', 4005),
    (2006, '2017-07-15 09:00:00', '2017-07-15 12:30:00', 4006),
    (2001, '2017-07-15 10:30:00', '2017-07-15 12:00:00', 4008),
    (2019, '2017-07-16 08:30:00', '2017-07-16 14:00:00', 4006),
    (2013, '2017-07-24 10:30:00', '2017-07-24 15:00:00', 4010),
    (2014, '2017-08-03 06:30:00', '2017-08-03 12:30:00', 4003),
    (2008, '2017-08-06 10:30:00', '2017-08-06 11:00:00', 4007),
    (2004, '2017-08-11 08:30:00', '2017-08-11 13:00:00', 4004);
        
INSERT voucher
VALUES  (5001, 	  256, NULL, 4010, 1006, 6006), 
		(5002, 	  890, 8,	 4009, 1004, 6007),
        (5003,    140, NULL, 4004, 1007, 6002),
        (DEFAULT, 457, NULL, 4001, 1002, 6004),
        (DEFAULT, 570, 2.1,  4002, 1005, 6003),
        (DEFAULT, 888, NULL, 4004, 1006, 6002),
        (DEFAULT, 120, NULL, 4002, 1007, 6001),
        (DEFAULT, 120, 1.5,  4003, 1003, 6005),
        (DEFAULT, 180, 1.1,  4002, 1001, 6001),
        (DEFAULT, 360, NULL, 4005, 1003, 6007),
        (DEFAULT, 80,  NULL, 4001, 1007, 6006),
        (DEFAULT, 60,  NULL, 4006, 1004, 6002),
        (DEFAULT, 240, 2.1,  4003, 1007, 6003),
        (DEFAULT, 560, 5.5,  4002, 1005, 6005),
        (DEFAULT, 60,  NULL, 4001, 1004, 6002);

#calculated hourly wage as $19.
CREATE VIEW billing
AS
	SELECT hospital_name AS Hospital, invoice_amount AS Invoice, agency_name AS Agency, ROUND(voucher_duration / 60 * 19, 2) AS Voucher
	FROM hospital
		JOIN invoice 
			USING (hospital_id)
		JOIN agency
			USING (agency_id)
		JOIN voucher
			USING (agency_id);
        
SELECT * FROM billing;

SELECT hospital_name AS Hospital, COUNT(*) AS 'Patient Count'
FROM hospital
	JOIN patient
		USING (hospital_id)
GROUP BY hospital_id
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;




        
        
