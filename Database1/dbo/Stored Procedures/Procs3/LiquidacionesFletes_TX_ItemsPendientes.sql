CREATE  Procedure [dbo].[LiquidacionesFletes_TX_ItemsPendientes]

@IdTransportista int = Null,
@IdFlete int = Null, 
@SoloPesadas varchar(2) = Null,
@SoloPendiente varchar(2) = Null,
@FechaInicial datetime = Null,
@FechaFinal datetime = Null,
@NumeroLiquidacion int = Null

AS 

SET NOCOUNT ON

SET @IdTransportista=IsNull(@IdTransportista,-1)
SET @IdFlete=IsNull(@IdFlete,-1)
SET @SoloPesadas=IsNull(@SoloPesadas,'NO')
SET @SoloPendiente=IsNull(@SoloPendiente,'SI')
SET @FechaInicial=IsNull(@FechaInicial,0)
SET @FechaFinal=IsNull(@FechaFinal,0)
SET @NumeroLiquidacion=IsNull(@NumeroLiquidacion,-1)

DECLARE @vector_X varchar(50), @vector_T varchar(50), @PorcentajeIva numeric(18,2)
SET @vector_X='0111111111111111111111111111111111111111111111133'
SET @vector_T='01999999999225F420222D233333524E5EE64422660C04500'

SET @PorcentajeIva=IsNull((Select Top 1 Iva1 From Parametros Where IdParametro=1),0)

SET NOCOUNT OFF

