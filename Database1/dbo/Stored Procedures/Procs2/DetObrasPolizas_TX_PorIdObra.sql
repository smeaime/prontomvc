


CREATE Procedure [dbo].[DetObrasPolizas_TX_PorIdObra]
@IdObra int
AS 
SELECT *
FROM [DetalleObrasPolizas]
WHERE (IdObra=@IdObra)


