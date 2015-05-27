
CREATE Procedure [dbo].[MovimientosFletes_TX_LiquidacionConsolidada]

@Desde datetime,
@Hasta datetime,
@Todos int = Null,
@IdFlete int = Null,
@IdTransportista int = Null

AS 

SET NOCOUNT ON

SET @Todos=IsNull(@Todos,0)
SET @IdFlete=IsNull(@IdFlete,-1)
SET @IdTransportista=IsNull(@IdTransportista,-1)

DECLARE @IdUnidadPorHora int, @IdUnidadPorKilometro int

SET @IdUnidadPorHora=IsNull((Select Top 1 Convert(int,Valor) From Parametros2 Where Campo='IdUnidadPorHora'),0)
SET @IdUnidadPorKilometro=IsNull((Select Top 1 Convert(int,Valor) From Parametros2 Where Campo='IdUnidadPorKilometro'),0)

CREATE TABLE #Auxiliar0 
			(
			 IdTransportista INTEGER, 
			 IdFlete INTEGER, 
			 Tipo VARCHAR(5), 
			 Tipo1 VARCHAR(25), 
			 Fecha DATETIME, 
			 NumeroRemito VARCHAR(20), 
			 NumeroRemitoTransporte VARCHAR(20), 
			 Capacidad NUMERIC(18,2), 
			 IdArticulo INTEGER, 
			 Cantidad NUMERIC(18,2), 
			 Unidad VARCHAR(15), 
			 ValorUnitario NUMERIC(18,2),
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  Fletes.IdTransportista,
  fpd.IdFlete,
  '1.PD',
  'Parte diario de horas',
  fpd.Fecha,
  Null,
  Null,
  Null,
  Null,
  IsNull(fpd.Cantidad,0),
  'Hs',
  IsNull(TarifasFletes.ValorUnitario,0),
  IsNull(TarifasFletes.ValorUnitario,0)*IsNull(fpd.Cantidad,0)
 FROM FletesPartesDiarios fpd
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=fpd.IdFlete
 LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete=Fletes.IdTarifaFlete
 WHERE (@Todos=-1 or fpd.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdFlete=-1 or fpd.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista)

INSERT INTO #Auxiliar0 
 SELECT 
  Fletes.IdTransportista,
  mf.IdFlete, 
  '2.MF',
  'Viaje flete',
  mf.Fecha,
  Null,
  Null,
  Case When IsNull(Fletes.Capacidad,0)<>0 Then Fletes.Capacidad Else Null End,
  Null,
  IsNull(mf.DistanciaRecorridaKm,0),
  Case When IsNull(mf.ModalidadFacturacion,1)=1 Then 'M3 x Km'
	When IsNull(mf.ModalidadFacturacion,1)=2 Then 'Viaje'
	When IsNull(mf.ModalidadFacturacion,1)=3 Then 'Hs'
	Else ''
  End,
  IsNull(mf.ValorUnitario,0),
  Case When IsNull(mf.ModalidadFacturacion,1)=1 Then IsNull(Fletes.Capacidad,0)*IsNull(mf.DistanciaRecorridaKm,0)*IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=2 Then IsNull(mf.ValorUnitario,0)
	When IsNull(mf.ModalidadFacturacion,1)=3 Then 0
	Else 0
  End
 FROM MovimientosFletes mf 
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=mf.IdFlete
 LEFT OUTER JOIN PatronesGPS ON PatronesGPS.IdPatronGPS=mf.IdPatronGPS
 WHERE (mf.Tipo='D' or mf.Tipo='V') and IsNull(mf.ModalidadFacturacion,1)<>3 and 
	(@Todos=-1 or mf.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdFlete=-1 or mf.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista)

INSERT INTO #Auxiliar0 
 SELECT 
  Recepciones.IdTransportista,
  Recepciones.IdFlete, 
  '3.BZ',
  'Recepcion balanza',
  Recepciones.FechaRecepcion,
  Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2), 
  Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRemitoTransporte1)))+Convert(varchar,Recepciones.NumeroRemitoTransporte1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRemitoTransporte2)))+Convert(varchar,Recepciones.NumeroRemitoTransporte2), 
  Case When IsNull(Fletes.Capacidad,0)<>0 Then Fletes.Capacidad Else Null End,
  dr.IdArticulo,
  IsNull(Recepciones.DistanciaRecorrida,0),
  'Km',
  IsNull(Recepciones.TarifaFlete,0),
  IsNull(Recepciones.DistanciaRecorrida,0)*IsNull(Recepciones.TarifaFlete,0)
 FROM DetalleRecepciones dr
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion=Recepciones.IdRecepcion
 LEFT OUTER JOIN Articulos A1 ON dr.IdArticulo=A1.IdArticulo
 LEFT OUTER JOIN Transportistas ON Recepciones.IdTransportista=Transportistas.IdTransportista
 LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN DetalleRequerimientos ON dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetallePedidos ON dr.IdDetallePedido = DetallePedidos.IdDetallePedido
 LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN ArchivosATransmitirDestinos atd ON atd.IdArchivoATransmitirDestino = dr.IdOrigenTransmision
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = dr.IdUnidad
 LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete = Recepciones.IdTarifaFlete
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=Recepciones.IdFlete
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI' and (@Todos=-1 or Recepciones.FechaRecepcion between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdFlete=-1 or Recepciones.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and 
	dr.IdOrigenTransmision is not null and IsNull(atd.Sistema,'')='BALANZA'

INSERT INTO #Auxiliar0 
 SELECT 
  Fletes.IdTransportista,
  dsm.IdFlete, 
  '4.CO',
  'Consumo (salida)',
  SalidasMateriales.FechaSalidaMateriales,
  Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales), 
  Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroRemitoTransporte)))+Convert(varchar,SalidasMateriales.NumeroRemitoTransporte), 
  Case When IsNull(Fletes.Capacidad,0)<>0 Then Fletes.Capacidad Else Null End,
  dsm.IdArticulo,
  IsNull(dsm.Cantidad,0),
  Unidades.Abreviatura,
  IsNull(dsm.CostoUnitario,0),
  IsNull(dsm.Cantidad,0)*IsNull(dsm.CostoUnitario,0)*-1
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos A1 ON dsm.IdArticulo=A1.IdArticulo
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = dsm.IdUnidad
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=dsm.IdFlete
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and (@Todos=-1 or SalidasMateriales.FechaSalidaMateriales between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdFlete=-1 or dsm.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and 
	IsNull(dsm.IdFlete,0)>0

INSERT INTO #Auxiliar0 
 SELECT 
  Fletes.IdTransportista,
  GastosFletes.IdFlete,
  '5.GS',
  'Gastos flete',
  GastosFletes.Fecha,
  Null,
  Null,
  Null,
  GastosFletes.IdConcepto,
  1,
  'Un',
  IsNull(GastosFletes.Importe,0)*IsNull(GastosFletes.SumaResta,-1),
  IsNull(GastosFletes.Importe,0)*IsNull(GastosFletes.SumaResta,-1)
 FROM GastosFletes
 LEFT OUTER JOIN Fletes ON Fletes.IdFlete=GastosFletes.IdFlete
 WHERE (@Todos=-1 or GastosFletes.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdFlete=-1 or GastosFletes.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista)

SET NOCOUNT OFF

SELECT #Auxiliar0.*, Transportistas.RazonSocial as [Transportista], Fletes.Patente as [Patente], Articulos.Descripcion as [Material]
FROM #Auxiliar0
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=#Auxiliar0.IdFlete
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=#Auxiliar0.IdTransportista
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar0.IdArticulo
ORDER BY #Auxiliar0.IdTransportista, #Auxiliar0.IdFlete, #Auxiliar0.Tipo, #Auxiliar0.Fecha

DROP TABLE #Auxiliar0
