
CREATE Procedure [dbo].[Bancos_TX_InformeChequesDiferidos]

@Fecha datetime,
@IdBanco int

AS

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2)
SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos  
						From Parametros	Where IdParametro=1),'NO')

CREATE TABLE #Auxiliar 
			(
			 IdValor INTEGER, 
			 Dias INTEGER, 
			 Importe NUMERIC(18,2),
			 Importe0 NUMERIC(18,2),
			 Importe1 NUMERIC(18,2),
			 Importe2 NUMERIC(18,2),
			 Importe3 NUMERIC(18,2),
			 Importe4 NUMERIC(18,2),
			 Importe5 NUMERIC(18,2),
			 Importe6 NUMERIC(18,2),
			 Importe7 NUMERIC(18,2),
			 Importe8 NUMERIC(18,2),
			 Importe9 NUMERIC(18,2),
			 Importe10 NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
 SELECT  Valores.IdValor, DATEDIFF(day,@Fecha,Valores.FechaValor), Valores.Importe*Valores.CotizacionMoneda, 
	 Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null
 FROM Valores 
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and 
	@ActivarCircuitoChequesDiferidos='SI' and 
	Valores.IdTipoValor=6 and 
	Valores.IdTipoComprobante=17 and 
	IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
	IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO' and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco)

UPDATE #Auxiliar
SET 
	Importe0=Case When Dias<0 Then Importe Else Null End,
	Importe1=Case When Dias>=0 and Dias<7 Then Importe Else Null End,
	Importe2=Case When Dias>=7 and Dias<7*2 Then Importe Else Null End,
	Importe3=Case When Dias>=7*2 and Dias<7*3 Then Importe Else Null End,
	Importe4=Case When Dias>=7*3 and Dias<7*4 Then Importe Else Null End,
	Importe5=Case When Dias>=7*4 and Dias<7*5 Then Importe Else Null End,
	Importe6=Case When Dias>=7*5 and Dias<7*6 Then Importe Else Null End,
	Importe7=Case When Dias>=7*6 and Dias<7*7 Then Importe Else Null End,
	Importe8=Case When Dias>=7*7 and Dias<7*8 Then Importe Else Null End,
	Importe9=Case When Dias>=7*8 and Dias<7*9 Then Importe Else Null End,
	Importe10=Case When Dias>=7*9 Then Importe Else Null End

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111111111111111111111133'
SET @vector_T='000022342E422201111111111100'

SELECT
 #Auxiliar.IdValor,
 Bancos.Nombre as [Aux1],
 Valores.IdBanco as [Aux2],
 1 as [Aux3],
 Bancos.Nombre as [Banco],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero valor],
 Valores.FechaValor as [Fecha valor],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 Valores.FechaComprobante as [Fec.Comp.],
 tc1.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 Proveedores.RazonSocial as [Proveedor],
 #Auxiliar.Dias as [Dias],
 #Auxiliar.Importe0 as [Ant.],
 #Auxiliar.Importe1 as [Sem.1],
 #Auxiliar.Importe2 as [Sem.2],
 #Auxiliar.Importe3 as [Sem.3],
 #Auxiliar.Importe4 as [Sem.4],
 #Auxiliar.Importe5 as [Sem.5],
 #Auxiliar.Importe6 as [Sem.6],
 #Auxiliar.Importe7 as [Sem.7],
 #Auxiliar.Importe8 as [Sem.8],
 #Auxiliar.Importe9 as [Sem.9],
 #Auxiliar.Importe10 as [Post.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante tc1 ON Valores.IdTipoComprobante=tc1.IdTipoComprobante
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera

UNION ALL

SELECT
 0,
 Bancos.Nombre as [Aux1],
 Valores.IdBanco as [Aux2],
 2 as [Aux3],
 'TOTAL BANCO' as [Banco],
 Null as [Nro.Int.],
 Null as [Numero valor],
 Null as [Fecha valor],
 SUM(Valores.Importe) as [Importe],
 Null as [Mon.],
 Null as [Fec.Comp.],
 Null as [Tipo Comp.],
 Null as [Comp.],
 Null as [Proveedor],
 Null as [Dias],
 SUM(#Auxiliar.Importe0) as [Ant.],
 SUM(#Auxiliar.Importe1) as [Sem.1],
 SUM(#Auxiliar.Importe2) as [Sem.2],
 SUM(#Auxiliar.Importe3) as [Sem.3],
 SUM(#Auxiliar.Importe4) as [Sem.4],
 SUM(#Auxiliar.Importe5) as [Sem.5],
 SUM(#Auxiliar.Importe6) as [Sem.6],
 SUM(#Auxiliar.Importe7) as [Sem.7],
 SUM(#Auxiliar.Importe8) as [Sem.8],
 SUM(#Auxiliar.Importe9) as [Sem.9],
 SUM(#Auxiliar.Importe10) as [Post.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
GROUP BY Bancos.Nombre, Valores.IdBanco

UNION ALL

SELECT
 0,
 Bancos.Nombre as [Aux1],
 Valores.IdBanco as [Aux2],
 3 as [Aux3],
 Null as [Banco],
 Null as [Nro.Int.],
 Null as [Numero valor],
 Null as [Fecha valor],
 Null as [Importe],
 Null as [Mon.],
 Null as [Fec.Comp.],
 Null as [Tipo Comp.],
 Null as [Comp.],
 Null as [Proveedor],
 Null as [Dias],
 Null as [Ant.],
 Null as [Sem.1],
 Null as [Sem.2],
 Null as [Sem.3],
 Null as [Sem.4],
 Null as [Sem.5],
 Null as [Sem.6],
 Null as [Sem.7],
 Null as [Sem.8],
 Null as [Sem.9],
 Null as [Post.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
GROUP BY Bancos.Nombre, Valores.IdBanco

ORDER BY [Aux1], [Aux3], [Fecha valor], [Comp.]

DROP TABLE #Auxiliar
