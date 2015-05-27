
CREATE Procedure [dbo].[Asientos_TX_PorArchivoImportacion]
@ArchivoImportacion varchar(200)
AS 
SELECT TOP 1 *
FROM Asientos
WHERE IsNull(ArchivoImportacion,'')=@ArchivoImportacion