SELECT 
 Recepciones.IdRecepcion as [IdComprobante],
 Transportistas.RazonSocial as [Transportista],
 Recepciones.IdRecepcion as [IdAux1],
 Fletes.IdFlete as [IdAux2],
 Fletes.IdTransportista as [IdAux3],
 '1.RE' as [IdAux4],
 60 as [IdAux5],
 dr.IdDetalleRecepcion as [IdAux6],
 TarifasFletes.IdTarifaFlete as [IdAux7],
 dr.IdArticulo as [IdAux8],
 dr.IdUnidad as [IdAux9],
 Fletes.Descripcion as [Flete],
 Fletes.Patente as [Patente],
 'RECEPCION' as [Tipo],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Numero],
 Recepciones.FechaRecepcion as [Fecha],
 dr.Cantidad as [Cant.],
 U1.Abreviatura as [Un.],
 Recepciones.PesoBruto as [Peso bruto],
 Recepciones.Tara as [Tara],
 Recepciones.PesoNeto as [Peso neto],
 Articulos.Descripcion as [Material],
 Choferes.Nombre as [Chofer],
 Recepciones.CodigoTarifador as [Codigo tarifa],
 IsNull(TarifasFletes.ValorUnitario,0) as [Valor Un. Tarifa],-- * Case When IsNull(Transportistas.IdCodigoIva,1)=1 Then 1 Else (1+(@PorcentajeIva/100)) End as [Valor Un. Tarifa],
 U2.Abreviatura as [Un.Tarifa],
 Case When dr.IdUnidad=IsNull(TarifasFletes.IdUnidad,0) 
	 Then 1
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dr.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)),0)<>0
	 Then (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dr.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0))
	Else Null
 End as [Equiv.Unidades],
 Case When dr.IdUnidad=IsNull(TarifasFletes.IdUnidad,0) 
	 Then dr.Cantidad * IsNull(TarifasFletes.ValorUnitario,0)
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dr.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)),0)<>0
	 Then dr.Cantidad * (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dr.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)) * IsNull(TarifasFletes.ValorUnitario,0) 
	Else Null
 End as [Tarifa],-- * Case When IsNull(Transportistas.IdCodigoIva,1)=1 Then 1 Else (1+(@PorcentajeIva/100)) End as [Tarifa],
 LiquidacionesFletes.NumeroLiquidacion as [Nro.Liquidacion],
 Null as [Detalle gasto],
 Recepciones.FechaPesada as [Fecha pesada],
 Recepciones.ObservacionesPesada as [Observaciones pesada],
 Recepciones.NumeroPesada as [Numero pesada],
 Case When Len(Pesadas.RemitoMaterial)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoMaterial,0))))+Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) Else Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoMaterial2)))+Convert(varchar,Pesadas.RemitoMaterial2) as [Remito pesada],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte1,0))))+Convert(varchar,IsNull(Recepciones.NumeroRemitoTransporte1,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRemitoTransporte2)))+Convert(varchar,Recepciones.NumeroRemitoTransporte2) as [Remito transporte],
 Pesadas.NumeroOrdenCarga as [Nro. orden carga],
 Pesadas.CantidadEnOrigen as [Cant. en origen],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then Pesadas.CantidadSegunRemitoMasCoefEnKg Else Pesadas.PesoNeto End as [Valor aceptado Kg],
 Pesadas.Progresiva1 as [Progresiva 1],
 Pesadas.Progresiva2 as [Progresiva 2],
 Case When IsNull(Pesadas.TaraIngresadaManualmente,'')='SI' or IsNull(Pesadas.PesoBrutoIngresadoManualmente,'')='SI' Then 'SI' Else '' End as [Ingreso manual],
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
 Empleados.Nombre as [Dio por cumplido],
 dr.FechaDioPorCumplidoLiquidacionFletes as [Fecha dio por cumplido],
 dr.ObservacionDioPorCumplidoLiquidacionFletes as [Observacion dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones dr
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = dr.IdRecepcion
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = dr.IdArticulo
LEFT OUTER JOIN Fletes ON Fletes.IdFlete = Recepciones.IdFlete
LEFT OUTER JOIN Choferes ON Choferes.IdChofer = Recepciones.IdChofer
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = Fletes.IdTransportista
LEFT OUTER JOIN TarifasFletes ON TarifasFletes.Codigo = IsNull(Recepciones.CodigoTarifador,'')
LEFT OUTER JOIN DetalleLiquidacionesFletes dlf ON dlf.IdDetalleLiquidacionFlete = dr.IdDetalleLiquidacionFlete
LEFT OUTER JOIN LiquidacionesFletes ON LiquidacionesFletes.IdLiquidacionFlete = dlf.IdLiquidacionFlete
LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad = dr.IdUnidad
LEFT OUTER JOIN Unidades U2 ON U2.IdUnidad = TarifasFletes.IdUnidad
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = dr.IdUsuarioDioPorCumplidoLiquidacionFletes
LEFT OUTER JOIN Pesadas ON Pesadas.IdPesada = Recepciones.IdPesada and Pesadas.IdOrigenTransmision = Recepciones.IdOrigenTransmision
LEFT OUTER JOIN DetallePedidos ON Pesadas.IdDetallePedido = DetallePedidos.IdDetallePedidoLEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN Obras ON Obras.IdObra = dr.IdObra
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion = dr.IdUbicacion
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Ubicaciones.IdDeposito
WHERE IsNull(Recepciones.Anulada,'')<>'SI' and Recepciones.IdFlete is not null and 
	(@IdFlete=-1 or Recepciones.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and 
	(@SoloPendiente='NO' or (dr.IdDetalleLiquidacionFlete is null and dr.IdUsuarioDioPorCumplidoLiquidacionFletes is null)) and 
	(@FechaInicial=0 or Recepciones.FechaRecepcion between @FechaInicial and @FechaFinal) and 
	(@NumeroLiquidacion=-1 or IsNull(LiquidacionesFletes.NumeroLiquidacion,0)=@NumeroLiquidacion)

UNION ALL

SELECT 
 SalidasMateriales.IdSalidaMateriales as [IdComprobante],
 Transportistas.RazonSocial as [Transportista],
 SalidasMateriales.IdSalidaMateriales as [IdAux1],
 Fletes.IdFlete as [IdAux2],
 Fletes.IdTransportista as [IdAux3],
 '2.SM' as [IdAux4],
 50 as [IdAux5],
 dsm.IdDetalleSalidaMateriales as [IdAux6],
 TarifasFletes.IdTarifaFlete as [IdAux7],
 dsm.IdArticulo as [IdAux8],
 dsm.IdUnidad as [IdAux9],
 Fletes.Descripcion as [Flete],
 Fletes.Patente as [Patente],
 'SALIDA' as [Tipo],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Numero],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 dsm.Cantidad as [Cant.],
 U1.Abreviatura as [Un.],
 SalidasMateriales.PesoBruto as [Peso bruto],
 SalidasMateriales.Tara as [Tara],
 SalidasMateriales.PesoNeto as [Peso neto],
 Articulos.Descripcion as [Material],
 Choferes.Nombre as [Chofer],
 SalidasMateriales.CodigoTarifador as [Codigo tarifa],
 IsNull(TarifasFletes.ValorUnitario,0) as [Valor Un. Tarifa], /* * Case When IsNull(Transportistas.IdCodigoIva,1)=1 Then 1 Else (1+(@PorcentajeIva/100)) End as [Valor Un. Tarifa],*/ U2.Abreviatura as [Un.Tarifa],
 Case When dsm.IdUnidad=IsNull(TarifasFletes.IdUnidad,0) 
	 Then 1
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)),0)<>0
	 Then (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0))
	Else Null
 End as [Equiv.Unidades],
 Case When dsm.IdUnidad=IsNull(TarifasFletes.IdUnidad,0) 
	 Then dsm.Cantidad * IsNull(TarifasFletes.ValorUnitario,0)
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)),0)<>0
	 Then dsm.Cantidad * (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=IsNull(TarifasFletes.IdUnidad,0)) * IsNull(TarifasFletes.ValorUnitario,0) 
	Else Null
 End as [Tarifa],-- * Case When IsNull(Transportistas.IdCodigoIva,1)=1 Then 1 Else (1+(@PorcentajeIva/100)) End as [Tarifa],
 LiquidacionesFletes.NumeroLiquidacion as [Nro.Liquidacion],
 Null as [Detalle gasto],
 SalidasMateriales.FechaPesada as [Fecha pesada],
 SalidasMateriales.ObservacionesPesada as [Observaciones pesada],
 SalidasMateriales.NumeroPesada as [Numero pesada],
 Case When Len(Pesadas.RemitoMaterial)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoMaterial,0))))+Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) Else Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoMaterial2)))+Convert(varchar,Pesadas.RemitoMaterial2) as [Remito pesada],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoTransporte1,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoTransporte1,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroRemitoTransporte2)))+Convert(varchar,SalidasMateriales.NumeroRemitoTransporte2) as [Remito transporte],
 Pesadas.NumeroOrdenCarga as [Nro. orden carga],
 Pesadas.CantidadEnOrigen as [Cant. en origen],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then Pesadas.CantidadSegunRemitoMasCoefEnKg Else Pesadas.PesoNeto End as [Valor aceptado Kg],
 Pesadas.Progresiva1 as [Progresiva 1],
 Pesadas.Progresiva2 as [Progresiva 2],
 Case When IsNull(Pesadas.TaraIngresadaManualmente,'')='SI' or IsNull(Pesadas.PesoBrutoIngresadoManualmente,'')='SI' Then 'SI' Else '' End as [Ingreso manual],
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
 Empleados.Nombre as [Dio por cumplido],
 dsm.FechaDioPorCumplidoLiquidacionFletes as [Fecha dio por cumplido],
 dsm.ObservacionDioPorCumplidoLiquidacionFletes as [Observacion dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales dsm
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = dsm.IdArticulo
LEFT OUTER JOIN Fletes ON Fletes.IdFlete = SalidasMateriales.IdFlete
LEFT OUTER JOIN Choferes ON Choferes.IdChofer = SalidasMateriales.IdChofer
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = Fletes.IdTransportista
LEFT OUTER JOIN TarifasFletes ON TarifasFletes.Codigo = IsNull(SalidasMateriales.CodigoTarifador,'')
LEFT OUTER JOIN DetalleLiquidacionesFletes dlf ON dlf.IdDetalleLiquidacionFlete = dsm.IdDetalleLiquidacionFlete
LEFT OUTER JOIN LiquidacionesFletes ON LiquidacionesFletes.IdLiquidacionFlete = dlf.IdLiquidacionFlete
LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad = dsm.IdUnidad
LEFT OUTER JOIN Unidades U2 ON U2.IdUnidad = TarifasFletes.IdUnidad
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = dsm.IdUsuarioDioPorCumplidoLiquidacionFletes
LEFT OUTER JOIN Pesadas ON Pesadas.IdPesada = SalidasMateriales.IdPesada and Pesadas.IdOrigenTransmision = SalidasMateriales.IdOrigenTransmision
LEFT OUTER JOIN DetallePedidos ON Pesadas.IdDetallePedido = DetallePedidos.IdDetallePedidoLEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN Obras ON Obras.IdObra = dsm.IdObra
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion = dsm.IdUbicacion
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Ubicaciones.IdDeposito
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI'  and SalidasMateriales.IdFlete is not null and 
	(@IdFlete=-1 or SalidasMateriales.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and 
	(@SoloPendiente='NO' or (dsm.IdDetalleLiquidacionFlete is null and dsm.IdUsuarioDioPorCumplidoLiquidacionFletes is null)) and 
	(@FechaInicial=0 or SalidasMateriales.FechaSalidaMateriales between @FechaInicial and @FechaFinal) and 
	(@NumeroLiquidacion=-1 or IsNull(LiquidacionesFletes.NumeroLiquidacion,0)=@NumeroLiquidacion)

UNION ALL
SELECT 
 dsm.IdDetalleSalidaMateriales as [IdComprobante],
 Transportistas.RazonSocial as [Transportista],
 SalidasMateriales.IdSalidaMateriales as [IdAux1],
 Fletes.IdFlete as [IdAux2],
 Fletes.IdTransportista as [IdAux3],
 '3.CS' as [IdAux4],
 50 as [IdAux5],
 dsm.IdDetalleSalidaMateriales as [IdAux6],
 Null as [IdAux7],
 dsm.IdArticulo as [IdAux8],
 dsm.IdUnidad as [IdAux9],
 Fletes.Descripcion as [Flete],
 Fletes.Patente as [Patente],
 'CONSUMO' as [Tipo],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Numero],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 dsm.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 SalidasMateriales.PesoBruto as [Peso bruto],
 SalidasMateriales.Tara as [Tara],
 SalidasMateriales.PesoNeto as [Peso neto],
 Articulos.Descripcion as [Material],
 Choferes.Nombre as [Chofer],
 Null as [Codigo tarifa],
 IsNull(Case When IsNull(Transportistas.IdCodigoIva,0)=1 Then Articulos.AuxiliarNumerico1 Else Articulos.AuxiliarNumerico2 End,0) as [Valor Un. Tarifa],
 Null as [Un.Tarifa],
 Null as [Equiv.Unidades],
 Case When dsm.IdUnidad=IsNull(Articulos.IdUnidad,0) 
	 Then dsm.Cantidad * IsNull(Case When IsNull(Transportistas.IdCodigoIva,0)=1 Then Articulos.AuxiliarNumerico1 Else Articulos.AuxiliarNumerico2 End,0) * -1
	When IsNull((Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=dsm.IdUnidad),0)<>0
	 Then dsm.Cantidad * (Select Top 1 dau.Equivalencia From DetalleArticulosUnidades dau Where dau.IdArticulo=dsm.IdArticulo and dau.IdUnidad=dsm.IdUnidad) * 
		IsNull(Case When IsNull(Transportistas.IdCodigoIva,0)=1 Then Articulos.AuxiliarNumerico1 Else Articulos.AuxiliarNumerico2 End,0) * -1
	Else Null
 End as [Tarifa],
 LiquidacionesFletes.NumeroLiquidacion as [Nro.Liquidacion],
 Null as [Detalle gasto],
 SalidasMateriales.FechaPesada as [Fecha pesada],
 SalidasMateriales.ObservacionesPesada as [Observaciones pesada],
 SalidasMateriales.NumeroPesada as [Numero pesada],
 Case When Len(Pesadas.RemitoMaterial)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoMaterial,0))))+Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) Else Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoMaterial2)))+Convert(varchar,Pesadas.RemitoMaterial2) as [Remito pesada],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoTransporte1,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoTransporte1,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroRemitoTransporte2)))+Convert(varchar,SalidasMateriales.NumeroRemitoTransporte2) as [Remito transporte],
 Pesadas.NumeroOrdenCarga as [Nro. orden carga],
 Pesadas.CantidadEnOrigen as [Cant. en origen],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then Pesadas.CantidadSegunRemitoMasCoefEnKg Else  Pesadas.PesoNeto End as [Valor aceptado Kg],
 Pesadas.Progresiva1 as [Progresiva 1],
 Pesadas.Progresiva2 as [Progresiva 2],
 Case When IsNull(Pesadas.TaraIngresadaManualmente,'')='SI' or IsNull(Pesadas.PesoBrutoIngresadoManualmente,'')='SI' Then 'SI' Else '' End as [Ingreso manual],
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
 Empleados.Nombre as [Dio por cumplido],
 dsm.FechaDioPorCumplidoLiquidacionFletes as [Fecha dio por cumplido],
 dsm.ObservacionDioPorCumplidoLiquidacionFletes as [Observacion dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales dsm
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = dsm.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = dsm.IdUnidad
LEFT OUTER JOIN Fletes ON Fletes.IdFlete = dsm.IdFlete
LEFT OUTER JOIN Choferes ON Choferes.IdChofer = SalidasMateriales.IdChofer
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = Fletes.IdTransportista
LEFT OUTER JOIN DetalleLiquidacionesFletes dlf ON dlf.IdDetalleLiquidacionFlete = dsm.IdDetalleLiquidacionFlete
LEFT OUTER JOIN LiquidacionesFletes ON LiquidacionesFletes.IdLiquidacionFlete = dlf.IdLiquidacionFlete
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = dsm.IdUsuarioDioPorCumplidoLiquidacionFletes
LEFT OUTER JOIN Pesadas ON Pesadas.IdPesada = SalidasMateriales.IdPesada and Pesadas.IdOrigenTransmision = SalidasMateriales.IdOrigenTransmision
LEFT OUTER JOIN DetallePedidos ON Pesadas.IdDetallePedido = DetallePedidos.IdDetallePedidoLEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN Obras ON Obras.IdObra = dsm.IdObra
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion = dsm.IdUbicacion
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Ubicaciones.IdDeposito
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and dsm.IdFlete is not null and 
	(@IdFlete=-1 or dsm.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and @SoloPesadas<>'SI' and 
	(@SoloPendiente='NO' or (dsm.IdDetalleLiquidacionFlete is null and dsm.IdUsuarioDioPorCumplidoLiquidacionFletes is null)) and 
	(@FechaInicial=0 or SalidasMateriales.FechaSalidaMateriales between @FechaInicial and @FechaFinal) and 
	(@NumeroLiquidacion=-1 or IsNull(LiquidacionesFletes.NumeroLiquidacion,0)=@NumeroLiquidacion)

UNION ALL

SELECT 
 GastosFletes.IdGastoFlete as [IdComprobante],
 Transportistas.RazonSocial as [Transportista],
 GastosFletes.IdGastoFlete as [IdAux1],
 Fletes.IdFlete as [IdAux2],
 Fletes.IdTransportista as [IdAux3],
 '4.GF' as [IdAux4],
 120 as [IdAux5],
 GastosFletes.IdGastoFlete as [IdAux6],
 Null as [IdAux7],
 GastosFletes.IdConcepto as [IdAux8],
 Null as [IdAux9],
 Fletes.Descripcion as [Flete],
 Fletes.Patente as [Patente],
 'GASTO FLETE' as [Tipo],
 Null as [Numero],
 GastosFletes.Fecha as [Fecha],
 Null as [Cant.],
 Null as [Un.],
 Null as [Peso bruto],
 Null as [Tara],
 Null as [Peso neto],
 Articulos.Descripcion as [Material],
 Null as [Chofer],
 Null as [Codigo tarifa],
 Null as [Valor Un. Tarifa],
 Null as [Un.Tarifa],
 Null as [Equiv.Unidades],
 GastosFletes.Importe*IsNull(GastosFletes.SumaResta,1) as [Tarifa],
 LiquidacionesFletes.NumeroLiquidacion as [Nro.Liquidacion],
 GastosFletes.Detalle as [Detalle gasto],
 Null as [Fecha pesada],
 Null as [Observaciones pesada],
 Null as [Numero pesada],
 Null as [Remito pesada],
 Null as [Remito transporte],
 Null as [Nro. orden carga],
 Null as [Cant. en origen],
 Null as [Valor aceptado Kg],
 Null as [Progresiva 1],
 Null as [Progresiva 2],
 Null as [Ingreso manual],
 Null as [Obra],
 Null as [Ubicacion],
 Null as [Pedido],
 Empleados.Nombre as [Dio por cumplido],
 GastosFletes.FechaDioPorCumplidoLiquidacionFletes as [Fecha dio por cumplido],
 GastosFletes.ObservacionDioPorCumplidoLiquidacionFletes as [Observacion dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM GastosFletes
LEFT OUTER JOIN Fletes ON Fletes.IdFlete = GastosFletes.IdFlete
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = GastosFletes.IdConcepto
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = Fletes.IdTransportista
LEFT OUTER JOIN DetalleLiquidacionesFletes dlf ON dlf.IdDetalleLiquidacionFlete = GastosFletes.IdDetalleLiquidacionFlete
LEFT OUTER JOIN LiquidacionesFletes ON LiquidacionesFletes.IdLiquidacionFlete = dlf.IdLiquidacionFlete
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = GastosFletes.IdUsuarioDioPorCumplidoLiquidacionFletes
WHERE GastosFletes.IdFlete is not null and (@IdFlete=-1 or GastosFletes.IdFlete=@IdFlete) and (@IdTransportista=-1 or Fletes.IdTransportista=@IdTransportista) and @SoloPesadas<>'SI' and 
	(@SoloPendiente='NO' or (GastosFletes.IdDetalleLiquidacionFlete is null and GastosFletes.IdUsuarioDioPorCumplidoLiquidacionFletes is null)) and 
	(@FechaInicial=0 or GastosFletes.Fecha between @FechaInicial and @FechaFinal) and 
	(@NumeroLiquidacion=-1 or IsNull(LiquidacionesFletes.NumeroLiquidacion,0)=@NumeroLiquidacion)

ORDER BY [Transportista], [IdAux4], [Patente], [Fecha], [Numero]