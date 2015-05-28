CREATE Procedure [dbo].[CtasCtesD_TX_SaldosAFechaDetallado]

@FechaDesde datetime,
@FechaHasta datetime,
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@Vendedor int,
@Cobrador int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int, @Saldo Numeric(18,2)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @Saldo=0

CREATE TABLE #Auxiliar1
			(
			 IdCliente INTEGER,
			 SaldoPesos NUMERIC(18, 2),
			 SaldoDolares NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCliente,
  Sum(Case When CtaCte.Fecha<@FechaDesde Then IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente Else 0 End),
  Sum(Case When CtaCte.Fecha<@FechaDesde Then IsNull(CtaCte.ImporteTotalDolar,0)*TiposComprobante.Coeficiente Else 0 End)
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE CtaCte.Fecha<@FechaHasta and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=IsNull(Fac.IdVendedor,IsNull(Dev.IdVendedor,IsNull(Deb.IdVendedor,IsNull(Cre.IdVendedor,IsNull(Rec.IdVendedor,IsNull(Clientes.Vendedor1,0))))))) and 
	(@Cobrador=-1 or @Cobrador=IsNull(Rec.IdCobrador,IsNull(Clientes.Cobrador,0)))  
 GROUP BY CtaCte.IdCliente

CREATE TABLE #Auxiliar2
			(
			 IdCliente INTEGER,
			 SaldoPesos NUMERIC(18, 2),
			 SaldoDolares NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCliente,
  Sum(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente),
  Sum(IsNull(CtaCte.ImporteTotalDolar,0)*TiposComprobante.Coeficiente)
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=IsNull(Fac.IdVendedor,IsNull(Dev.IdVendedor,IsNull(Deb.IdVendedor,IsNull(Cre.IdVendedor,IsNull(Rec.IdVendedor,IsNull(Clientes.Vendedor1,0))))))) and 
	(@Cobrador=-1 or @Cobrador=IsNull(Rec.IdCobrador,IsNull(Clientes.Cobrador,0)))  
 GROUP BY CtaCte.IdCliente

SET NOCOUNT OFF


DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111661111133'
SET @vector_T='0000223440500500'

