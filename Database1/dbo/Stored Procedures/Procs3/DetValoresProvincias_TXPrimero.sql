
CREATE PROCEDURE [dbo].[DetValoresProvincias_TXPrimero]
AS
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01633'
set @vector_T='00100'
SELECT TOP 1
 DetV.IdDetalleValorProvincias,
 Provincias.Nombre as [Provincia],
 DetV.Porcentaje as [Porc.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValoresProvincias DetV
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=DetV.IdProvincia
