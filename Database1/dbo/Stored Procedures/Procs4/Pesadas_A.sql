﻿
CREATE Procedure [dbo].[Pesadas_A]

@IdPesada  int output,
@NumeroPesada int,
@IdUsuarioIngreso int ,
@FechaIngreso datetime ,
@Anulada varchar(2) ,
@IdUsuarioAnulo int ,
@FechaAnulacion datetime ,
@Observaciones varchar(200) ,
@IdArticulo int  ,
@IdStock int ,
@Partida varchar(20),
@IdUnidad int,
@IdUbicacion int ,
@Cantidad numeric(12,2) ,
@PesoBruto numeric(18,2) ,
@PesoNeto numeric(18,2) ,
@Tara numeric(18,2) ,
@Chofer int , --id?
@TxtChofer varchar(30) , --mientras no haya id
@IdCamion int , -- id?
@TxtCamion varchar(30) ,	
@IdTransportista int , --id? SÃ­, el pronto tiene tabla de transportistas
@IdProveedor int ,
@IdCliente int ,
@IdObra int ,
@RemitoMaterial int ,
@RemitoTransportista int,
@CantidadEnOrigen numeric(12,2) ,
@PesoBrutoIngresadoManualmente varchar(2),
@TaraIngresadaManualmente varchar(2),
@Tipo varchar(15),
@IdSalidaMateriales int,
@IdOtroIngresoAlmacen int,
@IdRecepcion int,
@IdRemito int,
@NetoEquivalente  numeric(12,2) ,
@IdChofer int,
@IdFlete int,
@RemitoTransportista2 int,
@DistanciaRecorrida numeric(18,2),
@CodigoTarifador varchar(10),
@RemitoMaterial2 int,
@NumeroOrdenCarga int,
@Patente varchar(10),
@IdDetallePedido int,
@IdTarifaFlete int,
@TarifaFlete numeric(18,2),
@PesadaTara1 numeric(18,2),
@PesadaTara2 numeric(18,2),
@PesadaPesoBruto1 numeric(18,2),
@PesadaPesoBruto2 numeric(18,2),
@TipoMovimiento varchar(1),
@IdOrdenCarga int,
@CoeficienteAKilos numeric(18,6),
@FechaUltimaPesada datetime,
@IdDetalleRequerimiento int,
@CoeficienteControlPesada numeric(18,2),
@CantidadSegunRemitoMasCoefEnKg numeric(18,2),
@TomarPesadaORemito varchar(1),
@Progresiva1 numeric(18,2),
@Progresiva2 numeric(18,2),
@IdPesadaOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime

AS 

INSERT INTO [Pesadas]
(
 NumeroPesada ,
 IdUsuarioIngreso  ,
 FechaIngreso  ,
 Anulada  ,
 IdUsuarioAnulo  ,
 FechaAnulacion  ,
 Observaciones  ,
 IdArticulo   ,
 IdStock  ,
 Partida ,
 IdUnidad ,
 IdUbicacion  ,
 Cantidad  ,
 PesoBruto  ,
 PesoNeto  ,
 Tara  ,
 Chofer  , 
 TxtChofer  ,
 IdCamion ,
 TxtCamion  ,	
 IdTransportista  , 
 IdProveedor  ,
 IdCliente  ,
 IdObra  ,
 RemitoMaterial  ,
 RemitoTransportista ,
 CantidadEnOrigen, 
 PesoBrutoIngresadoManualmente,
 TaraIngresadaManualmente,
 Tipo ,
 IdSalidaMateriales ,
 IdOtroIngresoAlmacen ,
 IdRecepcion ,
 IdRemito,
 NetoEquivalente,
 IdChofer,
 IdFlete,
 RemitoTransportista2,
 DistanciaRecorrida,
 CodigoTarifador,
 RemitoMaterial2,
 NumeroOrdenCarga,
 Patente,
 IdDetallePedido,
 IdTarifaFlete,
 TarifaFlete,
 PesadaTara1,
 PesadaTara2,
 PesadaPesoBruto1,
 PesadaPesoBruto2,
 TipoMovimiento,
 IdOrdenCarga,
 CoeficienteAKilos,
 FechaUltimaPesada,
 IdDetalleRequerimiento,
 CoeficienteControlPesada,
 CantidadSegunRemitoMasCoefEnKg,
 TomarPesadaORemito,
 Progresiva1,
 Progresiva2,
 IdPesadaOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision
)
VALUES
(
 @NumeroPesada ,
 @IdUsuarioIngreso  ,
 @FechaIngreso  ,
 @Anulada  ,
 @IdUsuarioAnulo  ,
 @FechaAnulacion  ,
 @Observaciones  ,
 @IdArticulo   ,
 @IdStock  ,
 @Partida ,
 @IdUnidad ,
 @IdUbicacion  ,
 @Cantidad  ,
 @PesoBruto  ,
 @PesoNeto  ,
 @Tara  ,
 @Chofer  , 
 @TxtChofer  ,
 @IdCamion ,
 @TxtCamion  ,	
 @IdTransportista  , 
 @IdProveedor  ,
 @IdCliente  ,
 @IdObra  ,
 @RemitoMaterial  ,
 @RemitoTransportista  ,
 @CantidadEnOrigen , 	
 @PesoBrutoIngresadoManualmente,
 @TaraIngresadaManualmente ,
 @Tipo ,
 @IdSalidaMateriales ,
 @IdOtroIngresoAlmacen ,
 @IdRecepcion ,
 @IdRemito ,
 @NetoEquivalente,
 @IdChofer,
 @IdFlete,
 @RemitoTransportista2,
 @DistanciaRecorrida,
 @CodigoTarifador,
 @RemitoMaterial2,
 @NumeroOrdenCarga,
 @Patente,
 @IdDetallePedido,
 @IdTarifaFlete,
 @TarifaFlete,
 @PesadaTara1,
 @PesadaTara2,
 @PesadaPesoBruto1,
 @PesadaPesoBruto2,
 @TipoMovimiento,
 @IdOrdenCarga,
 @CoeficienteAKilos,
 @FechaUltimaPesada,
 @IdDetalleRequerimiento,
 @CoeficienteControlPesada,
 @CantidadSegunRemitoMasCoefEnKg,
 @TomarPesadaORemito,
 @Progresiva1,
 @Progresiva2,
 @IdPesadaOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision
)

SELECT @IdPesada=@@identity

RETURN(@IdPesada)
