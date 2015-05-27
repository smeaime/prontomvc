
CREATE PROCEDURE [dbo].[Clientes_TX_PercepcionesIVA]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_Cliente VARCHAR(50),
			 A_CuitCliente VARCHAR(13),
			 A_Fecha DATETIME,
			 A_CodigoComprobante VARCHAR(2),
			 A_TipoComprobante VARCHAR(1),
			 A_LetraComprobante VARCHAR(1),
			 A_PuntoVenta INTEGER,
			 A_Numero INTEGER,
			 A_CodigoCondicion VARCHAR(2),
			 A_BaseImponible NUMERIC(18,2),
			 A_ImporteTotal NUMERIC(18,2),
			 A_ImportePercepcion NUMERIC(18,2),
			 A_Alicuota NUMERIC(6,0),
			 A_CuitEmpresa VARCHAR(11),
			 A_Registro VARCHAR(150)
			)
INSERT INTO #Auxiliar 
 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  Facturas.FechaFactura,
  '01',
  'F',
  Facturas.TipoABC,
  Facturas.PuntoVenta,
  Facturas.NumeroFactura,
  Case 	When Facturas.IdCodigoIva=1 Then '01'
	When Facturas.IdCodigoIva=2 Then '02'
	Else '03'
  End,
  (Facturas.ImporteTotal - Facturas.ImporteIva1 - Facturas.ImporteIva2 - 
	Facturas.RetencionIBrutos1 - Facturas.RetencionIBrutos2 - 
	Facturas.RetencionIBrutos3) * Facturas.CotizacionMoneda,
  Facturas.ImporteTotal * Facturas.CotizacionMoneda,
  IsNull(Facturas.PercepcionIVA,0) * Facturas.CotizacionMoneda,
  IsNull(Facturas.PorcentajePercepcionIVA,0),
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) 
   From Empresa),
  ''
 FROM Facturas 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Facturas.IdIBCondicion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 WHERE (Facturas.FechaFactura between @Desde and @Hasta) and 
	(Facturas.Anulada is null or Facturas.Anulada<>'SI') and 
	IsNull(Facturas.PercepcionIVA,0)<>0

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasDebito.FechaNotaDebito,
  '04',
  'D',
  NotasDebito.TipoABC,
  NotasDebito.PuntoVenta,
  NotasDebito.NumeroNotaDebito,
  Case 	When NotasDebito.IdCodigoIva=1 Then '01'
	When NotasDebito.IdCodigoIva=2 Then '02'
	Else '03'
  End,
  (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
	Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito) * NotasDebito.CotizacionMoneda,
  NotasDebito.ImporteTotal * NotasDebito.CotizacionMoneda,
  IsNull(NotasDebito.PercepcionIVA,0) * NotasDebito.CotizacionMoneda,
  IsNull(NotasDebito.PorcentajePercepcionIVA,0),
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) 
   From Empresa),
  ''
 FROM NotasDebito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasDebito.IdIBCondicion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasDebito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @Hasta) and 
	(NotasDebito.Anulada is null or NotasDebito.Anulada<>'SI') and 
	IsNull(NotasDebito.PercepcionIVA,0)<>0

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasCredito.FechaNotaCredito,
  '03',
  'C',
  NotasCredito.TipoABC,
  NotasCredito.PuntoVenta,
  NotasCredito.NumeroNotaCredito,
  Case 	When NotasCredito.IdCodigoIva=1 Then '01'
	When NotasCredito.IdCodigoIva=2 Then '02'
	Else '03'
  End,
  IsNull(NotasCredito.PercepcionIVA,0) * NotasCredito.CotizacionMoneda * -1,
  NotasCredito.ImporteTotal * NotasCredito.CotizacionMoneda * -1,
  IsNull(NotasCredito.PercepcionIVA,0) * NotasCredito.CotizacionMoneda * -1,
  IsNull(NotasCredito.PorcentajePercepcionIVA,0),
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) 
   From Empresa),
  ''
 FROM NotasCredito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasCredito.IdIBCondicion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasCredito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @Hasta) and 
	(NotasCredito.Anulada is null or NotasCredito.Anulada<>'SI') and 
	IsNull(NotasCredito.PercepcionIVA,0)<>0

UPDATE #Auxiliar
SET A_LetraComprobante = 'A'
WHERE A_LetraComprobante IS NULL

UPDATE #Auxiliar
SET A_CuitCliente = '27-00000000-6'
WHERE A_CuitCliente IS NULL OR LEN(RTRIM(A_CuitCliente))=0

UPDATE #Auxiliar
SET A_PuntoVenta = 1
WHERE A_PuntoVenta IS NULL

UPDATE #Auxiliar
SET A_BaseImponible = 0
WHERE A_BaseImponible IS NULL

UPDATE #Auxiliar
SET A_ImportePercepcion = 0
WHERE A_ImportePercepcion IS NULL

UPDATE #Auxiliar
SET A_Alicuota = 0
WHERE A_Alicuota IS NULL

UPDATE #Auxiliar
SET A_Registro = A_CodigoComprobante+
		 Convert(varchar,#Auxiliar.A_Fecha,103)+
		 Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
		 Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
		 Substring('0000000000000000',1,16-len(Convert(varchar,Abs(#Auxiliar.A_ImporteTotal))))+Convert(varchar,Abs(#Auxiliar.A_ImporteTotal))+
		 '767'+
		 '493'+
		 '2'+
		 Substring('00000000000000',1,14-len(Convert(varchar,Abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,Abs(#Auxiliar.A_BaseImponible))+
		 Convert(varchar,#Auxiliar.A_Fecha,103)+
		 A_CodigoCondicion+
		 '0'+
		 Substring('00000000000000',1,14-len(Convert(varchar,Abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,Abs(#Auxiliar.A_ImportePercepcion))+
		 '000.00'+
		 '00/00/0000'+
		 '80'+
		 '000000000'+Substring(A_CuitCliente,1,2)+Substring(A_CuitCliente,4,8)+Substring(A_CuitCliente,13,1)+
		 '00000000000000'

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='001111111111111133'
set @vector_T='005555555555555500'

SELECT 
 0,
 1 as [K_Tipo],
 A_Cliente as [Cliente],
 A_CuitCliente as [Cuit cliente],
 A_Fecha as [Fecha Cmp.],
 A_CodigoComprobante as [Cod.Cmp.],
 A_TipoComprobante as [Tipo Cmp.],
 A_LetraComprobante as [Letra Cmp.],
 A_PuntoVenta as [Punto venta],
 A_Numero as [Numero Cmp.],
 A_BaseImponible as [Base Imp.],
 A_ImporteTotal as [Imp.Total],
 A_ImportePercepcion as [Importe perc.],
 A_Alicuota as [Alicuota],
 A_CuitEmpresa as [CUIT Empresa],
 A_Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 

UNION ALL

SELECT 
 0,
 4 as [K_Tipo],
 'TOTAL GENERAL' as [Cliente],
 Null as [Cuit cliente],
 Null as [Fecha Cmp.],
 Null as [Cod.Cmp.],
 Null as [Tipo Cmp.],
 Null as [Letra Cmp.],
 Null as [Punto venta],
 Null as [Numero Cmp.],
 Null as [Base Imp.],
 Null as [Imp.Total],
 SUM(A_ImportePercepcion) as [Importe perc.],
 Null as [Alicuota],
 Null as [CUIT Empresa],
 Null as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 

ORDER By [K_Tipo],A_Fecha,A_Cliente,A_Numero

DROP TABLE #Auxiliar
