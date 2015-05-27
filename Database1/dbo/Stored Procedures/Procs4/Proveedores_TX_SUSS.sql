CREATE PROCEDURE [dbo].[Proveedores_TX_SUSS]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_Proveedor VARCHAR(50),
			 A_Cuit VARCHAR(11),
			 A_Fecha DATETIME,
			 A_NumeroMovimiento INTEGER,
			 A_NumeroCertificado INTEGER,
			 A_ImporteRetencion NUMERIC(18,0),
			 A_Codigo VARCHAR(3),
			 A_Registro VARCHAR(100)
			)
INSERT INTO #Auxiliar 
 SELECT 
  pr.RazonSocial,
  Substring(pr.Cuit,1,2)+Substring(pr.Cuit,4,8)+Substring(pr.Cuit,13,1),
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  op.NumeroCertificadoRetencionSUSS,
  op.RetencionSUSS * op.CotizacionMoneda * 100,
  IsNull(ImpuestosDirectos.Codigo,'000'),
  ''
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores pr ON op.IdProveedor = pr.IdProveedor
 LEFT OUTER JOIN TiposRetencionGanancia ON pr.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
 LEFT OUTER JOIN ImpuestosDirectos ON pr.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
 WHERE (op.FechaOrdenPago between @Desde and @hasta) and 
	(op.Anulada is null or op.Anulada<>'SI') and 
	(op.Confirmado is null or op.Confirmado<>'NO') and 
	op.IdProveedor is not null

UPDATE #Auxiliar
SET A_ImporteRetencion = 0
WHERE A_ImporteRetencion IS NULL

UPDATE #Auxiliar
SET A_NumeroCertificado = 0
WHERE A_NumeroCertificado IS NULL

UPDATE #Auxiliar
SET A_Codigo = Substring('000',1,3-len(Convert(varchar,A_Codigo)))+A_Codigo
WHERE Len(A_Codigo)<>3

UPDATE #Auxiliar
SET A_Registro =#Auxiliar.A_Codigo+A_Cuit+'000000000'+
		 Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		 Convert(varchar,Year(#Auxiliar.A_Fecha))+
		 Substring(Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_ImporteRetencion)))+Convert(varchar,#Auxiliar.A_ImporteRetencion),1,6)+','+
		 	Substring(Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_ImporteRetencion)))+Convert(varchar,#Auxiliar.A_ImporteRetencion),7,2)+
		 Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_NumeroCertificado)))+Convert(varchar,#Auxiliar.A_NumeroCertificado)

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='0111111133'
set @vector_T='0555555500'

SELECT 
 0,
 A_Proveedor as [Proveedor],
 A_Cuit as [Cuit],
 A_Fecha as [Fecha O.Pago],
 A_NumeroMovimiento as [Nro.O.Pago],
 A_NumeroCertificado as [Numero certificado],
 A_ImporteRetencion/100 as [Importe ret.],
 A_Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_ImporteRetencion<>0
ORDER By A_Fecha,A_Proveedor,A_NumeroMovimiento

DROP TABLE #Auxiliar