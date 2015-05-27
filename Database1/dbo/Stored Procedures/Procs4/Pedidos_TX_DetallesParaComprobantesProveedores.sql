CREATE PROCEDURE [dbo].[Pedidos_TX_DetallesParaComprobantesProveedores]

@IdPedido int

AS

SET NOCOUNT ON

DECLARE @RegistroContableComprasAlActivo varchar(2)
SET @RegistroContableComprasAlActivo=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='RegistroContableComprasAlActivo'),'NO')

CREATE TABLE #Auxiliar1	
			(
			 IdDetallePedido INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Det.IdDetallePedido,
  Case 
	When @RegistroContableComprasAlActivo='SI' and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and IsNull(Rubros.IdCuentaComprasActivo,0)<>0
	 Then IsNull(Articulos.IdCuentaComprasActivo,Rubros.IdCuentaComprasActivo)
	 --Then IsNull((Select Top 1 c.IdCuenta From Cuentas c
		--	 Where c.IdObra=Requerimientos.IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and 
		--		Rubros.IdCuentaComprasActivo=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Rubros.IdCuentaComprasActivo)
	When Articulos.IdCuentaCompras is not null 
	 Then IsNull((Select Top 1 c.IdCuenta From Cuentas c
				  Where c.IdObra=Requerimientos.IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and 
						Articulos.IdCuentaCompras=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Articulos.IdCuentaCompras)
	 Else IsNull((Select Top 1 c.IdCuenta From Cuentas c
				  Where c.IdObra=Requerimientos.IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and 
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
 FROM DetallePedidos Det 
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE (Det.IdPedido = @IdPedido)

SET NOCOUNT OFF

SELECT
 Det.*,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Articulos.AlicuotaIVA,
 Articulos.IdCuentaCompras,
 Case When c1.IdTipoCuenta=2 Then #Auxiliar1.IdCuenta Else Null End as [IdCuentaContable],
 Case When c1.IdTipoCuenta=2 Then c1.Codigo Else Null End as [CodigoCuenta],
 Case When (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0))<>0 and IsNull(Pedidos.Bonificacion,0)<>0 
		Then Round(((Det.Cantidad*Det.Precio)-
					(Det.Cantidad*Det.Precio*IsNull(Det.PorcentajeBonificacion,0)/100)) - 
					(Pedidos.Bonificacion / (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) * 
					 ((Det.Cantidad*Det.Precio)-
					  (Det.Cantidad*Det.Precio*IsNull(Det.PorcentajeBonificacion,0)/100))),2)
		Else Round((Det.Cantidad*Det.Precio)-
					(Det.Cantidad*Det.Precio*IsNull(Det.PorcentajeBonificacion,0)/100),2)
 End as [Importe],
 Pedidos.NumeroPedido as [Pedido],
 Pedidos.IdCondicionCompra,
 (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) as [T.Pedido],
 Pedidos.Bonificacion,
 Requerimientos.NumeroRequerimiento as [RM],
 Requerimientos.IdObra,
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetalleRequerimientos.IdDetalleObraDestino as [IdDetalleObraDestino],
 DetalleRequerimientos.IdPresupuestoObraRubro as [IdPresupuestoObraRubro],
 DetalleRequerimientos.IdPresupuestoObrasNodo as [IdPresupuestoObrasNodo],
 PresupuestoObrasNodos.IdCuenta as [IdCuentaPresupuestoObrasNodos],
 Case When c2.IdTipoCuenta=2 Then c2.Codigo Else Null End as [CodigoCuentaPresupuestoObrasNodos],
 c1.IdRubroFinanciero as [IdRubroFinanciero],
 c2.IdRubroFinanciero as [IdRubroFinancieroPresupuestoObrasNodos],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 Obras.NumeroObra as [Obra]
FROM DetallePedidos Det 
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar1 ON Det.IdDetallePedido = #Auxiliar1.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = DetalleRequerimientos.IdPresupuestoObrasNodo
LEFT OUTER JOIN Cuentas c1 ON #Auxiliar1.IdCuenta=c1.IdCuenta
LEFT OUTER JOIN Cuentas c2 ON PresupuestoObrasNodos.IdCuenta=c2.IdCuenta
WHERE (Det.IdPedido = @IdPedido)
ORDER by Pedidos.NumeroPedido,Det.NumeroItem

DROP TABLE #Auxiliar1