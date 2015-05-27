





























CREATE Procedure [dbo].[Localidades_TX_PorId]
@IdLocalidad smallint
AS 
Select 
 Localidades.*,
 Provincias.IdPais
FROM Localidades
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Localidades.IdProvincia
WHERE (IdLocalidad=@IdLocalidad)





























