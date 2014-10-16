exec CtasCtesA_TXPorTrs   200,-1,null,null,null,'N' 


alter Procedure [dbo].[CtasCtesA_TXPorTrs]  
  
@IdProveedor int= Null,   
@Todo int = Null,   
@FechaLimite datetime = Null,    
@FechaDesde datetime = Null,  
@Consolidar int = Null,   
@Pendiente varchar(1) = Null  
  
AS   
  
SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))  
SET @Consolidar=IsNull(@Consolidar,-1)  
SET @Pendiente=IsNull(@Pendiente,'N')  
  
DECLARE @IdTipoComprobanteOrdenPago int, @SaldoInicial numeric(18,2), @MostrarPedidos varchar(2)  
  
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)  
SET @MostrarPedidos=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni   
    Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave  
    Where pic.Clave='Mostrar pedidos en resumen de cuenta corriente acreedores' and IsNull(ProntoIni.Valor,'')='SI'),'')  
  
SET NOCOUNT ON  
  
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
 SELECT CtaCte.IdCtaCte, CtaCte.IdTipoComp, IsNull(TiposComprobante.Coeficiente,1), CtaCte.IdImputacion, CtaCte.Saldo  
 FROM CuentasCorrientesAcreedores CtaCte  
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp  
 WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite)  
  
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
 SET @Saldo1=@Saldo1+(@Saldo*@Coeficiente*-1)  
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
  
