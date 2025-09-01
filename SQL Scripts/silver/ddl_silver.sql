/*
=================================================================
DDL Script: Create Silver Tables
=================================================================
Script Purpose:
	This script creates tables in the 'silver' schema, dropping 
	existing tables if they already exist.

Run this script to redefine the DDL structure of 'silver' tables.
=================================================================
*/

IF OBJECT_ID('silver.la311_2023', 'U') IS NOT NULL
	DROP TABLE silver.la311_2023;
GO

CREATE TABLE silver.la311_2023 (
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
	Address						NVARCHAR(200),
	HouseNumber					INT,
	Direction					NVARCHAR(10),
	StreetName					NVARCHAR(50),
	Suffix						NVARCHAR(10),
	ZipCode						NVARCHAR(5),
	Latitude					FLOAT,
	Longitude					FLOAT,
	Location					NVARCHAR(50),
	TBMPage						INT,
	TBMColumn					NVARCHAR(5),
	TBMRow						INT,
	APC							NVARCHAR(30),
	CD							INT,
	CDMember					NVARCHAR(50),
	NC							INT,
	NCName						NVARCHAR(50),
	PolicePrecinct				NVARCHAR(30)
);
GO

IF OBJECT_ID('silver.la311_2024', 'U') IS NOT NULL
	DROP TABLE silver.la311_2024;
GO

CREATE TABLE silver.la311_2024 (
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
	Address						NVARCHAR(200),
	HouseNumber					INT,
	Direction					NVARCHAR(10),
	StreetName					NVARCHAR(50),
	Suffix						NVARCHAR(10),
	ZipCode						NVARCHAR(5),
	Latitude					FLOAT,
	Longitude					FLOAT,
	Location					NVARCHAR(50),
	TBMPage						INT,
	TBMColumn					NVARCHAR(5),
	TBMRow						INT,
	APC							NVARCHAR(30),
	CD							INT,
	CDMember					NVARCHAR(50),
	NC							INT,
	NCName						NVARCHAR(50),
	PolicePrecinct				NVARCHAR(30)
);
GO