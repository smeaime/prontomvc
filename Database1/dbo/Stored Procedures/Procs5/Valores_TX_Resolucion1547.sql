
CREATE  Procedure [dbo].[Valores_TX_Resolucion1547]

@Desde datetime,
@Hasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_Fecha DATETIME,
			 A_MedioPago VARCHAR(2),
			 A_IdentificacionMedioPago VARCHAR(30),
			 A_CuitEmisorCheque VARCHAR(11),
			 A_ImporteCheque NUMERIC(18,0),
			 A_CuitBanco VARCHAR(11),
			 A_ProcedimientoPago VARCHAR(2),
			 A_CuitProveedor VARCHAR(11),
			 A_Proveedor VARCHAR(30),
			 A_IdTipoComprobanteImputado INTEGER,
			 A_TipoComprobanteImputado VARCHAR(2),
			 A_LetraComprobanteImputado VARCHAR(1),
			 A_Numero1ComprobanteImputado INTEGER,
			 A_Numero2ComprobanteImputado INTEGER,
			 A_ImporteTotalOP NUMERIC(18,0),
			 A_TipoMoneda VARCHAR(3),
			 A_Registro VARCHAR(160)
			)
INSERT INTO #Auxiliar 
 SELECT 
  op.FechaOrdenPago,
  Case When DetOP.IdValor is not null Then '06' Else '03' End,
  Case When DetOP.IdValor is not null Then 'Endoso de cheque' Else 'Cheques' End,
  Case When DetOP.IdValor is not null 
	Then Isnull((Select Top 1 Substring(Valores.CuitLibrador,1,2)+
				  Substring(Valores.CuitLibrador,4,8)+
				  Substring(Valores.CuitLibrador,13,1) 
			From Valores Where Valores.IdValor=DetOP.IdValor),'00000000000')
	Else Isnull((Select Top 1 Substring(Empresa.Cuit COLLATE Modern_Spanish_CI_AS,1,2)+
				  Substring(Empresa.Cuit COLLATE Modern_Spanish_CI_AS,4,8)+
				  Substring(Empresa.Cuit COLLATE Modern_Spanish_CI_AS,13,1) 
			From Empresa Where Empresa.IdEmpresa=1),'00000000000')
  End,
  DetOP.Importe * 100,
  Case When DetOP.IdBanco is not null 
	Then Isnull((Select Top 1 Substring(Bancos.Cuit,1,2)+
				  Substring(Bancos.Cuit,4,8)+
				  Substring(Bancos.Cuit,13,1) 
			From Bancos Where Bancos.IdBanco=DetOP.IdBanco),'00000000000')
	Else '00000000000'
  End,
  Case When DetOP.FechaVencimiento<=op.FechaOrdenPago Then '01' Else '02' End,
  Case When pr.Cuit is not null 
	Then Substring(pr.Cuit,1,2)+Substring(pr.Cuit,4,8)+Substring(pr.Cuit,13,1) 
	Else '00000000000'
  End,
  Substring(pr.RazonSocial,1,30),
  (Select Top 1 Cta.IdTipoComp
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdImputacion>0 and Cta.IdTipoComp<>17),
  Null,
  (Select Top 1 cp.Letra
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
   Where dp.IdOrdenPago=DetOP.IdOrdenPago and cp.Letra is not null),
  (Select Top 1 cp.NumeroComprobante1
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
   Where dp.IdOrdenPago=DetOP.IdOrdenPago and cp.NumeroComprobante1 is not null),
  (Select Top 1 cp.NumeroComprobante2
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
   Where dp.IdOrdenPago=DetOP.IdOrdenPago and cp.NumeroComprobante2 is not null),
  (Select Sum(DetalleOrdenesPagoValores.Importe)
   From DetalleOrdenesPagoValores
   Where DetalleOrdenesPagoValores.IdOrdenPago=op.IdOrdenPago) * 100,
  Monedas.CodigoAFIP,
  ''
 FROM DetalleOrdenesPagoValores DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = op.IdMoneda 
 LEFT OUTER JOIN Empresa ON Empresa.IdEmpresa = 1
 WHERE 	(op.FechaOrdenPago between @Desde and @Hasta) and 
	(op.Anulada is null or op.Anulada<>'SI') and 
	(DetOP.IdValor is not null or DetOP.IdBanco is not null)


/*
UPDATE #Auxiliar
SET A_CuitEmisorCheque = (Select Top 1 	Substring(Empresa.Cuit,1,2)+
					Substring(Empresa.Cuit,4,8)+
					Substring(Empresa.Cuit,13,1) 
			  From Empresa)
WHERE A_CuitEmisorCheque IS NULL
*/

UPDATE #Auxiliar
SET A_CuitEmisorCheque = '00000000000'
WHERE A_CuitEmisorCheque IS NULL OR LEN(RTRIM(A_CuitEmisorCheque))=0

UPDATE #Auxiliar
SET A_CuitBanco = '00000000000'
WHERE A_CuitBanco IS NULL OR LEN(RTRIM(A_CuitBanco))=0

