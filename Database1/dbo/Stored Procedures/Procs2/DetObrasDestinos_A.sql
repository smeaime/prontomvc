
CREATE Procedure [dbo].[DetObrasDestinos_A]

@IdDetalleObraDestino int  output,
@IdObra int,
@Destino varchar(13),
@Detalle ntext,
@ADistribuir varchar(2),
@InformacionAuxiliar varchar(20) = Null,
@TipoConsumo int = Null

AS 

INSERT INTO [DetalleObrasDestinos]
(
 IdObra,
 Destino,
 Detalle,
 ADistribuir,
 InformacionAuxiliar,
 TipoConsumo
)
VALUES
(
 @IdObra,
 @Destino,
 @Detalle,
 @ADistribuir,
 @InformacionAuxiliar,
 @TipoConsumo
)

SELECT @IdDetalleObraDestino=@@identity
RETURN(@IdDetalleObraDestino)
