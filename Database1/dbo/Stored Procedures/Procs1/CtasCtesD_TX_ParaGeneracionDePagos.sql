CREATE Procedure [dbo].[CtasCtesD_TX_ParaGeneracionDePagos]

@Cobrador int = Null

AS 

SET NOCOUNT ON

SET @Cobrador=IsNull(@Cobrador,-1)

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdClienteAProcesar int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdClienteAProcesar=-1

UPDATE CuentasCorrientesDeudores
SET IdImputacion=0
WHERE IdImputacion is null

CREATE TABLE #Auxiliar1 
			(
			 A_IdCtaCte INTEGER,
			 A_IdCliente INTEGER,
			 A_IdImputacion INTEGER,
			 A_Importe NUMERIC(18, 2),
			 A_Saldo NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdCtaCte) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (A_IdCliente,A_IdImputacion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCtaCte, CtaCte.IdCliente, IsNull(CtaCte.IdImputacion,0), CtaCte.ImporteTotal * tc.Coeficiente, CtaCte.Saldo * tc.Coeficiente
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante tc ON CtaCte.IdTipoComp=tc.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 WHERE (@Cobrador=-1 or IsNull(Facturas.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,0)))=@Cobrador) and (@IdClienteAProcesar=-1 or CtaCte.IdCliente=@IdClienteAProcesar)

CREATE TABLE #Auxiliar2 
			(
			 A_IdCliente INTEGER,
			 A_IdImputacion INTEGER,
			 A_Importe NUMERIC(18, 2),
			 A_Saldo NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdCliente,A_IdImputacion) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.A_IdCliente, #Auxiliar1.A_IdImputacion, Sum(#Auxiliar1.A_Importe), Sum(#Auxiliar1.A_Saldo)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.A_IdCliente, #Auxiliar1.A_IdImputacion

DECLARE @IdCtaCte int, @IdImputacion int, @IdCliente int, @Importe numeric(18,2), @CotizacionDolar numeric(18,4), @CotizacionEuro numeric(18,4)

DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCliente, A_IdImputacion, A_Importe FROM #Auxiliar2 WHERE A_Importe=0 ORDER BY A_IdCliente, A_IdImputacion
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCliente, @IdImputacion, @Importe
WHILE @@FETCH_STATUS = 0
    BEGIN
	UPDATE CuentasCorrientesDeudores
	SET Saldo=0, SaldoDolar=0
	WHERE IdCliente=@IdCliente and IdImputacion=@IdImputacion
	FETCH NEXT FROM CtaCte1	INTO @IdCliente, @IdImputacion, @Importe
    END
CLOSE CtaCte1
DEALLOCATE CtaCte1

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

SET NOCOUNT OFF

DECLARE @vector_X varchar(30), @vector_T varchar(30)
SET @vector_X='01111111111533'
SET @vector_T='0G991H0F455500'

SELECT 
 CtaCte.IdCtaCte,
 Vendedores.Nombre as [Cobrador],
 CtaCte.IdCtaCte as [IdAux1],
 CtaCte.IdCliente as [IdAux2],
 Clientes.Codigo as [Cod.Cli.],
 Clientes.RazonSocial as [Cliente],
 TiposComprobante.DescripcionAB as [Comp.],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Facturas.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Devoluciones.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasDebito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasCredito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
	 Then TiposComprobante.DescripcionAb+' '+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	 Else TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
 End as [Numero],
 CtaCte.Fecha as [Fecha],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End as [Imp.orig.],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo Else CtaCte.Saldo*-1 End as [Saldo],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta 
	 Then Substring(Convert(varchar(1000),Facturas.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones 
	 Then Substring(Convert(varchar(1000),Devoluciones.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito 
	 Then Substring(Convert(varchar(1000),NotasDebito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito 
	 Then Substring(Convert(varchar(1000),NotasCredito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo 
	 Then Substring(Convert(varchar(1000),Recibos.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	 Else Null
 End as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,0)))
WHERE (@Cobrador=-1 or IsNull(Facturas.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,0)))=@Cobrador) and CtaCte.Saldo<>0
ORDER BY Vendedores.Nombre, Clientes.RazonSocial, CtaCte.Fecha, CtaCte.NumeroComprobante