CREATE Procedure [dbo].[SalidasMateriales_A]

@IdSalidaMateriales int  output,
@NumeroSalidaMateriales int,
@FechaSalidaMateriales datetime,
@IdObra int,
@Observaciones ntext,
@Aprobo int,
@TipoSalida int,
@IdTransportista1 int,
@IdTransportista2 int,
@Cliente varchar(100),
@Direccion varchar(50),
@Localidad varchar(50),
@CodigoPostal varchar(30),
@CondicionIva varchar(30),
@Cuit varchar(13),
@NumeroSalidaMateriales2 int,
@ACargo varchar(1),
@Emitio int,
@ValePreimpreso int,
@Referencia varchar(50),
@NumeroDocumento varchar(30),
@Patente1 varchar(25),
@Patente2 varchar(25),
@Patente3 varchar(25),
@Patente4 varchar(25),
@IdProveedor int,
@Chofer varchar(50),
@IdCentroCosto int,
@FechaRegistracion datetime,
@Anulada varchar(2),
@FechaAnulacion datetime,
@IdUsuarioAnulo int,
@EnviarEmail tinyint,
@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@MotivoAnulacion ntext,
@NumeroOrdenProduccion int,
@IdDepositoOrigen int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@IdRecepcionSAT int,
@ClaveTipoSalida varchar(30),
@SalidaADepositoEnTransito varchar(2),
@ValorDeclarado numeric(18,2),
@Bultos int,
@IdColor int,
@Embalo varchar(50),
@CircuitoFirmasCompleto varchar(2),
@IdPuntoVenta int,
@NumeroRemitoTransporte varchar(15),
@IdEquipo int,
@IdSalidaMaterialesSAT int,
@IdObraOrigen int,
@NumeroRemitoPreimpreso1 int,
@NumeroRemitoPreimpreso2 int,
@IdFlete int,
@IdChofer int,
@DestinoDeObra varchar(50),
@PesoBruto numeric(18,2),
@PesoNeto numeric(18,2),
@Tara numeric(18,2),
@CantidadEnOrigen numeric(18,2),
@DistanciaRecorrida numeric(18,2),
@CodigoTarifador varchar(10),
@IdPesada int,
@IdTarifaFlete int,
@TarifaFlete numeric(18,2),
@Detalle varchar(30),
@IdProduccionOrden int,
@IdDepositoIntermedio int,
@NumeroPesada int,
@Progresiva1 numeric(18,2),
@Progresiva2 numeric(18,2),
@FechaPesada datetime,
@ObservacionesPesada varchar(200),
@NumeroRemitoTransporte1 int,
@NumeroRemitoTransporte2 int,
@RecibidosEnDestino varchar(2),
@RecibidosEnDestinoFecha datetime,
@RecibidosEnDestinoIdUsuario int,
@IdCalle1 int,
@IdCalle2 int,
@IdCalle3 int

AS 

BEGIN TRAN

DECLARE @NumeroSalidaMateriales1 int

IF IsNull(@IdPuntoVenta,0)=0 
  BEGIN
	IF @TipoSalida=0 OR @TipoSalida=2
	  BEGIN
		SET @NumeroSalidaMateriales1=IsNull((Select Top 1 ProximoNumeroSalidaMateriales From Parametros Where IdParametro=1),1)
		UPDATE Parametros
		SET ProximoNumeroSalidaMateriales=@NumeroSalidaMateriales1+1
	  END
	IF @TipoSalida=1
	  BEGIN
		SET @NumeroSalidaMateriales1=IsNull((Select Top 1 ProximoNumeroSalidaMaterialesAObra From Parametros Where IdParametro=1),1)
		UPDATE Parametros
		SET ProximoNumeroSalidaMaterialesAObra=@NumeroSalidaMateriales1+1
	  END
	IF @TipoSalida>2
	  BEGIN
		IF EXISTS(Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo=@ClaveTipoSalida + '_1')
			INSERT INTO Parametros2 (Campo,Valor) VALUES (@ClaveTipoSalida + '_1',@NumeroSalidaMateriales2)
		SET @NumeroSalidaMateriales1=1
		IF EXISTS(Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo=@ClaveTipoSalida + '_2')
		   BEGIN
			SET @NumeroSalidaMateriales1=(Select Top 1 Valor From Parametros2 Where Campo=@ClaveTipoSalida + '_2')
			UPDATE Parametros2 SET Valor=@NumeroSalidaMateriales1+1 WHERE Campo=@ClaveTipoSalida + '_2'
		   END
		ELSE
			INSERT INTO Parametros2 (Campo,Valor) VALUES (@ClaveTipoSalida + '_2',2)
	  END
	SET @NumeroSalidaMateriales=@NumeroSalidaMateriales1
  END

