/*
==================================================================
DDL Script: Create Bronze Tables
==================================================================
Script Purpose:
	This script creates a table for the raw data in the 'bronze' 
	schema, dropping existing tables if they already exist.
		
Run this script to redefine the DDL structure of 'bronze' schema.
==================================================================
*/

IF OBJECT_ID('bronze.la311_2023', 'U') IS NOT NULL
	DROP TABLE bronze.la311_2023;
GO

CREATE TABLE bronze.la311_2023 (
	SRnumber					NVARCHAR(15),
	CreatedDate					DATETIME,
	UpdatedDate					DATETIME,
	ActionTaken					NVARCHAR(30),
	Owner						NVARCHAR(10),
	RequestType					NVARCHAR(30),
	Status						NVARCHAR(20),
	RequestSource				NVARCHAR(30),
	CreatedByUserOrganization	NVARCHAR(20),
	MobileOS					NVARCHAR(10),
	Anonymous					NVARCHAR(10),
	AssignTo					NVARCHAR(30),
	ServiceDate					DATETIME,
	ClosedDate					DATETIME,
	AddressVerified				NVARCHAR(10),
	ApproximateAddress			NVARCHAR(10),
	Address						NVARCHAR(MAX),
	HouseNumber					NVARCHAR(50),
	Direction					NVARCHAR(10),
	StreetName					NVARCHAR(50),
	Suffix						NVARCHAR(10),
	ZipCode						NVARCHAR(10),
	Latitude					FLOAT,
	Longitude					FLOAT,
	Location					NVARCHAR(MAX),
	TBMPage						NVARCHAR(50),
	TBMColumn					NVARCHAR(10),
	TBMRow						INT,
	APC							NVARCHAR(100),
	CD							INT,
	CDMember					NVARCHAR(100),
	NC							INT,
	NCName						NVARCHAR(100),
	PolicePrecinct				NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.la311_2024', 'U') IS NOT NULL
	DROP TABLE bronze.la311_2024;
GO

CREATE TABLE bronze.la311_2024 (
	SRnumber					NVARCHAR(15),
	CreatedDate					DATETIME,
	UpdatedDate					DATETIME,
	ActionTaken					NVARCHAR(30),
	Owner						NVARCHAR(10),
	RequestType					NVARCHAR(30),
	Status						NVARCHAR(20),
	RequestSource				NVARCHAR(30),
	CreatedByUserOrganization	NVARCHAR(20),
	MobileOS					NVARCHAR(10),
	Anonymous					NVARCHAR(10),
	AssignTo					NVARCHAR(30),
	ServiceDate					DATETIME,
	ClosedDate					DATETIME,
	AddressVerified				NVARCHAR(10),
	ApproximateAddress			NVARCHAR(10),
	Address						NVARCHAR(MAX),
	HouseNumber					NVARCHAR(50),
	Direction					NVARCHAR(10),
	StreetName					NVARCHAR(50),
	Suffix						NVARCHAR(10),
	ZipCode						NVARCHAR(10),
	Latitude					FLOAT,
	Longitude					FLOAT,
	Location					NVARCHAR(MAX),
	TBMPage						NVARCHAR(50),
	TBMColumn					NVARCHAR(10),
	TBMRow						INT,
	APC							NVARCHAR(100),
	CD							INT,
	CDMember					NVARCHAR(100),
	NC							INT,
	NCName						NVARCHAR(100),
	PolicePrecinct				NVARCHAR(50)
);
GO

