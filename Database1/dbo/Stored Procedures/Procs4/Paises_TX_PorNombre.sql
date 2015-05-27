





























CREATE Procedure [dbo].[Paises_TX_PorNombre]
@Descripcion varchar(50)
AS 
SELECT *
FROM Paises
WHERE (Descripcion=@Descripcion)





























