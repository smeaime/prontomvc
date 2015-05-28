CREATE PROCEDURE [dbo].[InformesContables_TX_1361_DetalleFacturas]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 TipoComprobante VARCHAR(2),
			 FechaComprobante DATETIME,
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 NumeroComprobanteRegistrado INTEGER,
			 Cantidad NUMERIC(19,0),
			 UnidadMedida VARCHAR(2),
			 PrecioUnitario NUMERIC(19,0),
			 ImporteBonificacion NUMERIC(19,0),
			 ImporteAjuste NUMERIC(19,0),
			 Subtotal NUMERIC(19,0),
			 AlicuotaIVA INTEGER,
			 IndicacionExentoGravado VARCHAR(1),
			 IndicacionAnulacion VARCHAR(1),
			 Observaciones VARCHAR(200),
			 Registro VARCHAR(300)
			)
INSERT INTO #Auxiliar 
 SELECT 
	Case When Fac.TipoABC='A'
		 Then Case When (DetFac.Cantidad*DetFac.PrecioUnitario)>=0 Then IsNull(Tc.CodigoAFIP_Letra_A,'01') Else '03' End
		When Fac.TipoABC='B'
		 Then Case When (DetFac.Cantidad*DetFac.PrecioUnitario)>=0 Then IsNull(Tc.CodigoAFIP_Letra_B,'06') Else '08' End
		When Fac.TipoABC='C'
		 Then Case When (DetFac.Cantidad*DetFac.PrecioUnitario)>=0 Then IsNull(Tc.CodigoAFIP_Letra_C,'11') Else '13' End
		When Fac.TipoABC='E'
		 Then Case When (DetFac.Cantidad*DetFac.PrecioUnitario)>=0 Then IsNull(Tc.CodigoAFIP_Letra_E,'19') Else '21' End
	End,
	Fac.FechaFactura,
	' ',
	Fac.PuntoVenta,
	Fac.NumeroFactura,
	Fac.NumeroFactura,
	Abs(DetFac.Cantidad) * 100000,
	Case When Unidades.CodigoAFIP is not null Then Substring(IsNull(Unidades.CodigoAFIP,'')+'  ',1,2) Else '  ' End,
	Abs(DetFac.PrecioUnitario) * 1000,
	Case When DetFac.Bonificacion is not null 
			Then Abs((DetFac.Cantidad*DetFac.PrecioUnitario)*DetFac.Bonificacion/100) * 100 
			Else 0 
	End,
	0,
	Case When DetFac.Bonificacion is not null 
			Then Abs((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100))) * 100 
			Else Abs(DetFac.Cantidad*DetFac.PrecioUnitario) * 100 
	End,
	Fac.PorcentajeIva1 * 100,
	Case When Fac.TipoABC='E' or Fac.PorcentajeIva1=0 Then 'E' Else 'G' End,
	Case When IsNull(Fac.Anulada,'')<>'SI' Then ' ' Else 'A' End,
	Substring(IsNull(Articulos.Descripcion,''),1,200),
	''
 FROM DetalleFacturas DetFac 
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=DetFac.IdFactura
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetFac.IdArticulo
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=DetFac.IdUnidad
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta)  --and IsNull(Fac.Anulada,'')<>'SI'

/*
UPDATE #Auxiliar
SET Cantidad=0, PrecioUnitario=0, ImporteBonificacion=0, ImporteAjuste=0, Subtotal=0, AlicuotaIVA=0
WHERE IndicacionAnulacion='A'
*/

UPDATE #Auxiliar
SET Registro = 	#Auxiliar.TipoComprobante+
		#Auxiliar.ControladorFiscal+
		Convert(varchar,Year(#Auxiliar.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
		Substring('00000',1,5-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobanteRegistrado)))+Convert(varchar,#Auxiliar.NumeroComprobanteRegistrado)+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.Cantidad)))+Convert(varchar,#Auxiliar.Cantidad),1,12)+
		#Auxiliar.UnidadMedida+
		Substring('0000000000000000',1,16-len(Convert(varchar,#Auxiliar.PrecioUnitario)))+Convert(varchar,#Auxiliar.PrecioUnitario)+
		Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteBonificacion)))+Convert(varchar,#Auxiliar.ImporteBonificacion)+
		'0000000000000000'+
		Substring('0000000000000000',1,16-len(Convert(varchar,#Auxiliar.Subtotal)))+Convert(varchar,#Auxiliar.Subtotal)+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.AlicuotaIVA)))+Convert(varchar,#Auxiliar.AlicuotaIVA)+
		#Auxiliar.IndicacionExentoGravado+
		#Auxiliar.IndicacionAnulacion+
		Substring(#Auxiliar.Observaciones+
		'                                                                                                                                                                                                        ',1,75)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111133'
SET @vector_T='0341125333333333300'

SELECT 
	0 as [IdAux],
	TipoComprobante as [Tipo comp.],
	FechaComprobante as [Fecha comp.],
	ControladorFiscal as [C.fiscal],
	PuntoVenta as [Pto.vta.],
	NumeroComprobante as [Nro.comp.],
	NumeroComprobanteRegistrado as [Nro.comp.reg.],
	Cantidad as [Cantidad],
	UnidadMedida as [Un.med.],
	PrecioUnitario as [Pre.un.],
	ImporteBonificacion as [Imp.bon.],
	Subtotal as [Subtotal],
	AlicuotaIVA as [% IVA],
	IndicacionExentoGravado as [Exento/Gravado],
	IndicacionAnulacion as [Anulada],
	Observaciones as [Observaciones],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar 
ORDER By TipoComprobante,PuntoVenta,NumeroComprobante

DROP TABLE #Auxiliar