IF @Pendiente='S'  
    BEGIN  
 DELETE #Auxiliar1  
 WHERE IsNull((Select Top 1 #Auxiliar2.Saldo From #Auxiliar2 Where #Auxiliar2.IdImputacion=IsNull(#Auxiliar1.IdImputacion,-1)),0)=0  
 DELETE #Auxiliar2  
 WHERE IsNull(Saldo,0)=0  
    END  
  
CREATE TABLE #Auxiliar10   
   (  
    IdComprobanteProveedor INTEGER,  
    Pedidos VARCHAR(1000)  
   )  
  
CREATE TABLE #Auxiliar11   
   (  
    IdComprobanteProveedor INTEGER,  
    Pedido VARCHAR(20)  
   )  
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (IdComprobanteProveedor,Pedido) ON [PRIMARY]  
  
CREATE TABLE #Auxiliar12   
   (  
    IdComprobanteProveedor INTEGER,  
    Pedido VARCHAR(20)  
   )  
IF @MostrarPedidos='SI'  
    BEGIN  
 INSERT INTO #Auxiliar12   
  SELECT Det.IdComprobanteProveedor,   
  Case When IsNull(Pedidos.PuntoVenta,0)<>0   
   Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+  
    Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   End  
  FROM DetalleComprobantesProveedores Det  
  LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Det.IdComprobanteProveedor  
  LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion = Det.IdDetalleRecepcion  
  LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = IsNull(Det.IdDetallePedido,DetalleRecepciones.IdDetallePedido)  
  LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido  
  WHERE cp.IdProveedor=@IdProveedor and IsNull(Pedidos.Cumplido,'')<>'AN'  
   
 INSERT INTO #Auxiliar12   
  SELECT Det.IdComprobanteProveedor,   
  Case When IsNull(Pedidos.PuntoVenta,0)<>0   
   Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+  
    Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   End  
  FROM DetalleComprobantesProveedores Det  
  LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Det.IdComprobanteProveedor  
  LEFT OUTER JOIN DetalleSubcontratosDatos ON DetalleSubcontratosDatos.IdDetalleSubcontratoDatos = Det.IdDetalleSubcontratoDatos  
  LEFT OUTER JOIN DetalleSubcontratosDatosPedidos ON DetalleSubcontratosDatosPedidos.IdSubcontratoDatos = DetalleSubcontratosDatos.IdSubcontratoDatos  
  LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetalleSubcontratosDatosPedidos.IdPedido  
  WHERE cp.IdProveedor=@IdProveedor and Det.IdDetalleSubcontratoDatos is not null and IsNull(Pedidos.Cumplido,'')<>'AN'  
  
 INSERT INTO #Auxiliar12   
  SELECT Det.IdComprobanteProveedor,   
  Case When IsNull(Pedidos.PuntoVenta,0)<>0   
   Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+  
    Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+  
    IsNull('/'+Convert(varchar,Pedidos.SubNumero),'')  
   End  
  FROM DetalleComprobantesProveedores Det  
  LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Det.IdComprobanteProveedor  
  LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = Det.IdPedido  
  WHERE cp.IdProveedor=@IdProveedor and Det.IdPedido is not null and IsNull(Pedidos.Cumplido,'')<>'AN'  
  
 INSERT INTO #Auxiliar11  
  SELECT DISTINCT IdComprobanteProveedor, Pedido  
  FROM #Auxiliar12  
  
 INSERT INTO #Auxiliar10   
  SELECT IdComprobanteProveedor, ''  
  FROM #Auxiliar11  
  GROUP BY IdComprobanteProveedor  
   
 /*  CURSOR  */  
 DECLARE @IdComprobanteProveedor int, @Pedido varchar(20), @Corte int, @P varchar(1000)  
 SET @Corte=0  
 SET @P=''  
 DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdComprobanteProveedor, Pedido FROM #Auxiliar11 ORDER BY IdComprobanteProveedor  
 OPEN Cur  
 FETCH NEXT FROM Cur INTO @IdComprobanteProveedor, @Pedido  
 WHILE @@FETCH_STATUS = 0  
    BEGIN  
  IF @Corte<>@IdComprobanteProveedor  
     BEGIN  
   IF @Corte<>0  
    UPDATE #Auxiliar10  
    SET Pedidos = SUBSTRING(@P,1,1000)  
    WHERE IdComprobanteProveedor=@Corte  
   SET @P=''  
   SET @Corte=@IdComprobanteProveedor  
     END  
  IF NOT @Pedido IS NULL  
   IF PATINDEX('%'+@Pedido+' '+'%', @P)=0  
    SET @P=@P+@Pedido+' '  
  FETCH NEXT FROM Cur INTO @IdComprobanteProveedor, @Pedido  
    END  
    IF @Corte<>0  
  UPDATE #Auxiliar10  
  SET Pedidos = SUBSTRING(@P,1,1000)  
  WHERE IdComprobanteProveedor=@Corte  
 CLOSE Cur  
 DEALLOCATE Cur  
    END  
  
SET NOCOUNT OFF  
  
DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)  
SET @vector_X='001111111881111115111133'  
IF @MostrarPedidos='SI'  
 SET @vector_T='00099714455449993A99B900'  
ELSE  
 SET @vector_T='00099714455449993E999900'  
SET @vector_E='  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  '  
  
SELECT   
 #Auxiliar1.IdCtaCte as [IdCtaCte],  
 #Auxiliar1.IdImputacion as [IdImputacion],  
 TiposComprobante.DescripcionAB as [Comp.],  
 CtaCte.IdTipoComp as [IdTipoComp],  
 CtaCte.IdComprobante as [IdComprobante],  
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16 or   
  cp.IdComprobanteProveedor is null  
 Then Substring(Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),1,15)  
 Else Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+  
  Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,15)  
 End as [Numero],  
 CtaCte.NumeroComprobante as [Ref.],  
 CtaCte.Fecha as [Fecha],  
 CtaCte.FechaVencimiento as [Fecha vto.],  
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal*-1  
 Else CtaCte.ImporteTotal  
 End as [Imp.orig.],  
 Case When @Todo=-1  
 Then Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo*-1 Else CtaCte.Saldo End   
 Else Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal*-1 Else CtaCte.ImporteTotal End   
 End as [Saldo Comp.],  
 CtaCte.SaldoTrs as [SaldoTrs],  
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16 Then Null Else cp.FechaComprobante End as [Fecha cmp.],  
 CtaCte.IdImputacion as [IdImpu],  
 Convert(Numeric(18,2),CtaCte.Saldo)*TiposComprobante.Coeficiente*-1 as [Saldo],  
 Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End as [Cabeza],  
 Monedas.Abreviatura as [Mon.origen],  
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago   
 Then IsNull(Convert(varchar(1000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),'')  
 Else IsNull(Convert(varchar(1000),cp.Observaciones),'')  
 End as [Observaciones],  
 CtaCte.IdProveedor as [IdProveedor],  
 CtaCte.IdCtaCte as [IdAux1],  
 #Auxiliar10.Pedidos as [Pedidos],  
 @Vector_E as Vector_E,  
 @Vector_T as Vector_T,  
 @Vector_X as Vector_X  
FROM #Auxiliar1  
LEFT OUTER JOIN CuentasCorrientesAcreedores CtaCte ON CtaCte.IdCtaCte=#Auxiliar1.IdCtaCte  
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor  
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp  
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and CtaCte.IdTipoComp<>@IdTipoComprobanteOrdenPago and CtaCte.IdTipoComp<>16  
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=CtaCte.IdComprobante and (CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16)  
LEFT OUTER JOIN Monedas ON CtaCte.IdMoneda=Monedas.IdMoneda  
LEFT OUTER JOIN #Auxiliar10 ON cp.IdComprobanteProveedor=#Auxiliar10.IdComprobanteProveedor  
  
UNION ALL  
  
SELECT   
 0 as [IdCtaCte],  
 #Auxiliar2.IdImputacion as [IdImputacion],  
 Null as [Comp.],  
 Null as [IdTipoComp],  
 Null as [IdComprobante],  
 Null as [Numero],  
 Null as [Ref.],  
 Null as [Fecha],  
 Null as [Fecha vto.],  
 Null as [Imp.orig.],  
 Null as [Saldo Comp.],  
 #Auxiliar2.Saldo as [SaldoTrs],  
 Null as [Fecha cmp.],  
 Null as [IdImpu],  
 Null as [Saldo],  
 '9' as [Cabeza],  
 Null as [Mon.origen],  
 Null as [Observaciones],  
 Null as [IdProveedor],  
 0 as [IdAux1],  
 Null as [Pedidos],  
 @Vector_E as Vector_E,  
 @Vector_T as Vector_T,  
 @Vector_X as Vector_X  
FROM #Auxiliar2  
  
ORDER by [IdImputacion], [Cabeza], [Fecha], [Numero]  
  
DROP TABLE #Auxiliar1  
DROP TABLE #Auxiliar2  
DROP TABLE #Auxiliar10  
DROP TABLE #Auxiliar11  
DROP TABLE #Auxiliar12  