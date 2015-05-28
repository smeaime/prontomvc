












CREATE Procedure [dbo].[Provincias_TX_PorNombre]
@Nombre varchar(50)
AS 
SELECT *
FROM Provincias
WHERE (Nombre=@Nombre)












