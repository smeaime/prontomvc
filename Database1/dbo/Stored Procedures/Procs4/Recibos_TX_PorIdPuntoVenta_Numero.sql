CREATE Procedure [dbo].[Recibos_TX_PorIdPuntoVenta_Numero]

@IdPuntoVenta int,
@NumeroRecibo int

AS 

DECLARE @EntidadesCobroPresentaciones varchar(1000)

SET @EntidadesCobroPresentaciones=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Entidades para operaciones con tarjetas de credito'),'')

SELECT 
 Recibos.*,
 Case When Patindex('%('+IsNull(Clientes.Codigo,'S/D')+')%', @EntidadesCobroPresentaciones)>0 Then 'SI' Else 'NO' End as [ClienteParaCobroPresentaciones],
 Case When Exists(Select Top 1 Valores.IdValor From Valores Where Valores.IdReciboAsignado=Recibos.IdRecibo) Then 'SI' Else 'NO' End as [ReciboAsignado]
FROM Recibos
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
WHERE (@IdPuntoVenta<=0 or IdPuntoVenta=@IdPuntoVenta) and NumeroRecibo=@NumeroRecibo