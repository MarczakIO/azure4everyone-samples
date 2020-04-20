CREATE TABLE ExportedTables (
	ID int identity(1,1) Primary Key,
	Table_Schema varchar(100) not null,
	Table_Name varchar(100) not null
);
GO
INSERT INTO ExportedTables(Table_Schema, Table_Name)
VALUES
('dbo','Cars'),
('dbo','Movies')