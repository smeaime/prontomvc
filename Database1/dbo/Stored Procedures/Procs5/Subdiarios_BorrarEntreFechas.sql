



























CREATE PROCEDURE [dbo].[Subdiarios_BorrarEntreFechas]
@Desde datetime,
@Hasta datetime
AS
DELETE FROM Subdiarios
WHERE Subdiarios.FechaComprobante between @Desde and DATEADD(n,1439,@hasta)



























