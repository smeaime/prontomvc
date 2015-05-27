
CREATE Procedure [dbo].[Bancos_TX_Retenciones]

@FechaDesde datetime,
@FechaHasta datetime,
@IdCuenta int

AS 

SET NOCOUNT ON

DECLARE @Codigo varchar(3)
SET @Codigo='001'

CREATE TABLE #Auxiliar1 
			(
			 IdValor INTEGER,
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 NumeroCertificado VARCHAR(20),
			 Importe NUMERIC(18,2),
			 Registro VARCHAR(200)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  Valores.IdValor,
  IsNull(Bancos.Cuit,'00-00000000-0'),
  Valores.FechaComprobante,
  IsNull(Valores.CertificadoRetencion,'0000000000000000'),
  Valores.Importe,
  ''
 FROM Valores
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 LEFT OUTER JOIN Bancos ON CuentasBancarias.IdBanco=Bancos.IdBanco
WHERE Valores.Estado='G' and Valores.IdCuentaContable=@IdCuenta and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaComprobante between @FechaDesde and @FechaHasta)

UPDATE #Auxiliar1
SET Registro = 	@Codigo + Cuit + 
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+
			Convert(varchar,Year(Fecha))+
		Substring('0000000000000000',1,16-len(Ltrim(NumeroCertificado)))+
			Ltrim(NumeroCertificado)

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='01111133'
Set @vector_T='05432F00'

SELECT 
	IdValor as [IdValor],
	Cuit as [Cuit],
	Fecha as [Fecha],
	NumeroCertificado as [Certificado],
	Importe as [Importe],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
ORDER BY Cuit, Fecha, NumeroCertificado

DROP TABLE #Auxiliar1