UPDATE #Auxiliar
SET A_CuitProveedor = '00000000000'
WHERE A_CuitProveedor IS NULL OR LEN(RTRIM(A_CuitProveedor))=0

UPDATE #Auxiliar
SET A_ImporteCheque = 0
WHERE A_ImporteCheque IS NULL

UPDATE #Auxiliar
SET A_LetraComprobanteImputado = ' '
WHERE A_LetraComprobanteImputado IS NULL

UPDATE #Auxiliar
SET A_Numero1ComprobanteImputado = 0
WHERE A_Numero1ComprobanteImputado IS NULL

UPDATE #Auxiliar
SET A_Numero2ComprobanteImputado = 0
WHERE A_Numero2ComprobanteImputado IS NULL

UPDATE #Auxiliar
SET A_Proveedor = ''
WHERE A_Proveedor IS NULL

UPDATE #Auxiliar
SET A_TipoComprobanteImputado = (Select Top 1 TiposComprobante.CodigoAFIP_Letra_A
				 From TiposComprobante
				 Where TiposComprobante.IdTipoComprobante=#Auxiliar.A_IdTipoComprobanteImputado and 
					#Auxiliar.A_LetraComprobanteImputado='A')
UPDATE #Auxiliar
SET A_TipoComprobanteImputado = (Select Top 1 TiposComprobante.CodigoAFIP_Letra_B
				 From TiposComprobante
				 Where TiposComprobante.IdTipoComprobante=#Auxiliar.A_IdTipoComprobanteImputado and 
					#Auxiliar.A_LetraComprobanteImputado='B')
UPDATE #Auxiliar
SET A_TipoComprobanteImputado = (Select Top 1 TiposComprobante.CodigoAFIP_Letra_C
				 From TiposComprobante
				 Where TiposComprobante.IdTipoComprobante=#Auxiliar.A_IdTipoComprobanteImputado and 
					#Auxiliar.A_LetraComprobanteImputado='C')
UPDATE #Auxiliar
SET A_TipoComprobanteImputado = (Select Top 1 TiposComprobante.CodigoAFIP_Letra_E
				 From TiposComprobante
				 Where TiposComprobante.IdTipoComprobante=#Auxiliar.A_IdTipoComprobanteImputado and 
					#Auxiliar.A_LetraComprobanteImputado='E')

UPDATE #Auxiliar
SET A_TipoComprobanteImputado = '92'
WHERE A_TipoComprobanteImputado IS NULL

UPDATE #Auxiliar
SET A_TipoMoneda = Case When A_TipoMoneda='PES' Then '080'
			When A_TipoMoneda='DOL' Then '002'
			When A_TipoMoneda='060' Then '099'
			Else '080'
		   End

UPDATE #Auxiliar
SET A_Registro = Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+
			 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+
			 Convert(varchar,Year(#Auxiliar.A_Fecha))+
		 #Auxiliar.A_MedioPago+
		 Substring(#Auxiliar.A_IdentificacionMedioPago+Space(30),1,30)+
		 #Auxiliar.A_CuitEmisorCheque+
		 Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.A_ImporteCheque)))+Convert(varchar,#Auxiliar.A_ImporteCheque)+
		 #Auxiliar.A_CuitBanco+
		 #Auxiliar.A_ProcedimientoPago+
		 #Auxiliar.A_CuitProveedor+
		 Substring(#Auxiliar.A_Proveedor+Space(30),1,30)+
		 #Auxiliar.A_TipoComprobanteImputado+
		 Substring('0000',1,4-Len(Convert(varchar,#Auxiliar.A_Numero1ComprobanteImputado)))+Convert(varchar,#Auxiliar.A_Numero1ComprobanteImputado)+
		 Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar.A_Numero2ComprobanteImputado)))+Convert(varchar,#Auxiliar.A_Numero2ComprobanteImputado)+
		 Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.A_ImporteTotalOP)))+Convert(varchar,#Auxiliar.A_ImporteTotalOP)+
		 #Auxiliar.A_TipoMoneda

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='01111111111111111133'
set @vector_T='05555555555555555500'

SELECT 
 0,
 A_Fecha as [Fecha Cmp.],
 A_MedioPago as [Medio pago],
 A_IdentificacionMedioPago as [Identificacion medio pago],
 A_CuitEmisorCheque as [CUIT emisor],
 A_ImporteCheque as [Importe cheque],
 A_CuitBanco as [CUIT banco],
 A_ProcedimientoPago as [Proc.pago],
 A_CuitProveedor as [CUIT prov.],
 A_Proveedor as [Proveedor],
 A_IdTipoComprobanteImputado as [IdTipoComprobanteImputado],
 A_TipoComprobanteImputado as [Tipo comp.imputado],
 A_LetraComprobanteImputado as [Letra],
 A_Numero1ComprobanteImputado as [Pto.vta.],
 A_Numero2ComprobanteImputado as [Numero],
 A_ImporteTotalOP as [Total OP],
 A_TipoMoneda as [Tipo moneda],
 A_Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
ORDER By A_Fecha,A_Proveedor

DROP TABLE #Auxiliar
