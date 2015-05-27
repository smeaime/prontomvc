CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_RM]

@IdObra int,
@NumeroRequerimiento int,
@NumeroAcopio int,
@PorFecha int = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null,
@IdTemp int = Null

AS 

SET @PorFecha=IsNull(@PorFecha,-1)
SET @FechaDesde=IsNull(@FechaDesde,GetDate())
SET @FechaHasta=IsNull(@FechaHasta,GetDate())
SET @IdTemp=IsNull(@IdTemp,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111141111111111133'
SET @vector_T='09609424301142242E02011229213452F222100'

SELECT
 Tmp.IdTemp,
 Tmp.Id,
 Tmp.Obra,
 Tmp.Equipo,
 Tmp.CentroCosto as [Centro de costo],
 Tmp.Comprobante,
 Tmp.Numero,
 Tmp.Fecha,
 Null as [Nombre de LA],
 Tmp.Item,
 Tmp.Emisor,
 Tmp.Sector,
 Tmp.FechaNecesidad as [Fecha nec.],
 Tmp.CantidadItems as [Tot.items],
 Tmp.Cumplido,
 Tmp.FechaUltimaFirma as [Fecha ult.firma],
 Tmp.Codigo as [Codigo],
 Tmp.Articulo as [Articulo],
 DetRM.Observaciones as [Observaciones item],
 Tmp.Cantidad,
 substring(Tmp.UnidadEn,1,25) as [Unidad en],
 Tmp.Cantidad1 as [Med.1],
 Tmp.Cantidad2 as [Med.2],
 Tmp.CantidadPedida as [Cant.Ped.],
 Tmp.CantidadRecibida as [Cant.Rec.],
 Tmp.Observaciones,
 Case When Tmp.CantidadFacturasAsignadas=0 Then Null Else Tmp.CantidadFacturasAsignadas End as [Cant.Fac.],
 Tmp.CuentaContable as [Cuenta contable],
 Tmp.ProveedorAsignado as [Proveedor asignado],
 Tmp.CompradoPor as [Comprado por],
 Tmp.FechaLlamadoAProveedor as [Fecha llamado],
 DetRM.CodigoDistribucion as [Cod.Dist.],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 Tmp.CantidadPedida - Tmp.CantidadRecibida as [CantidadPendiente],
 IsNull((Select Sum(IsNull(dp.Cantidad,0) * IsNull(dp.Precio,0) * 
			(100-IsNull(dp.PorcentajeBonificacion,0))/100 * 
			(100-IsNull(Pedidos.PorcentajeBonificacion,0))/100)
	 From DetallePedidos dp
	 Left Outer Join Pedidos On Pedidos.IdPedido=dp.IdPedido
	 Where dp.IdDetalleRequerimiento=Tmp.Id and (dp.Cumplido is null or dp.Cumplido<>'AN')),0) - 
 Isnull((Select Sum(IsNull(dr.Cantidad,0)*IsNull(dr.CostoUnitario,0))
 	 From DetalleRecepciones dr 
	 Left Outer Join Recepciones On Recepciones.IdRecepcion=dr.IdRecepcion
	 Left Outer Join DetallePedidos dp1 On dp1.IdDetallePedido=dr.IdDetallePedido
	 Where dr.IdDetalleRequerimiento=Tmp.Id and 
		(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [ImportePendiente],
 DetRM.MoP as [M/P],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM _TempEstadoDeObras Tmp 
LEFT OUTER JOIN DetalleRequerimientos DetRM ON DetRM.IdDetalleRequerimiento=Tmp.Id
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetRM.IdRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
--LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetRM.IdArticulo
WHERE Tmp.Comprobante='R.M.' and 
	(@IdObra=-1 or Tmp.IdObra=@IdObra) and 
	(@NumeroRequerimiento=-1 or Tmp.Numero=@NumeroRequerimiento)  and 
	(@PorFecha=-1 or Tmp.Fecha between @FechaDesde and @FechaHasta) and 
	(@IdTemp=-1 or Tmp.IdTemp=@IdTemp)
ORDER BY Obra, Equipo, Articulo