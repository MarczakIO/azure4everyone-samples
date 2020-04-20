CREATE TABLE ExportedTables (
	ID int identity(1,1) Primary Key,
	Table_Name varchar(100) not null
);
GO
INSERT INTO ExportedTables(Table_Name)
VALUES
('Cars'),
('Movies')