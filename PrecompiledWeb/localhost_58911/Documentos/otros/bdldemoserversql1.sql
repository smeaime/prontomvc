use demoPronto



 exec Requerimientos_TX_PendientesDeFirma 
 exec Requerimientos_TX_Pendientes1 'T'
 exec Requerimientos_TX_Pendientes1 'P'


 --sp_helptext Requerimientos_TX_PendientesDeFirma


 exec AutorizacionesPorComprobante_EliminarFirmas 
 exec AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante 4,18317
 
 exec Autorizaciones_TX_CantidadAutorizaciones 4,9.00
 exec Autorizaciones_TX_CantidadAutorizaciones 4,0

 exec autorizaciones_tx_ca

 select * from pedidos


 select * from bdlmaster.dbo.userdatosextendidos

 exec DetPedidos_TX_DetallesParametrizados 18259,1
  exec DetPedidos_TX_DetallesParametrizados  11,


declare @p5 int
set @p5=0
exec sp_executesql N'EXEC @RETURN_VALUE = [dbo].[DetPedidos_TX_DetallesParametrizados] @IdPedido = @p0, @NivelParametrizacion = @p1',N'@p0 int,@p1 int,@RETURN_VALUE int output',@p0=18259,@p1=-1,@RETURN_VALUE=@p5 output
select @p5


update cartasdeporte set CuentaOrden2=222 where idcartadeporte=2464
update cartasdeporte set CuentaOrden1=222 where idcartadeporte=2464
select * from CartasDePorte



use demoPronto

