
CREATE Procedure [dbo].[FletesPartesDiarios_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0224200'

SELECT 
 fpd.IdFleteParteDiario,
 Fletes.Descripcion as [Descripcion],
 Fletes.Patente as [Patente],
 fpd.Fecha as [Fecha],
 fpd.Cantidad as [Horas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM FletesPartesDiarios fpd
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=fpd.IdFlete
ORDER BY fpd.Fecha, Fletes.Patente
