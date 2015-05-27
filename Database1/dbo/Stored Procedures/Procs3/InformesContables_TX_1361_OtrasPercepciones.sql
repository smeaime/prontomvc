CREATE PROCEDURE [dbo].[InformesContables_TX_1361_OtrasPercepciones]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 CodigoJurisdiccionIIBB INTEGER,
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 JurisdiccionImpuestosMunicipales VARCHAR(40),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 Registro VARCHAR(100)
			)
INSERT INTO #Auxiliar 
 SELECT 
	Fac.FechaFactura,
	Case When Fac.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'01')
			When Fac.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'06')
			When Fac.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'11')
			When Fac.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'19')
	End,
	Fac.PuntoVenta,
	Fac.NumeroFactura,
	Case When IBCondiciones.CodigoAFIP is not null Then IBCondiciones.CodigoAFIP Else 0 End,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda * 100,
	'',
	0,
	''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Fac.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE (Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta))  and IsNull(Fac.Anulada,'')<>'SI'

 UNION ALL 

 SELECT 
	Dev.FechaDevolucion,
	Case When Dev.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'03')
			When Dev.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'08')
			When Dev.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'13')
			When Dev.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'21')
	End,
	Dev.PuntoVenta,
	Dev.NumeroDevolucion,
	Case When IBCondiciones.CodigoAFIP is not null Then IBCondiciones.CodigoAFIP Else 0 End,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * 100,
	'',
	0,
	''
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Dev.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=5
 WHERE Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta) and (Dev.Anulada is null or Dev.Anulada<>'SI')

 UNION ALL 

 SELECT 
	Deb.FechaNotaDebito,
	Case When Deb.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'02')
			When Deb.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'07')
			When Deb.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'12')
			When Deb.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'20')
	End,
	Deb.PuntoVenta,
	Deb.NumeroNotaDebito,
	Case When IBCondiciones.CodigoAFIP is not null Then IBCondiciones.CodigoAFIP Else 0 End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda * 100,
	'',
	0,
	''
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Deb.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=3
 WHERE Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta) and (Deb.Anulada is null or Deb.Anulada<>'SI')

 UNION ALL 

 SELECT 
	Cre.FechaNotaCredito,
	Case When Cre.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'03')
			When Cre.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'08')
			When Cre.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'13')
			When Cre.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'21')
	End,
	Cre.PuntoVenta,
	Cre.NumeroNotaCredito,
	Case When IBCondiciones.CodigoAFIP is not null Then IBCondiciones.CodigoAFIP Else 0 End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * 100,
	'',
	0,
	''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Cre.IdIBCondicion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 WHERE Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta) and (Cre.Anulada is null or Cre.Anulada<>'SI')

UPDATE #Auxiliar
SET ImportePercepcionesIIBB=0
WHERE ImportePercepcionesIIBB IS NULL

UPDATE #Auxiliar
SET ImportePercepcionesImpuestosMunicipales=0
WHERE ImportePercepcionesImpuestosMunicipales IS NULL

UPDATE #Auxiliar
SET Registro = 	
		Convert(varchar,Year(#Auxiliar.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
		#Auxiliar.TipoComprobante+
		Substring('00000',1,5-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
		Substring('00',1,2-len(Convert(varchar,#Auxiliar.CodigoJurisdiccionIIBB)))+Convert(varchar,#Auxiliar.CodigoJurisdiccionIIBB)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar.ImportePercepcionesIIBB),1,15)+
		Substring(#Auxiliar.JurisdiccionImpuestosMunicipales+'                                        ',1,40)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales),1,15)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111133'
SET @vector_T='043115555500'

SELECT 
	0 as [IdAux],
	FechaComprobante as [Fecha comp.],
	TipoComprobante as [Tipo comp.],
	PuntoVenta as [Pto.vta.],
	NumeroComprobante as [Nro.comp.],
	CodigoJurisdiccionIIBB as [Cod.jur.IIBB],
	ImportePercepcionesIIBB as [Imp.perc.IIBB],
	JurisdiccionImpuestosMunicipales as [Jurisdiccion impuestos municipales],
	ImportePercepcionesImpuestosMunicipales as [Imp.perc.impuestos],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar 
WHERE ImportePercepcionesIIBB<>0 or ImportePercepcionesImpuestosMunicipales<>0
ORDER By FechaComprobante,TipoComprobante,PuntoVenta,NumeroComprobante

DROP TABLE #Auxiliar