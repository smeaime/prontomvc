CREATE Procedure [dbo].[CtasCtesD_TXParaImputar]

@IdCliente int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdCtaCte INTEGER,
			 IdTipoComp INTEGER,
			 Coeficiente INTEGER,
			 IdImputacion INTEGER,
			 Saldo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdImputacion, IdCtaCte) ON [PRIMARY]
CREATE TABLE #Auxiliar2 
			(
			 IdImputacion INTEGER,
			 Saldo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdImputacion) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCtaCte, CtaCte.IdTipoComp, IsNull(TiposComprobante.Coeficiente,1), Case When IsNull(CtaCte.IdImputacion,0)=0 Then Null Else CtaCte.IdImputacion End, CtaCte.Saldo
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE CtaCte.IdCliente=@IdCliente

/*  CURSOR  */
DECLARE @IdTrs int, @IdCtaCte int, @IdTipoComp int, @Coeficiente int, @IdImputacion int, @Saldo numeric(18,2), @Saldo1 numeric(18,2)
SET @IdTrs=0
SET @Saldo1=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCtaCte, IdTipoComp, Coeficiente, IdImputacion, Saldo FROM #Auxiliar1 ORDER BY IdImputacion, IdCtaCte
OPEN Cur
FETCH NEXT FROM Cur INTO @IdCtaCte, @IdTipoComp, @Coeficiente, @IdImputacion, @Saldo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @IdTrs<>IsNull(@IdImputacion,-1)
	    BEGIN
		IF @IdTrs<>0
			INSERT INTO #Auxiliar2
			(IdImputacion, Saldo)
			VALUES
			(@IdTrs, @Saldo1)
		SET @Saldo1=0
		SET @IdTrs=IsNull(@IdImputacion,-1)
	    END
	SET @Saldo1=@Saldo1+(@Saldo*@Coeficiente)
	FETCH NEXT FROM Cur INTO @IdCtaCte, @IdTipoComp, @Coeficiente, @IdImputacion, @Saldo
   END
IF @IdTrs<>0
    BEGIN
	INSERT INTO #Auxiliar2
	(IdImputacion, Saldo)
	VALUES
	(@IdTrs, @Saldo1)
    END
CLOSE Cur
DEALLOCATE Cur

DELETE #Auxiliar1
WHERE IsNull((Select Top 1 #Auxiliar2.Saldo From #Auxiliar2 Where #Auxiliar2.IdImputacion=IsNull(#Auxiliar1.IdImputacion,-1)),0)=0
DELETE #Auxiliar2
WHERE IsNull(Saldo,0)=0

SET NOCOUNT OFF

DECLARE @vector_X varchar(30), @vector_T varchar(30)
SET @vector_X='00001111111151133'
SET @vector_T='00000E445550A9200'

SELECT 
 #Auxiliar1.IdCtaCte as [IdCtaCte],
 #Auxiliar1.IdImputacion as [IdImputacion],
 CtaCte.IdTipoComp as [IdTipoComp],
 CtaCte.IdComprobante as [IdComprobante],
 TiposComprobante.DescripcionAB as [Comp.],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.NumeroFactura is not null
	 Then Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and Devoluciones.NumeroDevolucion is not null
	 Then Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and NotasDebito.NumeroNotaDebito is not null
	 Then NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and NotasCredito.NumeroNotaCredito is not null
	 Then NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo and Recibos.NumeroRecibo is not null
	 Then Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	Else Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
 End as [Numero],
 CtaCte.Fecha as [Fecha],
 CtaCte.FechaVencimiento as [Fecha vto.],
-- Case When CtaCte.IdTipoComp=1 Then Facturas.NumeroPedido Else Null End as [Pedido],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End as [Imp.orig.],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo Else CtaCte.Saldo*-1 End as [Saldo Comp.],
 CtaCte.SaldoTrs as [SaldoTrs],
 CtaCte.Marca as [*],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta Then Substring(Convert(varchar(1000),Facturas.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones Then Substring(Convert(varchar(1000),Devoluciones.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito Then Substring(Convert(varchar(1000),NotasDebito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito Then Substring(Convert(varchar(1000),NotasCredito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo Then Substring(Convert(varchar(1000),Recibos.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	Else Null
 End as [Observaciones],
 Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End as [Cabeza],
 cc.Descripcion as [Condicion venta],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN CuentasCorrientesDeudores CtaCte ON CtaCte.IdCtaCte=#Auxiliar1.IdCtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra=Facturas.IdCondicionVenta
WHERE (CtaCte.IdCliente=@IdCliente)

UNION ALL

SELECT 
 0 as [IdCtaCte],
 #Auxiliar2.IdImputacion as [IdImputacion],
 Null as [IdTipoComp],
 Null as [IdComprobante],
 Null as [Comp.],
 Null as [Numero],
 Null as [Fecha],
 Null as [Fecha vto.],
-- Null as [Pedido],
 Null as [Imp.orig.],
 Null as [Saldo Comp.],
 #Auxiliar2.Saldo as [SaldoTrs],
 Null as [*],
 Null as [Observaciones],
 '9' as [Cabeza],
 Null as [Condicion venta],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

ORDER by [IdImputacion], [Cabeza], [Fecha], [Numero]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2