CREATE PROCEDURE [dbo].[CuboIngresoEgresosPorObra1]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int,
@IncluirAsientos int,
@Dts1 varchar(200),
@Dts2 varchar(200)

AS

SET NOCOUNT ON

DECLARE @IdRubroAnticipos int, @IdRubroDevolucionAnticipos int, @ModeloContableSinApertura varchar(2), @Modelo varchar(2), 
	@IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int

SET @IdRubroAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroAnticipos'),-1)
SET @IdRubroDevolucionAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroDevolucionAnticipos'),-1)
SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'NO')
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @Modelo=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Modelo informe cubo de ingresos y egresos por obra'),'01')

CREATE TABLE #Auxiliar0	
			(
			 Tipo VARCHAR(30),
			 UnidadOperativa VARCHAR(50),
			 Obra VARCHAR(100),
			 RubroContable VARCHAR(50),
			 Detalle VARCHAR(1000),
			 Importe NUMERIC(18,2),
			 Grupo VARCHAR(50),
			 Entidad VARCHAR(100),
			 IdObra INTEGER,
			 Cuenta VARCHAR(100)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,Facturas.FechaFactura,112)+'] '+Convert(varchar,Facturas.FechaFactura,103)+' '+'FAC '+Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,''),1,100),
  Case When Facturas.CotizacionMoneda is not null 
	Then 	Case When Facturas.TipoABC='B' 
			Then ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda
			Else ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda
		End
	Else 	Case When Facturas.TipoABC='B' 
			Then ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100))
			Else ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100)))
		End
  End,
  IsNull(GruposObras.Descripcion,'S/D'), 
  IsNull(Clientes.RazonSocial,''),
  Obras.IdObra,
  ''
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON dfoc.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Obras ON IsNull(OrdenesCompra.IdObra,Facturas.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 LEFT OUTER JOIN Articulos ON df.IdArticulo = Articulos.IdArticulo
 WHERE (Facturas.FechaFactura between @FechaDesde and @FechaHasta) and 
	IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
	(@IdObra=-1 or IsNull(OrdenesCompra.IdObra,0)=@IdObra or IsNull(Facturas.IdObra,0)=@IdObra) and 
	(@IdRubroAnticipos=-1 or not Articulos.IdRubro=@IdRubroAnticipos) and 
	(@IdRubroDevolucionAnticipos=-1 or not Articulos.IdRubro=@IdRubroDevolucionAnticipos)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,Facturas.FechaFactura,112)+'] '+Convert(varchar,Facturas.FechaFactura,103)+' '+'FAC '+Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,''),1,100),
  Case When Facturas.CotizacionMoneda is not null 
	Then 	Case When Facturas.TipoABC='B' 
			Then ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda
			Else ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda
		End
	Else	Case When Facturas.TipoABC='B' 
			Then ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100))
			Else ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100)))
		End
  End,
  IsNull(GruposObras.Descripcion,'S/D'), 
  IsNull(Clientes.RazonSocial,''),
  Obras.IdObra,
  ''
 FROM DetalleFacturas df
 LEFT OUTER JOIN Facturas ON df.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 LEFT OUTER JOIN Articulos ON df.IdArticulo = Articulos.IdArticulo
 WHERE (Facturas.FechaFactura between @FechaDesde and @FechaHasta) and 
	IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
	(@IdObra=-1 or Facturas.IdObra is not null) and 
	(@IdObra=-1 or IsNull(Facturas.IdObra,0)=@IdObra) and 
	not exists(Select Top 1 dfoc.IdDetalleFactura From DetalleFacturasOrdenesCompra dfoc Where dfoc.IdDetalleFactura=df.IdDetalleFactura) and 
	(@IdRubroAnticipos=-1 or not Articulos.IdRubro=@IdRubroAnticipos) and 
	(@IdRubroDevolucionAnticipos=-1 or not Articulos.IdRubro=@IdRubroDevolucionAnticipos)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',  
  Substring('['+Convert(varchar,Devoluciones.FechaDevolucion,112)+'] '+Convert(varchar,Devoluciones.FechaDevolucion,103)+' '+'DEV '+Devoluciones.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,''),1,100),
  Case When Devoluciones.CotizacionMoneda is not null
	Then 	Case When Devoluciones.TipoABC='B' 
			Then ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / (1+(Devoluciones.PorcentajeIva1/100)) * Devoluciones.CotizacionMoneda * -1
			Else ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * Devoluciones.CotizacionMoneda * -1
		End
	Else 	Case When Devoluciones.TipoABC='B' 
			Then ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / (1+(Devoluciones.PorcentajeIva1/100)) * -1
			Else ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * -1
		End
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  IsNull(Clientes.RazonSocial,''),
  Obras.IdObra,
  ''
 FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Obras ON dv.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 LEFT OUTER JOIN Articulos ON dv.IdArticulo = Articulos.IdArticulo
 WHERE (Devoluciones.FechaDevolucion between @FechaDesde and @FechaHasta) and 
	(Devoluciones.Anulada is null or Devoluciones.Anulada<>'SI') and 
	(@IdObra=-1 or IsNull(dv.IdObra,0)=@IdObra or IsNull(Devoluciones.IdObra,0)=@IdObra) and 
	(@IdRubroAnticipos=-1 or not Articulos.IdRubro=@IdRubroAnticipos) and 
	(@IdRubroDevolucionAnticipos=-1 or not Articulos.IdRubro=@IdRubroDevolucionAnticipos)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,NotasDebito.FechaNotaDebito,112)+'] '+Convert(varchar,NotasDebito.FechaNotaDebito,103)+' '+'DEB '+NotasDebito.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,''),1,100),
  Case When NotasDebito.TipoABC='B' 
	Then ((IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito and DetND.Gravado='SI'),0) / 
		  (1+(NotasDebito.PorcentajeIva1/100))) + IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito and DetND.Gravado<>'SI'),0)) * 
		IsNull(NotasDebito.CotizacionMoneda,1)
	Else IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito),0) * IsNull(NotasDebito.CotizacionMoneda,1)
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  IsNull(Clientes.RazonSocial,''),
  Obras.IdObra,
  ''
 FROM NotasDebito
 LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Obras ON NotasDebito.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (NotasDebito.FechaNotaDebito between @FechaDesde and @FechaHasta) and 
	IsNull(NotasDebito.Anulada,'NO')<>'SI' and IsNull(NotasDebito.CtaCte,'SI')='SI' and 
	IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI' and 
	(@IdObra=-1 or IsNull(NotasDebito.IdObra,0)=@IdObra)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,NotasCredito.FechaNotaCredito,112)+'] '+Convert(varchar,NotasCredito.FechaNotaCredito,103)+' '+'CRE '+NotasCredito.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,''),1,100),
  Case When NotasCredito.TipoABC='B' 
	Then ((IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito and DetNC.Gravado='SI'),0) / 
		  (1+(NotasCredito.PorcentajeIva1/100))) + IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito and DetNC.Gravado<>'SI'),0)) * 
		IsNull(NotasCredito.CotizacionMoneda,1) * -1
	Else IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito),0) * IsNull(NotasCredito.CotizacionMoneda,1) * -1
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  IsNull(Clientes.RazonSocial,''),
  Obras.IdObra,
  ''
 FROM NotasCredito
 LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Obras ON NotasCredito.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (NotasCredito.FechaNotaCredito between @FechaDesde and @FechaHasta) and 
	IsNull(NotasCredito.Anulada,'NO')<>'SI' and IsNull(NotasCredito.CtaCte,'SI')='SI' and 
	IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI' and 
	(@IdObra=-1 or IsNull(NotasCredito.IdObra,0)=@IdObra)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,Asientos.FechaAsiento,112)+'] '+Convert(varchar,Asientos.FechaAsiento,103)+' AS '+
	Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento)+' '+IsNull(Asientos.Concepto,''),1,100),
  Case 	When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
	When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
	When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
	Else 0
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  '',
  Obras.IdObra,
  ''
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN Obras ON IsNull(DetAsi.IdObra,Cuentas.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and 
/*
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
		 From CuentasGastos
		 Where CuentasGastos.IdCuentaMadre=DetAsi.IdCuenta))) and 
*/
	(@IdObra=-1 or IsNull(DetAsi.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra) and 
	@IncluirAsientos=-1 and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE'

INSERT INTO #Auxiliar0 
 SELECT 
  '2.EGRESOS ( Gastos )',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS Else Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS End,
  Substring('['+Convert(varchar,cp.FechaRecepcion,112)+'] '+Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' - '+'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
	End,1,100),
  Case When cp.Letra='A' or cp.Letra='M' 
	Then DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else (DetCP.Importe - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje1,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje2,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje3,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje4,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje5,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje6,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje7,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje8,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje9,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje10,0)/100))))) * 
		cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
  End,
  IsNull(GruposObras.Descripcion,'S/D'), 
  Case When cp.IdProveedor is not null
	Then IsNull(Proveedores.RazonSocial,'')
	Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
  End,
  Obras.IdObra,
  IsNull(Cuentas.Descripcion,'')
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN Obras ON IsNull(DetCP.IdObra,Cuentas.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and IsNull(cp.Confirmado,'')<>'NO' and cp.IdTipoComprobante<>31 and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=DetCP.IdCuenta))) and 
	(@IdObra=-1 or IsNull(DetCP.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra)

INSERT INTO #Auxiliar0 
 SELECT 
  '2.EGRESOS ( Gastos )',
  UnidadesOperativas.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  Substring('['+Convert(varchar,Subdiarios.FechaComprobante,112)+'] '+Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.Descripcion COLLATE Modern_Spanish_CI_AS +' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Subdiarios.NumeroComprobante)))+Convert(varchar,Subdiarios.NumeroComprobante)+
		Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then IsNull(' '+Convert(varchar,OrdenesPago.Observaciones),'') Else '' End,1,100),
  Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null Then Subdiarios.Debe * -1
	When Subdiarios.Debe is null and Subdiarios.Haber is not null Then Subdiarios.Haber
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null Then (Subdiarios.Debe - Subdiarios.Haber) * -1
	Else 0
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  '',
  Obras.IdObra,
  IsNull(Cuentas.Descripcion,'')
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
						IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
 LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
 LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(Cuentas.IdObra,IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0))))))))
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
 LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and cp.IdComprobanteProveedor is null and IsNull(cp.IdTipoComprobante,0)<>31 and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta))) and 
	(@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and Subdiarios.IdTipoComprobante<>50 and 
	IsNull(TiposComprobante.Agrupacion1,'')<>'VENTAS'

INSERT INTO #Auxiliar0 
 SELECT 
  '2.EGRESOS ( Gastos )',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  Substring('['+Convert(varchar,Asientos.FechaAsiento,112)+'] '+Convert(varchar,Asientos.FechaAsiento,103)+' AS '+
	Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento)+' '+IsNull(Asientos.Concepto,''),1,100),
  Case 	When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
	When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
	When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
	Else 0
  End,
  IsNull(GruposObras.Descripcion,'S/D'), 
  '',
  Obras.IdObra,
  IsNull(Cuentas.Descripcion,'')
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN Obras ON IsNull(DetAsi.IdObra,Cuentas.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=DetAsi.IdCuenta))) and 
	(@IdObra=-1 or IsNull(DetAsi.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra) and Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE'

INSERT INTO #Auxiliar0 
 SELECT 
  '3.EGRESOS ( Bienes/Servicios )',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS Else Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS End,
  Substring('['+Convert(varchar,cp.FechaRecepcion,112)+'] '+Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' - '+'Proveedor : '+
	Case When cp.IdProveedor is not null 
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
	End,1,100),
  Case When cp.Letra='A' or cp.Letra='M' 
	Then DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else (DetCP.Importe - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje1,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje2,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje3,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje4,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje5,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje6,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje7,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje8,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje9,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje10,0)/100))))) * 
		cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
  End,
  IsNull(GruposObras.Descripcion,'S/D'), 
  Case When cp.IdProveedor is not null 
	Then IsNull(Proveedores.RazonSocial,'')
	Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
  End,
  Obras.IdObra,
  IsNull(Cuentas.Descripcion,'')
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN Obras ON IsNull(DetCP.IdObra,Cuentas.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and IsNull(cp.Confirmado,'')<>'NO' and cp.IdTipoComprobante<>31 and 
	(DetCP.IdObra is not null and Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta)) and 
	(@IdObra=-1 or IsNull(DetCP.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra)


UPDATE #Auxiliar0
SET Obra=' NO IMPUTABLE'
WHERE Obra IS NULL

IF @Modelo='02'
  BEGIN
	DELETE #Auxiliar0
	WHERE Tipo='3.EGRESOS ( Bienes/Servicios )'

	CREATE TABLE #Auxiliar1 
				(
				 IdObra INTEGER,
				 ImporteIngresos NUMERIC(18,2),
				 ImporteEgresos NUMERIC(18,2),
				 Saldo NUMERIC(18,2),
				 ResultadoIngresos NUMERIC(18,2),
				 ResultadoEgresos NUMERIC(18,2)
				)
	INSERT INTO #Auxiliar1 
	 SELECT IdObra, Sum(Case When Tipo='1.INGRESOS' Then Importe Else 0 End), Sum(Case When Tipo='1.INGRESOS' Then 0 Else Importe End),0,0,0
	 FROM #Auxiliar0
	 GROUP BY IdObra
	
	UPDATE #Auxiliar1
	SET Saldo=IsNull(ImporteIngresos,0)+IsNull(ImporteEgresos,0)

	UPDATE #Auxiliar1
	SET ResultadoIngresos=Case When ImporteIngresos<>0 Then Saldo/ImporteIngresos*100 Else 0 End, 
		ResultadoEgresos=Case When ImporteEgresos<>0 Then Saldo/Abs(ImporteEgresos)*100 Else 0 End

	UPDATE #Auxiliar0
	SET Obra=IsNull(Obra,'')+
		' - % ingresos '+Convert(varchar,IsNull((Select Top 1 A.ResultadoIngresos From #Auxiliar1 A Where A.IdObra=#Auxiliar0.IdObra),0))+'%'+
		' - % egresos '+Convert(varchar,IsNull((Select Top 1 A.ResultadoEgresos From #Auxiliar1 A Where A.IdObra=#Auxiliar0.IdObra),0))+'%'
		
	DROP TABLE #Auxiliar1
  END

IF @Modelo='03'
  BEGIN
	TRUNCATE TABLE _TempCuboIngresoEgresosPorObra2
	INSERT INTO _TempCuboIngresoEgresosPorObra2 
	 SELECT Tipo, UnidadOperativa, Obra, RubroContable, Detalle, Importe, Grupo, Entidad, Cuenta
	 FROM #Auxiliar0
	 ORDER BY Tipo, UnidadOperativa, Obra, RubroContable, Cuenta, Detalle
  END
ELSE
  BEGIN
	TRUNCATE TABLE _TempCuboIngresoEgresosPorObra
	INSERT INTO _TempCuboIngresoEgresosPorObra 
	 SELECT Tipo, UnidadOperativa, Obra, RubroContable, Detalle, Importe, Grupo, Entidad
	 FROM #Auxiliar0
	 ORDER BY Tipo, UnidadOperativa, Obra, RubroContable, Detalle
  END

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts1
EXEC @Resultado=master..xp_cmdshell @Dts2

IF @Modelo='02'
  BEGIN
	UPDATE #Auxiliar0
	SET Obra=(Select Top 1 Obras.NumeroObra From Obras Where Obras.IdObra=#Auxiliar0.IdObra)

	TRUNCATE TABLE _TempCuboIngresoEgresosPorObra
	INSERT INTO _TempCuboIngresoEgresosPorObra 
	 SELECT Tipo, UnidadOperativa, Obra, RubroContable, Detalle, Importe, Grupo, Entidad
	 FROM #Auxiliar0
	 ORDER BY Tipo, UnidadOperativa, Obra, RubroContable, Detalle
  END

DROP TABLE #Auxiliar0

SET NOCOUNT OFF