
CREATE Procedure [dbo].[DetObrasDestinos_M]

@IdDetalleObraDestino int,
@IdObra int,
@Destino varchar(13),
@Detalle ntext,
@ADistribuir varchar(2),
@InformacionAuxiliar varchar(20),
@TipoConsumo  int

AS

UPDATE [DetalleObrasDestinos]
SET 
 IdObra=@IdObra,
 Destino=@Destino,
 Detalle=@Detalle,
 ADistribuir=@ADistribuir,
 InformacionAuxiliar=@InformacionAuxiliar,
 TipoConsumo=@TipoConsumo
WHERE (IdDetalleObraDestino=@IdDetalleObraDestino)

RETURN(@IdDetalleObraDestino)
