
CREATE Procedure [dbo].[DetObrasDestinos_TX_PorCodigo]
@IdObra int,
@Destino varchar(13)
AS 
SELECT *
FROM [DetalleObrasDestinos]
WHERE IdObra=@IdObra and Destino=@Destino
