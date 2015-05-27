CREATE  Procedure [dbo].[ListasPreciosDetalle_M]

@IdListaPreciosDetalle int,
@IdListaPrecios int,
@IdArticulo int,
@Precio numeric(18,2),
@IdDestinoDeCartaDePorte int,
@PrecioDescargaLocal numeric(19,4),
@PrecioDescargaExportacion numeric(19,4),
@PrecioCaladaLocal numeric(19,4),
@PrecioCaladaExportacion numeric(19,4),
@PrecioRepetidoPeroConPrecision numeric(19,4),
@IdCliente int,
@Precio2 numeric(18,2),
@Precio3 numeric(18,2),
@FechaVigenciaHasta datetime,
@Precio4 numeric(18,2),
@Precio5 numeric(18,2),
@Precio6 numeric(18,2),
@PrecioExportacion numeric(19,4),
@PrecioEmbarque numeric(19,4),
@Precio7 numeric(18,2),
@Precio8 numeric(18,2),
@Precio9 numeric(18,2),
@PrecioEmbarque2 money,
@MaximaCantidadParaPrecioEmbarque numeric(18,2)

AS

UPDATE ListasPreciosDetalle
SET 
 IdListaPrecios=@IdListaPrecios,
 IdArticulo=@IdArticulo,
 Precio=@Precio,
 IdDestinoDeCartaDePorte=@IdDestinoDeCartaDePorte,
 PrecioDescargaLocal=@PrecioDescargaLocal,
 PrecioDescargaExportacion=@PrecioDescargaExportacion,
 PrecioCaladaLocal=@PrecioCaladaLocal,
 PrecioCaladaExportacion=@PrecioCaladaExportacion,
 PrecioRepetidoPeroConPrecision=@PrecioRepetidoPeroConPrecision,
 IdCliente=@IdCliente,
 Precio2=@Precio2,
 Precio3=@Precio3,
 FechaVigenciaHasta=@FechaVigenciaHasta,
 Precio4=@Precio4,
 Precio5=@Precio5,
 Precio6=@Precio6,
 PrecioExportacion=@PrecioExportacion,
 PrecioEmbarque=@PrecioEmbarque,
 Precio7=@Precio7,
 Precio8=@Precio8,
 Precio9=@Precio9,
 PrecioEmbarque2=@PrecioEmbarque2,
 MaximaCantidadParaPrecioEmbarque=@MaximaCantidadParaPrecioEmbarque
WHERE (IdListaPreciosDetalle=@IdListaPreciosDetalle)

RETURN(@IdListaPreciosDetalle)