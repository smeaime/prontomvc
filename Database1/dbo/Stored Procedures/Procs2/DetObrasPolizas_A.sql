


CREATE Procedure [dbo].[DetObrasPolizas_A]

@IdDetalleObraPoliza int  output,
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

Insert into [DetalleObrasPolizas]
(
 IdObra,
 IdTipoPoliza,
 IdProveedor,
 NumeroPoliza,
 FechaVigencia,
 FechaVencimientoCuota,
 Importe,
 FechaEstimadaRecupero,
 FechaRecupero,
 CondicionRecupero,
 MotivoDeContratacionSeguro,
 Observaciones,
 FechaFinalizacionCobertura
)
Values
(
 @IdObra,
 @IdTipoPoliza,
 @IdProveedor,
 @NumeroPoliza,
 @FechaVigencia,
 @FechaVencimientoCuota,
 @Importe,
 @FechaEstimadaRecupero,
 @FechaRecupero,
 @CondicionRecupero,
 @MotivoDeContratacionSeguro,
 @Observaciones,
 @FechaFinalizacionCobertura
)
Select @IdDetalleObraPoliza=@@identity
Return(@IdDetalleObraPoliza)


