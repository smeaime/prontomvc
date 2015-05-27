


CREATE Procedure [dbo].[Cajas_TX_PorDescripcion]
@Descripcion varchar(50)
AS 
SELECT TOP 1 *
FROM Cajas
WHERE (Descripcion=@Descripcion)