INSERT INTO SalidasMateriales
(
 NumeroSalidaMateriales,
 FechaSalidaMateriales,
 IdObra,
 Observaciones,
 Aprobo,
 TipoSalida,
 IdTransportista1,
 IdTransportista2,
 Cliente,
 Direccion,
 Localidad,
 CodigoPostal,
 CondicionIva,
 Cuit,
 NumeroSalidaMateriales2,
 ACargo,
 Emitio,
 ValePreimpreso,
 Referencia,
 NumeroDocumento,
 Patente1,
 Patente2,
 Patente3,
 Patente4,
 IdProveedor,
 Chofer,
 IdCentroCosto,
 FechaRegistracion,
 Anulada,
 FechaAnulacion,
 IdUsuarioAnulo,
 EnviarEmail,
 IdSalidaMaterialesOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision,
 MotivoAnulacion,
 NumeroOrdenProduccion,
 IdDepositoOrigen,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 IdRecepcionSAT,
 ClaveTipoSalida,
 SalidaADepositoEnTransito,
 ValorDeclarado,
 Bultos, 
 IdColor,
 Embalo,
 CircuitoFirmasCompleto,
 IdPuntoVenta,
 NumeroRemitoTransporte,
 IdEquipo,
 IdSalidaMaterialesSAT,
 IdObraOrigen,
 NumeroRemitoPreimpreso1,
 NumeroRemitoPreimpreso2,
 IdFlete,
 IdChofer,
 DestinoDeObra,
 PesoBruto,
 PesoNeto,
 Tara,
 CantidadEnOrigen,
 DistanciaRecorrida,
 CodigoTarifador,
 IdPesada,
 IdTarifaFlete,
 TarifaFlete,
 Detalle,
 IdProduccionOrden,
 IdDepositoIntermedio,
 NumeroPesada,
 Progresiva1,
 Progresiva2,
 FechaPesada,
 ObservacionesPesada,
 NumeroRemitoTransporte1,
 NumeroRemitoTransporte2,
 RecibidosEnDestino,
 RecibidosEnDestinoFecha,
 RecibidosEnDestinoIdUsuario,
 IdCalle1,
 IdCalle2,
 IdCalle3
)
VALUES
(
 @NumeroSalidaMateriales,
 @FechaSalidaMateriales,
 @IdObra,
 @Observaciones,
 @Aprobo,
 @TipoSalida,
 @IdTransportista1,
 @IdTransportista2,
 @Cliente,
 @Direccion,
 @Localidad,
 @CodigoPostal,
 @CondicionIva,
 @Cuit,
 @NumeroSalidaMateriales2,
 @ACargo,
 @Emitio,
 @ValePreimpreso,
 @Referencia,
 @NumeroDocumento,
 @Patente1,
 @Patente2,
 @Patente3,
 @Patente4,
 @IdProveedor,
 @Chofer,
 @IdCentroCosto,
 GetDate(),
 @Anulada,
 @FechaAnulacion,
 @IdUsuarioAnulo,
 @EnviarEmail,
 @IdSalidaMaterialesOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision,
 @MotivoAnulacion,
 @NumeroOrdenProduccion,
 @IdDepositoOrigen,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @IdRecepcionSAT,
 @ClaveTipoSalida,
 @SalidaADepositoEnTransito,
 @ValorDeclarado,
 @Bultos, 
 @IdColor,
 @Embalo,
 @CircuitoFirmasCompleto,
 @IdPuntoVenta,
 @NumeroRemitoTransporte,
 @IdEquipo,
 @IdSalidaMaterialesSAT,
 @IdObraOrigen,
 @NumeroRemitoPreimpreso1,
 @NumeroRemitoPreimpreso2,
 @IdFlete,
 @IdChofer,
 @DestinoDeObra,
 @PesoBruto,
 @PesoNeto,
 @Tara,
 @CantidadEnOrigen,
 @DistanciaRecorrida,
 @CodigoTarifador,
 @IdPesada,
 @IdTarifaFlete,
 @TarifaFlete,
 @Detalle,
 @IdProduccionOrden,
 @IdDepositoIntermedio,
 @NumeroPesada,
 @Progresiva1,
 @Progresiva2,
 @FechaPesada,
 @ObservacionesPesada,
 @NumeroRemitoTransporte1,
 @NumeroRemitoTransporte2,
 @RecibidosEnDestino,
 @RecibidosEnDestinoFecha,
 @RecibidosEnDestinoIdUsuario,
 @IdCalle1,
 @IdCalle2,
 @IdCalle3
)

SELECT @IdSalidaMateriales=@@identity

IF IsNull(@SalidaADepositoEnTransito,'NO')='SI' and Exists(Select Top 1 IdObra From ArchivosATransmitirDestinos Where IsNull(Activo,'SI')='SI' and IsNull(Sistema,'')='SAT' and IdObra=@IdObra)
  BEGIN
	DECLARE @NumeroOtroIngresoAlmacen int, @Salida varchar(20)
	SET @NumeroOtroIngresoAlmacen=IsNull((Select Top 1 ProximoNumeroOtroIngresoAlmacen From Parametros Where IdParametro=1),1)
	UPDATE Parametros
	SET ProximoNumeroOtroIngresoAlmacen=@NumeroOtroIngresoAlmacen+1

	SET @Salida=Substring('0000',1,4-Len(Convert(varchar,IsNull(@NumeroSalidaMateriales2,0))))+
			Convert(varchar,IsNull(@NumeroSalidaMateriales2,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,@NumeroSalidaMateriales)))+
			Convert(varchar,@NumeroSalidaMateriales)

	INSERT INTO OtrosIngresosAlmacen
	(NumeroOtroIngresoAlmacen, FechaOtroIngresoAlmacen, IdObra, Observaciones, Aprobo, TipoIngreso, Emitio, FechaRegistracion, IdSalidaMateriales)
	VALUES 
	(@NumeroOtroIngresoAlmacen, @FechaSalidaMateriales, @IdObra, 'SALIDA '+@Salida, @Aprobo, 4, @Aprobo, GetDate(), @IdSalidaMateriales)
  END

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdSalidaMateriales)