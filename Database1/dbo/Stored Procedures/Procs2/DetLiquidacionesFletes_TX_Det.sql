CREATE PROCEDURE [dbo].[DetLiquidacionesFletes_TX_Det]

@IdLiquidacionFlete int,
@Tipo varchar(1) = Null

AS

SET @Tipo=IsNull(@Tipo,'*')

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='0111111111111111111111111111111111111111133'
SET @vector_T='0099912E4C222202222229999999999999999999E00'

SELECT
 dlf.IdDetalleLiquidacionFlete,
 Fletes.Descripcion as [Flete],
 dlf.IdDetalleLiquidacionFlete as [IdAux],
 dlf.IdTipoComprobante as [IdTipoComprobante],
 dlf.IdComprobante as [IdComprobante],
 Fletes.Patente as [Patente],
 Case When dlf.IdTipoComprobante=60 Then 'RECEPCION' When dlf.IdTipoComprobante=50 and SalidasMateriales.IdFlete is not null Then 'SALIDA' 
	When dlf.IdTipoComprobante=50 and dsm.IdFlete is not null Then 'CONSUMO' When dlf.IdTipoComprobante=120 Then 'OTROS CONCEPTOS' Else Null End as [Tipo],
 Case When Recepciones.IdRecepcion is not null
	 Then Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)
	When SalidasMateriales.IdSalidaMateriales is not null
	 Then Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
	 Else Null
 End as [Numero],
 IsNull(Recepciones.FechaRecepcion, IsNull(SalidasMateriales.FechaSalidaMateriales, GastosFletes.Fecha)) as [Fecha],
 Articulos.Descripcion as [Material / Concepto],
 IsNull(Recepciones.PesoBruto, SalidasMateriales.PesoBruto) as [Peso bruto],
 IsNull(Recepciones.Tara, SalidasMateriales.Tara) as [Tara],
 IsNull(Recepciones.PesoNeto, SalidasMateriales.PesoNeto) as [Peso neto],
 IsNull(dr.Cantidad, dsm.Cantidad) as [Cant.a fact.],
 U1.Abreviatura as [Un.],
 TarifasFletes.Codigo as [Cod.Tarifa],
 dlf.ValorUnitarioTarifa as [Valor tarifa],
 U2.Abreviatura as [Un.Tar.],
 dlf.EquivalenciaAUnidadTarifa as [Equiv.Unidades],
 dlf.Importe as [Imp.Liquidacion],
 Choferes.Nombre as [Chofer],
 Case When U1.IdUnidad=IsNull(Articulos.IdUnidad,0) 
	 Then IsNull(dr.Cantidad, dsm.Cantidad) 
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=Articulos.IdArticulo and dau.IdUnidad=U1.IdUnidad),0)<>0
	 Then IsNull(dr.Cantidad, dsm.Cantidad)  / (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=Articulos.IdArticulo and dau.IdUnidad=U1.IdUnidad) 
	Else Null
 End as [Cantidad],
 GastosFletes.Detalle as [DetalleGastos],
 IsNull(SalidasMateriales.FechaPesada,Recepciones.FechaPesada) as [FechaPesada],
 IsNull(SalidasMateriales.ObservacionesPesada,Recepciones.ObservacionesPesada) as [ObservacionesPesada],
 IsNull(SalidasMateriales.NumeroPesada,Recepciones.NumeroPesada) as [NumeroPesada],
 LiquidacionesFletes.NumeroLiquidacion as [NumeroLiquidacion],
 Case When Len(Pesadas.RemitoMaterial)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoMaterial,0))))+Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) Else Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoMaterial2)))+Convert(varchar,Pesadas.RemitoMaterial2) as [RemitoPesada],
 Pesadas.NumeroOrdenCarga as [NumeroOrdenCarga],
 Pesadas.CantidadEnOrigen as [CantidadEnOrigen],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then Pesadas.CantidadSegunRemitoMasCoefEnKg Else  Pesadas.PesoNeto End as [ValorAceptadoKg],
 Pesadas.Progresiva1 as [Progresiva1],
 Pesadas.Progresiva2 as [Progresiva2],
 Case When IsNull(Pesadas.TaraIngresadaManualmente,'')='SI' or IsNull(Pesadas.PesoBrutoIngresadoManualmente,'')='SI' Then 'SI' Else '' End as [IngresoManual],
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 E1.Nombre as [DioPorCumplido],
 IsNull(dr.FechaDioPorCumplidoLiquidacionFletes,dsm.FechaDioPorCumplidoLiquidacionFletes) as [FechaDadoPorCumplido],
 IsNull(dr.ObservacionDioPorCumplidoLiquidacionFletes,dsm.ObservacionDioPorCumplidoLiquidacionFletes) as [ObservacionesCumplido],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoTransportista,0))))+Convert(varchar,IsNull(Pesadas.RemitoTransportista,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoTransportista2)))+Convert(varchar,Pesadas.RemitoTransportista2) as [Remito transporte],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleLiquidacionesFletes dlf
LEFT OUTER JOIN LiquidacionesFletes ON LiquidacionesFletes.IdLiquidacionFlete = dlf.IdLiquidacionFlete 
LEFT OUTER JOIN DetalleRecepciones dr ON dr.IdDetalleRecepcion = dlf.IdComprobante and dlf.IdTipoComprobante=60
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = dr.IdRecepcion
LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdDetalleSalidaMateriales = dlf.IdComprobante and dlf.IdTipoComprobante=50
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
LEFT OUTER JOIN GastosFletes ON GastosFletes.IdGastoFlete = dlf.IdComprobante and dlf.IdTipoComprobante=120
LEFT OUTER JOIN Fletes ON Fletes.IdFlete = IsNull(Recepciones.IdFlete,IsNull(SalidasMateriales.IdFlete,IsNull(dsm.IdFlete,IsNull(GastosFletes.IdFlete,0))))
LEFT OUTER JOIN Choferes ON Choferes.IdChofer = IsNull(Recepciones.IdChofer,SalidasMateriales.IdChofer)
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = IsNull(dr.IdArticulo,IsNull(dsm.IdArticulo,IsNull(GastosFletes.IdConcepto,0)))
LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete = dlf.IdTarifaFlete
LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad = IsNull(dr.IdUnidad,dsm.IdUnidad)
LEFT OUTER JOIN Unidades U2 ON U2.IdUnidad = TarifasFletes.IdUnidad
LEFT OUTER JOIN Pesadas ON Pesadas.IdPesada = IsNull(Recepciones.IdPesada,IsNull(SalidasMateriales.IdPesada,0)) and Pesadas.IdOrigenTransmision = IsNull(Recepciones.IdOrigenTransmision,IsNull(SalidasMateriales.IdOrigenTransmision,0))
LEFT OUTER JOIN DetallePedidos ON Pesadas.IdDetallePedido = DetallePedidos.IdDetallePedidoLEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = IsNull(dr.IdUsuarioDioPorCumplidoLiquidacionFletes,dsm.IdUsuarioDioPorCumplidoLiquidacionFletes)
LEFT OUTER JOIN Obras ON Obras.IdObra = IsNull(dr.IdObra,IsNull(dsm.IdObra,0))
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion = IsNull(dr.IdUbicacion,IsNull(dsm.IdUbicacion,0))
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Ubicaciones.IdDeposito
WHERE (@IdLiquidacionFlete<=0 or dlf.IdLiquidacionFlete = @IdLiquidacionFlete) and 
	(@Tipo='*' or 
	 (@Tipo='V' and (Recepciones.IdRecepcion is not null or SalidasMateriales.IdFlete is not null or (GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=1))) or 
	 (@Tipo='D' and (dsm.IdFlete is not null or (GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=-1))))