CREATE  Procedure [dbo].[Recibos_TX_SinAsignacionAPresentaciones]

@IdReciboAModificar int = Null

AS 

SET @IdReciboAModificar=IsNull(@IdReciboAModificar,-1)

DECLARE @vector_X varchar(30), @vector_T varchar(30), @EntidadesCobroPresentaciones varchar(1000)
SET @vector_X='011111133'
SET @vector_T='0194D1100'

SET @EntidadesCobroPresentaciones=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Entidades para operaciones con tarjetas de credito'),'')
SELECT 
 Recibos.IdRecibo as [IdRecibo], 
 Recibos.NumeroRecibo as [Recibo], 
 Recibos.IdRecibo as [IdAux], 
 Recibos.FechaRecibo as [Fecha], 
 Clientes.RazonSocial AS [Cliente],
 Recibos.Deudores AS [Deudores],
 Recibos.Valores AS [Valores],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos 
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
WHERE Recibos.Tipo='CC' and IsNull(Recibos.Anulado,'')<>'SI' and Patindex('%('+IsNull(Clientes.Codigo,'S/D')+')%', @EntidadesCobroPresentaciones)>0 and
	(@IdReciboAModificar<=0 and not Exists(Select Top 1 Valores.IdValor From Valores Where Valores.IdReciboAsignado=Recibos.IdRecibo) or @IdReciboAModificar=Recibos.IdRecibo)
ORDER BY Recibos.FechaRecibo,Recibos.NumeroRecibo