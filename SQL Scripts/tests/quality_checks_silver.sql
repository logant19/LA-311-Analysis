--2023 Data
--Checking for duplicate values
SELECT
	SRnumber,
	COUNT(SRnumber)
FROM silver.la311_2023
GROUP BY SRnumber
HAVING COUNT(SRnumber) > 1;

--Checking for invalid dates
SELECT 
*
FROM silver.la311_2023
WHERE CreatedDate > UpdatedDate;

--Checking data consistency
SELECT DISTINCT
	ActionTaken
FROM silver.la311_2023;

SELECT DISTINCT
	Owner
FROM silver.la311_2023;

SELECT DISTINCT 
	RequestType
FROM silver.la311_2023;

SELECT DISTINCT 
	Status
FROM silver.la311_2023;

SELECT DISTINCT 
	RequestSource
FROM silver.la311_2023;

SELECT DISTINCT 
	CreatedByUserOrganization
FROM silver.la311_2023;

SELECT DISTINCT 
	MobileOS
FROM silver.la311_2023;

SELECT DISTINCT 
	Anonymous
FROM silver.la311_2023;

SELECT DISTINCT 
	AssignTo
FROM silver.la311_2023;

SELECT DISTINCT 
	AddressVerified
FROM silver.la311_2023;

SELECT DISTINCT 
	ApproximateAddress
FROM silver.la311_2023;

SELECT DISTINCT 
	Direction
FROM silver.la311_2023;

SELECT DISTINCT 
	APC
FROM silver.la311_2023;

SELECT DISTINCT 
	CDMember
FROM silver.la311_2023;

SELECT DISTINCT 
	NCName
FROM silver.la311_2023;

SELECT DISTINCT 
	PolicePrecinct
FROM silver.la311_2023;

--Checking for Invalid Latitude or Longitude
SELECT *
FROM silver.la311_2023
WHERE Latitude < 33 OR Latitude > 35;

SELECT *
FROM silver.la311_2023
WHERE Longitude < -119 OR Longitude > 117;

--Checking for Invalid Point Data
SELECT Location
FROM silver.la311_2023
WHERE Location NOT LIKE 'POINT%';

--2024 Data
--Checking for duplicate values
SELECT
	SRnumber,
	COUNT(SRnumber)
FROM silver.la311_2024
GROUP BY SRnumber
HAVING COUNT(SRnumber) > 1;

--Checking for invalid dates
SELECT 
*
FROM silver.la311_2024
WHERE CreatedDate > UpdatedDate;

--Checking data consistency
SELECT DISTINCT
	ActionTaken
FROM silver.la311_2024;

SELECT DISTINCT
	Owner
FROM silver.la311_2024;

SELECT DISTINCT 
	RequestType
FROM silver.la311_2024;

SELECT DISTINCT 
	Status
FROM silver.la311_2024;

SELECT DISTINCT 
	RequestSource
FROM silver.la311_2024;

SELECT DISTINCT 
	CreatedByUserOrganization
FROM silver.la311_2024;

SELECT DISTINCT 
	MobileOS
FROM silver.la311_2024;

SELECT DISTINCT 
	Anonymous
FROM silver.la311_2024;

SELECT DISTINCT 
	AssignTo
FROM silver.la311_2024;

SELECT DISTINCT 
	AddressVerified
FROM silver.la311_2024;

SELECT DISTINCT 
	ApproximateAddress
FROM silver.la311_2024;

SELECT DISTINCT 
	Direction
FROM silver.la311_2024;

SELECT DISTINCT 
	APC
FROM silver.la311_2024;

SELECT DISTINCT 
	CDMember
FROM silver.la311_2024;

SELECT DISTINCT 
	NCName
FROM silver.la311_2024;

SELECT DISTINCT 
	PolicePrecinct
FROM silver.la311_2024;

--Checking for Invalid Latitude or Longitude
SELECT *
FROM silver.la311_2024
WHERE Latitude > 35 OR Latitude < 33;

SELECT *
FROM silver.la311_2024
WHERE Longitude < -119 OR Longitude > 117;

--Checking for Invalid Point Data
SELECT Location
FROM silver.la311_2024
WHERE Location NOT LIKE 'POINT%';