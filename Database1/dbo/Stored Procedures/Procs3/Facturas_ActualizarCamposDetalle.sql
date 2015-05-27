




CREATE Procedure [dbo].[Facturas_ActualizarCamposDetalle]
@IdDetalleFactura int,
@OrigenDescripcion int,
@Observaciones ntext
As
Update DetalleFacturas
Set 
 OrigenDescripcion=@OrigenDescripcion,
 Observaciones=@Observaciones
Where (IdDetalleFactura=@IdDetalleFactura)
Return(@IdDetalleFactura)




