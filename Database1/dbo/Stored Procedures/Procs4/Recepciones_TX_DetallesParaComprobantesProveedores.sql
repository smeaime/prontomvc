CREATE PROCEDURE [dbo].[Recepciones_TX_DetallesParaComprobantesProveedores]

@IdRecepcion int

AS

SET NOCOUNT ON

DECLARE @RegistroContableComprasAlActivo varchar(2), @RegistroContableRecepcionesAProvision varchar(2), @IdObraDefault int, @FechaRecepcion datetime, @TomarUltimoCambioCosto varchar(2)

SET @RegistroContableComprasAlActivo=IsNull((Select Top 1 Valor From Parametros2 Where Campo='RegistroContableComprasAlActivo'),'NO')
SET @RegistroContableRecepcionesAProvision=IsNull((Select Top 1 Valor From Parametros2 Where Campo='RegistroContableRecepcionesAProvision'),'NO')
SET @IdObraDefault=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdObraDefault'),0)
SET @FechaRecepcion=IsNull((Select Top 1 FechaRecepcion From Recepciones Where IdRecepcion=@IdRecepcion),0)
SET @TomarUltimoCambioCosto=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
									Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
									Where pic.Clave='Tomar ultimo cambio de precio en pedido'),'')

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleRecepcion INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetRec.IdDetalleRecepcion,
  Case 
	When @RegistroContableComprasAlActivo='SI' and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and IsNull(Rubros.IdCuentaComprasActivo,0)<>0
	 Then IsNull(Articulos.IdCuentaComprasActivo,Rubros.IdCuentaComprasActivo)
	When @RegistroContableRecepcionesAProvision='SI' and Exists(Select Top 1 S.IdSubdiario From Subdiarios S Where S.IdTipoComprobante=60 and S.IdComprobante=DetRec.IdRecepcion)
	 Then Proveedores.IdCuentaProvision
	When Articulos.IdCuentaCompras is not null 
	 Then IsNull((Select Top 1 c.IdCuenta From Cuentas c
				  Where c.IdObra=Case When @IdObraDefault=0 Then DetRec.IdObra Else Requerimientos.IdObra End and 
						Articulos.IdCuentaCompras=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Articulos.IdCuentaCompras)
/*
IsNull((Select Top 1 c.IdCuenta From Cuentas c
			 Where c.IdObra=Case When @IdObraDefault=0 Then DetRec.IdObra Else Requerimientos.IdObra End and 
				Rubros.IdCuentaComprasActivo=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Rubros.IdCuentaComprasActivo)
*/
	 Else IsNull((Select Top 1 c.IdCuenta From Cuentas c
				  Where c.IdObra=Case When @IdObraDefault=0 Then DetRec.IdObra Else Requerimientos.IdObra End and 
						(Rubros.IdCuentaCompras=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras1,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras2,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras3,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras4,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras5,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras6,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras7,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras8,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras9,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
						 IsNull(Rubros.IdCuentaCompras10,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto))),Rubros.IdCuentaCompras)
  End 
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE (DetRec.IdRecepcion = @IdRecepcion)


CREATE TABLE #Auxiliar2	
			(
			 IdDetalleRecepcion INTEGER,
			 IdDetallePedido INTEGER,
			 Precio NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  DetRec.IdDetalleRecepcion, 
  DetRec.IdDetallePedido, 
  Case When @TomarUltimoCambioCosto='SI'
		Then IsNull((Select Top 1 dpcp.PrecioNuevo From DetallePedidosCambiosPrecio dpcp Where dpcp.IdDetallePedido=DetRec.IdDetallePedido Order By dpcp.Fecha Desc),0)
		Else IsNull((Select Top 1 dpcp.PrecioAnterior From DetallePedidosCambiosPrecio dpcp 
					 Where dpcp.IdDetallePedido=DetRec.IdDetallePedido and 
							convert(datetime,convert(varchar,day(dpcp.Fecha))+'/'+convert(varchar,Month(dpcp.Fecha))+'/'+convert(varchar,Year(dpcp.Fecha)),103)>@FechaRecepcion Order By dpcp.Fecha),0)
  End
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 WHERE (DetRec.IdRecepcion = @IdRecepcion)

UPDATE #Auxiliar2
SET Precio=IsNull((Select Top 1 DetPed.Precio From DetallePedidos DetPed Where DetPed.IdDetallePedido = #Auxiliar2.IdDetallePedido),0)
WHERE Precio=0

SET NOCOUNT OFF

SELECT
 DetRec.IdDetalleRecepcion,
 DetRec.IdRecepcion,
 DetRec.IdDetallePedido,
 DetRec.IdDetalleRequerimiento,
 DetRec.IdObra,
 DetRec.Cantidad,
 DetRec.CostoUnitario,
 DetRec.IdArticulo,
 DetRec.Trasabilidad,
 DetRec.Observaciones,
 DetRec.Partida,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Articulos.AlicuotaIVA,
 Articulos.IdCuentaCompras,
 Articulos.Caracteristicas,
 Case When c1.IdTipoCuenta=2 Then #Auxiliar1.IdCuenta Else Null End as [IdCuenta],
 Case When c1.IdTipoCuenta=2 Then c1.Codigo Else Null End as [CodigoCuenta],
 #Auxiliar2.Precio,
 DetPed.PorcentajeIVA,
 DetPed.PorcentajeBonificacion,
 Case When IsNull(Pedidos.PorcentajeBonificacion,0)<>0 and IsNull(DetPed.PorcentajeBonificacion,0)=0
		 Then Round((DetRec.Cantidad*#Auxiliar2.Precio)-(DetRec.Cantidad*#Auxiliar2.Precio*IsNull(Pedidos.PorcentajeBonificacion,0)/100),2)
 		When (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0))<>0 and IsNull(Pedidos.Bonificacion,0)<>0 
		 Then Round(((DetRec.Cantidad*#Auxiliar2.Precio)-
					(DetRec.Cantidad*#Auxiliar2.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)) - 
					(Pedidos.Bonificacion / (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) * 
					 ((DetRec.Cantidad*#Auxiliar2.Precio)-
					  (DetRec.Cantidad*#Auxiliar2.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100))),2)
		Else Round((DetRec.Cantidad*#Auxiliar2.Precio)-(DetRec.Cantidad*#Auxiliar2.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100),2)
 End as [Importe],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Remito],
 Pedidos.NumeroPedido as [Pedido],
 DetPed.NumeroItem as [It.Ped],
 Pedidos.IdCondicionCompra,
 (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) as [T.Pedido],
 Pedidos.Bonificacion,
 Pedidos.NumeroSubcontrato,
 IsNull(Pedidos.IdProveedor,0) as [IdProveedor],
 Requerimientos.NumeroRequerimiento as [RM],
 Requerimientos.IdObra as [IdObraRM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetalleRequerimientos.IdDetalleObraDestino as [IdDetalleObraDestino],
 DetalleRequerimientos.IdPresupuestoObraRubro as [IdPresupuestoObraRubro],
 DetalleRequerimientos.CodigoDistribucion as [CodigoDistribucion],
 DetalleRequerimientos.IdPresupuestoObrasNodo as [IdPresupuestoObrasNodo],
 PresupuestoObrasNodos.IdCuenta as [IdCuentaPresupuestoObrasNodos],
 Case When c2.IdTipoCuenta=2 Then c2.Codigo Else Null End as [CodigoCuentaPresupuestoObrasNodos],
 c1.IdRubroFinanciero as [IdRubroFinanciero],
 c2.IdRubroFinanciero as [IdRubroFinancieroPresupuestoObrasNodos],
 E1.Nombre as [Comprador],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 Unidades.UnidadesPorPack,
 Unidades.TaraEnKg,
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 ControlesCalidad.Descripcion as [Control de Calidad],
 IsNull((Select Top 1 UnidadesEmpaque.NumeroUnidad From UnidadesEmpaque Where UnidadesEmpaque.IdDetalleRecepcion=DetRec.IdDetalleRecepcion),0) as [NumeroUnidad]
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar1 ON DetRec.IdDetalleRecepcion = #Auxiliar1.IdDetalleRecepcion
LEFT OUTER JOIN #Auxiliar2 ON DetRec.IdDetalleRecepcion = #Auxiliar2.IdDetalleRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Unidades ON DetRec.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN ControlesCalidad ON DetRec.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Empleados E1 ON DetalleRequerimientos.IdComprador = E1.IdEmpleado
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = DetalleRequerimientos.IdPresupuestoObrasNodo
LEFT OUTER JOIN Cuentas c1 ON #Auxiliar1.IdCuenta=c1.IdCuenta
LEFT OUTER JOIN Cuentas c2 ON PresupuestoObrasNodos.IdCuenta=c2.IdCuenta
WHERE (DetRec.IdRecepcion = @IdRecepcion)
ORDER by Pedidos.NumeroPedido,DetPed.NumeroItem

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2