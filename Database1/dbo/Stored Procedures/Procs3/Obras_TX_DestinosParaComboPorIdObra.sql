
CREATE Procedure [dbo].[Obras_TX_DestinosParaComboPorIdObra]

@IdObra int

AS 

SELECT IdDetalleObraDestino, Destino+' - '+Convert(varchar(60),IsNull(Detalle,'')) as [Titulo]
FROM DetalleObrasDestinos
WHERE @IdObra=-1 or IdObra=@IdObra
ORDER BY Destino
