
CREATE Procedure [dbo].[MovimientosFletes_TX_Liquidacion]

@Desde datetime,
@Hasta datetime,
@Todos int = Null,
@IdFlete int = Null

AS 

SET NOCOUNT ON

SET @Todos=IsNull(@Todos,0)
SET @IdFlete=IsNull(@IdFlete,-1)

CREATE TABLE #Auxiliar0 
			(
			 IdFlete INTEGER, 
			 Horas NUMERIC(18,2), 
			 ValorUnitario NUMERIC(18,2)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  fpd.IdFlete,
  Sum(IsNull(fpd.Cantidad,0)),
  Max(IsNull(TarifasFletes.ValorUnitario,0))
 FROM FletesPartesDiarios fpd
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=fpd.IdFlete
 LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete=Fletes.IdTarifaFlete
 WHERE (@Todos=-1 or fpd.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and (@IdFlete=-1 or fpd.IdFlete=@IdFlete)
 GROUP BY fpd.IdFlete

CREATE TABLE #Auxiliar1 
			(
			 IdFlete INTEGER, 
			 ImporteALiquidar NUMERIC(18,2), 
			 ImporteGastos NUMERIC(18,2), 
			 Horas NUMERIC(18,2), 
			 ValorUnitario NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  mf.IdFlete, 
  Case When IsNull(mf.ModalidadFacturacion,1)=1 Then IsNull(Fletes.Capacidad,0)*IsNull(mf.DistanciaRecorridaKm,0)*IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=2 Then IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=3 Then 0
	Else 0
  End,
  0, 
  0,
  IsNull(mf.ValorUnitario,0)
 FROM MovimientosFletes mf 
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=mf.IdFlete
 LEFT OUTER JOIN PatronesGPS ON PatronesGPS.IdPatronGPS=mf.IdPatronGPS
 WHERE (mf.Tipo='D' or mf.Tipo='V') and IsNull(mf.ModalidadFacturacion,1)<>3 and 
	(@Todos=-1 or mf.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and (@IdFlete=-1 or mf.IdFlete=@IdFlete)

INSERT INTO #Auxiliar1 
 SELECT Fletes.IdFlete, IsNull(#Auxiliar0.Horas,0)*IsNull(#Auxiliar0.ValorUnitario,0), 0, IsNull(#Auxiliar0.Horas,0), IsNull(#Auxiliar0.ValorUnitario,0)
 FROM Fletes
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdFlete=Fletes.IdFlete
 WHERE IsNull(Fletes.ModalidadFacturacion,1)=3

INSERT INTO #Auxiliar1 
 SELECT GastosFletes.IdFlete, 0, IsNull(GastosFletes.Importe,0)*IsNull(GastosFletes.SumaResta,-1), 0, 0
 FROM GastosFletes
 WHERE (@Todos=-1 or GastosFletes.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and (@IdFlete=-1 or GastosFletes.IdFlete=@IdFlete)

CREATE TABLE #Auxiliar2 
			(
			 IdFlete INTEGER, 
			 ImporteALiquidar NUMERIC(18,2), 
			 ImporteGastos NUMERIC(18,2), 
			 Horas NUMERIC(18,2), 
			 ValorUnitario NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdFlete, Sum(ImporteALiquidar), Sum(ImporteGastos), Sum(Horas), Max(ValorUnitario)
 FROM #Auxiliar1
 GROUP BY IdFlete

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00001111111111181133'
SET @vector_T='000034H100082544D000'

SELECT 
 mf.IdMovimientoFlete as [IdAux],
 Fletes.Patente as [Aux1],
 1 as [Aux2],
 mf.Fecha as [Aux3],
 Fletes.Patente as [Patente],
 mf.Fecha as [Fecha],
 Convert(varchar,mf.Fecha,108) as [Hora],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 DispositivosGPS.Descripcion as [Dispositivo GPS],
 Case When IsNull(mf.ModalidadFacturacion,1)=1 Then 'Por M3-Km'
	When IsNull(mf.ModalidadFacturacion,1)=2 Then 'Por Viaje'
	When IsNull(mf.ModalidadFacturacion,1)=3 Then 'Por Horas'
	Else ''
 End as [Modalidad de facturacion],
 Fletes.Capacidad as [Capacidad],
 mf.DistanciaRecorridaKm as [Dist.recorrida en km],
 mf.ValorUnitario as [Valor unitario],
 Case When IsNull(mf.ModalidadFacturacion,1)=1 Then IsNull(Fletes.Capacidad,0)*IsNull(mf.DistanciaRecorridaKm,0)*IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=2 Then IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=3 Then Null
	Else Null
 End  as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM MovimientosFletes mf 
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=mf.IdFlete
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
LEFT OUTER JOIN DispositivosGPS ON DispositivosGPS.IdDispositivoGPS=mf.IdDispositivoGPS
LEFT OUTER JOIN PatronesGPS ON PatronesGPS.IdPatronGPS=mf.IdPatronGPS
WHERE (mf.Tipo='D' or mf.Tipo='V') and IsNull(mf.ModalidadFacturacion,1)<>3 and 
	(@Todos=-1 or mf.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and (@IdFlete=-1 or mf.IdFlete=@IdFlete)

UNION ALL

SELECT 
 0 as [IdAux],
 Fletes.Patente as [Aux1],
 1 as [Aux2],
 @Hasta as [Aux3],
 Fletes.Patente as [Patente],
 @Hasta as [Fecha],
 Null as [Hora],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Fletes.Capacidad as [Capacidad],
 Null as [Dist.recorrida en km],
 IsNull(#Auxiliar2.ValorUnitario,0) as [Valor unitario],
 IsNull(#Auxiliar2.ImporteALiquidar,0) as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Fletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdFlete=Fletes.IdFlete
WHERE IsNull(Fletes.ModalidadFacturacion,1)=3 and (@IdFlete=-1 or Fletes.IdFlete=@IdFlete)

UNION ALL

SELECT 
 0 as [IdAux],
 Fletes.Patente as [Aux1],
 2 as [Aux2],
 Null as [Aux3],
 Fletes.Patente as [Patente],
 Null as [Fecha],
 Null as [Hora],
 Null as [Nro.Int.],
 Case When IsNull(#Auxiliar2.Horas,0)=0 Then 'TOTAL VIAJES' 
	Else 'TOTAL '+Convert(varchar,#Auxiliar2.Horas)+' Hs a $ '+Convert(varchar,#Auxiliar2.ValorUnitario)
 End as [Propietario],
 Null as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Null as [Capacidad],
 Null as [Dist.recorrida en km],
 Null as [Valor unitario],
 IsNull(#Auxiliar2.ImporteALiquidar,0) as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=#Auxiliar2.IdFlete

UNION ALL

SELECT 
 GastosFletes.IdGastoFlete as [IdAux],
 Fletes.Patente as [Aux1],
 3 as [Aux2],
 GastosFletes.Fecha as [Aux3],
 Fletes.Patente as [Patente],
 GastosFletes.Fecha as [Fecha],
 Null as [Hora],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Null as [Capacidad],
 Null as [Dist.recorrida en km],
 Null as [Valor unitario],
 IsNull(GastosFletes.Importe,0)*IsNull(GastosFletes.SumaResta,-1) as [Importe],
 Articulos.Descripcion as [Concepto],
 GastosFletes.Detalle as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM GastosFletes
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=GastosFletes.IdFlete
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=GastosFletes.IdConcepto
WHERE @Todos=-1 or GastosFletes.Fecha between @Desde and DATEADD(n,1439,@Hasta) and (@IdFlete=-1 or GastosFletes.IdFlete=@IdFlete)

UNION ALL

SELECT 
 0 as [IdAux],
 Fletes.Patente as [Aux1],
 4 as [Aux2],
 Null as [Aux3],
 Fletes.Patente as [Patente],
 Null as [Fecha],
 Null as [Hora],
 Null as [Nro.Int.],
 'TOTAL GASTOS' as [Propietario],
 Null as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Null as [Capacidad],
 Null as [Dist.recorrida en km],
 Null as [Valor unitario],
 IsNull(#Auxiliar2.ImporteGastos,0) as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=#Auxiliar2.IdFlete

UNION ALL

SELECT 
 0 as [IdAux],
 Fletes.Patente as [Aux1],
 5 as [Aux2],
 Null as [Aux3],
 Fletes.Patente as [Patente],
 Null as [Fecha],
 Null as [Hora],
 Null as [Nro.Int.],
 'TOTAL A LIQUIDAR' as [Propietario],
 Null as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Null as [Capacidad],
 Null as [Dist.recorrida en km],
 Null as [Valor unitario],
 IsNull(#Auxiliar2.ImporteALiquidar,0)+IsNull(#Auxiliar2.ImporteGastos,0) as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=#Auxiliar2.IdFlete

UNION ALL

SELECT 
 0 as [IdAux],
 Fletes.Patente as [Aux1],
 6 as [Aux2],
 Null as [Aux3],
 Null as [Patente],
 Null as [Fecha],
 Null as [Hora],
 Null as [Nro.Int.],
 Null as [Propietario],
 Null as [Chofer],
 Null as [Dispositivo GPS],
 Null as [Modalidad de facturacion],
 Null as [Capacidad],
 Null as [Dist.recorrida en km],
 Null as [Valor unitario],
 Null as [Importe],
 Null as [Concepto],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=#Auxiliar2.IdFlete

ORDER BY [Aux1], [Aux2], [Aux3]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
