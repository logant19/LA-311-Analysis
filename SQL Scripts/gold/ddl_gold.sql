/*
==============================================================================
DDL Script: Create Gold Views
==============================================================================
Script Purpose:
	This script creates views for the gold layer.
	The gold layer represents the final tables that will be used for analysis.

	Data is transformed and aggregated from the silver layer to produce 
	exportable tables for analysis in Excel.
==============================================================================
*/

-- ===========================================================================
-- Create Fact Table: gold.request_info
-- ===========================================================================

IF OBJECT_ID('gold.request_info', 'V') IS NOT NULL
	DROP VIEW gold.request_info;
GO

CREATE VIEW gold.request_info AS
SELECT 
	SRnumber,
	CreatedDate,
	MONTH(CreatedDate) AS RequestMonth,
    YEAR(CreatedDate) AS RequestYear,
	UpdatedDate,
	ActionTaken,
	Owner,
	CASE 
		WHEN RequestType LIKE'%Streetlight%' THEN 'Streetlight Issue'
		ELSE RequestType
	END AS RequestType,
	Status,
	RequestSource,
	CreatedByUserOrganization,
	MobileOS,
	Anonymous,
	AssignTo,
	ServiceDate,
	ClosedDate,
	CASE 
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) IS NULL THEN NULL
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 1 THEN 'Within an Hour'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 6 THEN 'Within 6 Hours'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 12 THEN 'Within 12 Hours'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 24 THEN 'Within 1 Day'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 48 THEN 'Within 2 Days'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 72 THEN 'Within 3 Days'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 168 THEN 'Within a Week'
		ELSE 'Over a Week'
	END AS ResponseTime,
	APC,
	CD,
	CDMember,
	NC,
	NCName,
	PolicePrecinct
FROM silver.la311_2024
UNION ALL
SELECT 
	SRnumber,
	CreatedDate,
	MONTH(CreatedDate) AS RequestMonth,
    YEAR(CreatedDate) AS RequestYear,
	UpdatedDate,
	ActionTaken,
	Owner,
	CASE 
		WHEN RequestType LIKE'%Streetlight%' THEN 'Streetlight Issue'
		ELSE RequestType
	END AS RequestType,
	Status,
	RequestSource,
	CreatedByUserOrganization,
	MobileOS,
	Anonymous,
	AssignTo,
	ServiceDate,
	ClosedDate,
	CASE 
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) IS NULL THEN NULL
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 1 THEN 'Within an Hour'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 6 THEN 'Within 6 Hours'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 12 THEN 'Within 12 Hours'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 24 THEN 'Within 1 Day'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 48 THEN 'Within 2 Days'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 72 THEN 'Within 3 Days'
		WHEN DATEDIFF(HOUR,CreatedDate,ClosedDate) <= 168 THEN 'Within a Week'
		ELSE 'Over a Week'
	END AS ResponseTime,
	APC,
	CD,
	CDMember,
	NC,
	NCName,
	PolicePrecinct
FROM silver.la311_2023
GO

-- ===========================================================================
-- Create Dimension: gold.location_info
-- ===========================================================================

IF OBJECT_ID('gold.location_info', 'V') IS NOT NULL
	DROP VIEW gold.location_info;
GO
CREATE VIEW gold.location_info AS
SELECT 
	SRnumber,
	AddressVerified,
	ApproximateAddress,
	Address,
	HouseNumber,
	Direction,
	StreetName,
	Suffix,
	ZipCode,
	Latitude,
	Longitude,
	Location,
	TBMPage,
	TBMColumn,
	TBMRow
FROM silver.la311_2023
GO

-- ===========================================================================
-- Create Final Aggregation: gold.aggregated_requests
-- ===========================================================================

IF OBJECT_ID('gold.aggregated_requests', 'V') IS NOT NULL
	DROP VIEW gold.aggregated_requests;
GO
CREATE VIEW gold.aggregated_requests AS
SELECT
	RequestType,
	ISNULL(APC,'Unknown') AS APC,
	ISNULL(NCName,'Unknown') AS NCName,
	CD,
	ISNULL(PolicePrecinct,'Unknown') AS PolicePrecinct,
	ISNULL(Status, 'Unknown') AS Status,
	ISNULL(ResponseTime, 'Open Request') AS ResponseTime,
	CASE
		WHEN RequestSource IS NULL THEN 'Unknown'
		WHEN RequestSource = 'Voicemail' THEN 'Call'
		WHEN RequestSource = 'Walk-In' THEN 'Other'
		WHEN RequestSource = 'Fax' THEN 'Other'
		WHEN RequestSource = 'Web Form' THEN 'Other'
		WHEN RequestSource = 'Queue Initiated Customer Call' THEN 'Call'
		WHEN RequestSource = 'City Attorney' THEN 'Other'
		WHEN RequestSource = 'Radio' THEN 'Other'
		WHEN RequestSource = 'Letter' THEN 'Other'
		WHEN RequestSource = 'Mayor''s Office' THEN 'Other'
		WHEN RequestSource = 'Chat' THEN 'Other'
		WHEN RequestSource = 'Social' THEN 'Other'
		WHEN RequestSource = 'Email' THEN 'Other' 
		WHEN RequestSource = 'Council''s Office' THEN 'Other'
		ELSE RequestSource
	END AS RequestSource,
	RequestMonth,
	RequestYear,
	COUNT(*) AS RequestCount
FROM gold.request_info
GROUP BY RequestType, ResponseTime, APC, NCName, CD, PolicePrecinct, Status, RequestSource, RequestMonth, RequestYear
