CREATE Procedure [dbo].[DetObrasEquiposInstalados_TX_PorIdObra]

@IdObra int

AS 

SELECT *
FROM [DetalleObrasEquiposInstalados]
WHERE (IdObra=@IdObra)