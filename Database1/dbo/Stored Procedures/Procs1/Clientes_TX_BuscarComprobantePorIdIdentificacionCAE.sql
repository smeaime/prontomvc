CREATE  Procedure [dbo].[Clientes_TX_BuscarComprobantePorIdIdentificacionCAE]

@IdIdentificacionCAE int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar(IdComprobante INTEGER, Comprobante VARCHAR(20))
INSERT INTO #Auxiliar 
 SELECT IdFactura, 
	'FA '+TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,NumeroFactura)))+Convert(varchar,NumeroFactura)
 FROM Facturas
 WHERE IsNull(IdIdentificacionCAE,-1)=@IdIdentificacionCAE

INSERT INTO #Auxiliar 
 SELECT IdNotaCredito, 
	'NC '+TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,NumeroNotaCredito)))+Convert(varchar,NumeroNotaCredito)
 FROM NotasCredito
 WHERE IsNull(IdIdentificacionCAE,-1)=@IdIdentificacionCAE

INSERT INTO #Auxiliar 
 SELECT IdNotaDebito, 
	'ND '+TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,NumeroNotaDebito)))+Convert(varchar,NumeroNotaDebito)
 FROM NotasDebito
 WHERE IsNull(IdIdentificacionCAE,-1)=@IdIdentificacionCAE

SET NOCOUNT OFF

SELECT * FROM #Auxiliar ORDER BY Comprobante

DROP TABLE #Auxiliar