


CREATE Procedure [dbo].[DetObrasPolizas_M]

@IdDetalleObraPoliza int,
@IdObra int,
@IdTipoPoliza int,
@IdProveedor int,
@NumeroPoliza numeric(18,0),
@FechaVigencia datetime,
@FechaVencimientoCuota datetime,
@Importe numeric(18,2),
@FechaEstimadaRecupero datetime,
@FechaRecupero datetime,
@CondicionRecupero varchar(100),
@MotivoDeContratacionSeguro varchar(100),
@Observaciones ntext,
@FechaFinalizacionCobertura datetime

AS

UPDATE [DetalleObrasPolizas]
SET 
 IdObra=@IdObra,
 IdTipoPoliza=@IdTipoPoliza,
 IdProveedor=@IdProveedor,
 NumeroPoliza=@NumeroPoliza,
 FechaVigencia=@FechaVigencia,
 FechaVencimientoCuota=@FechaVencimientoCuota,
 Importe=@Importe,
 FechaEstimadaRecupero=@FechaEstimadaRecupero,
 FechaRecupero=@FechaRecupero,
 CondicionRecupero=@CondicionRecupero,
 MotivoDeContratacionSeguro=@MotivoDeContratacionSeguro,
 Observaciones=@Observaciones,
 FechaFinalizacionCobertura=@FechaFinalizacionCobertura
WHERE (IdDetalleObraPoliza=@IdDetalleObraPoliza)
RETURN(@IdDetalleObraPoliza)