SELECT  
 IsNull(#Auxiliar1.IdCliente,0) as [K_Id],
 Clientes.Codigo as [K_Codigo],
 Clientes.RazonSocial as [K_Cliente],
 0 as [K_Orden],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 'SALDO INICIAL AL '+Convert(varchar,@FechaDesde,103) as [Comprobante],
 Null as [Importe],
 #Auxiliar1.SaldoPesos as [Saldo],
 Clientes.Direccion + ' ' + IsNull(Localidades.Nombre+' ','') + IsNull('('+Clientes.CodigoPostal+') ','') + 
	Case When IsNull(UPPER(Provincias.Nombre),'')<>'CAPITAL FEDERAL' Then IsNull(Provincias.Nombre+' ','') Else '' End as [Direccion],
 Clientes.Telefono as [Telefono],
 (Select Vendedores.Nombre From Vendedores 
  Where Clientes.Cobrador=Vendedores.IdVendedor) as [Cobrador], 
 (Select Vendedores.Nombre From Vendedores 
  Where Clientes.Vendedor1=Vendedores.IdVendedor) as [Vendedor], 
 Clientes.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar1.IdCliente
LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad=Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON Clientes.IdProvincia=Provincias.IdProvincia

UNION ALL

SELECT  
 IsNull(CtaCte.IdCliente,0) as [K_Id],
 Clientes.Codigo as [K_Codigo],
 Clientes.RazonSocial as [K_Cliente],
 1 as [K_Orden],
 Null as [Codigo],
 Null as [Cliente],
 '    '+
 Substring(
	 Case 	When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and IsNull(CtaCte.IdComprobante,0)>0
		 Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+Fac.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)+ ' '+
			'[ Vto.'+Convert(varchar,DateAdd(day,IsNull(Tmp.Dias,0),IsNull(Fac.FechaFactura,CtaCte.Fecha)),103)+' '+
				Convert(varchar,IsNull(Tmp.Porcentaje,0))+'% ]'
		When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and IsNull(CtaCte.IdComprobante,0)>0
		 Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+Dev.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)
		When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and IsNull(CtaCte.IdComprobante,0)>0
		 Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+Deb.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)
		When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and IsNull(CtaCte.IdComprobante,0)>0
		 Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+Cre.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)
		When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo and IsNull(CtaCte.IdComprobante,0)>0
		 Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+
			Substring('0000',1,4-Len(Convert(varchar,Rec.PuntoVenta)))+Convert(varchar,Rec.PuntoVenta)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Rec.NumeroRecibo)))+Convert(varchar,Rec.NumeroRecibo)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)
		 Else '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+Convert(varchar,Day(CtaCte.Fecha))+') '+
			IsNull(TiposComprobante.DescripcionAb,'')+' '+
			Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)
	 End,1,70) as [Comprobante],
 CtaCte.ImporteTotal * TiposComprobante.Coeficiente * IsNull(Tmp.Porcentaje,100)/100 as [Importe],
 @Saldo as [Saldo],
 Null as [Direccion],
 Null as [Telefono],
 IsNull(V2.Nombre,V4.Nombre) as [Cobrador], 
 IsNull(V1.Nombre,V3.Nombre) as [Vendedor], 
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN _TempCondicionesCompra Tmp ON CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and Fac.IdCondicionVenta=Tmp.IdCondicionCompra
LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor=IsNull(Fac.IdVendedor,IsNull(Dev.IdVendedor,IsNull(Deb.IdVendedor,IsNull(Cre.IdVendedor,IsNull(Rec.IdVendedor,0)))))
LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor=Rec.IdCobrador
LEFT OUTER JOIN Vendedores V3 ON V3.IdVendedor=Clientes.Vendedor1
LEFT OUTER JOIN Vendedores V4 ON V4.IdVendedor=Clientes.Cobrador
WHERE CtaCte.Fecha>=@FechaDesde and CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=IsNull(Fac.IdVendedor,IsNull(Dev.IdVendedor,IsNull(Deb.IdVendedor,IsNull(Cre.IdVendedor,IsNull(Rec.IdVendedor,IsNull(Clientes.Vendedor1,0))))))) and 
	(@Cobrador=-1 or @Cobrador=IsNull(Rec.IdCobrador,IsNull(Clientes.Cobrador,0))) 

UNION ALL

SELECT  
 IsNull(#Auxiliar2.IdCliente,0) as [K_Id],
 Clientes.Codigo as [K_Codigo],
 Clientes.RazonSocial as [K_Cliente],
 2 as [K_Orden],
 Null as [Codigo],
 Null as [Cliente],
 'SALDO FINAL AL '+Convert(varchar,@FechaHasta,103) as [Comprobante],
 Null as [Importe],
 #Auxiliar2.SaldoPesos as [Saldo],
 Null as [Direccion],
 Null as [Telefono],
 Null as [Cobrador], 
 Null as [Vendedor], 
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar2
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar2.IdCliente

UNION ALL

SELECT  
 0 as [K_Id],
 Null as [K_Codigo],
 'zzzzz' as [K_Cliente],
 3 as [K_Orden],
 Null as [Codigo],
 Null as [Cliente],
 'TOTAL GENERAL AL '+Convert(varchar,@FechaHasta,103) as [Comprobante],
 Null as [Importe],
 Sum(IsNull(#Auxiliar2.SaldoPesos,0)) as [Saldo],
 Null as [Direccion],
 Null as [Telefono],
 Null as [Cobrador], 
 Null as [Vendedor], 
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar2

ORDER BY [K_Cliente], [K_Orden], [Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2