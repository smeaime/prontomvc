CREATE Procedure [dbo].[Requerimientos_A]

@IdRequerimiento int  output,
@NumeroRequerimiento int,
@FechaRequerimiento datetime,
@LugarEntrega ntext,
@Observaciones ntext,
@IdObra int,
@IdCentroCosto int,
@IdSolicito int,
@IdSector int,
@MontoPrevisto numeric(12,2),
@IdComprador int,
@Aprobo int,
@FechaAprobacion datetime,
@MontoParaCompra numeric(12,2),
@Cumplido varchar(2),
@Consorcial varchar(2),
@UsuarioAnulacion varchar(6),
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@EnviarEmail tinyint,
@IdRequerimientoOriginal int,
@IdOrigenTransmision int,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@IdMoneda int,
@Detalle varchar(50),
@DirectoACompras varchar(2),
@IdAutorizoDirectoACompras int,
@PRESTOContrato varchar(13),
@Confirmado varchar(2),
@FechaImportacionTransmision datetime,
@IdEquipoDestino int,
@Impresa varchar(2),
@Recepcionado varchar(2),
@Entregado varchar(2),
@TipoRequerimiento varchar(2),
@IdOrdenTrabajo int,
@Aprobo2 int,
@FechaAprobacion2 datetime,
@IdTipoCompra int,
@IdImporto int,
@FechaLlegadaImportacion datetime,
@CircuitoFirmasCompleto varchar(2),
@IdCuentaPresupuesto int,
@MesPresupuesto int,
@RequisitosSeguridad ntext,
@Adjuntos varchar(2),
@ConfirmadoPorWeb varchar(2),
@DetalleImputacion varchar(50),
@IdUsuarioDeslibero int,
@FechaDesliberacion datetime,
@NumeradorDesliberaciones int,
@IdUsuarioEliminoFirmas int, 
@FechaEliminacionFirmas datetime, 
@NumeradorEliminacionesFirmas int,
@NumeradorModificaciones int,
@ParaTaller varchar(2),
@FechasLiberacion varchar(100),
@Presupuestos varchar(100),
@Comparativas varchar(100),
@Pedidos varchar(100),
@Recepciones varchar(100),
@SalidasMateriales varchar(100)

AS

BEGIN TRAN

IF @IdOrigenTransmision IS NULL 
   BEGIN
	SET @NumeroRequerimiento=IsNull((Select Top 1 ProximoNumeroRequerimiento From Parametros Where IdParametro=1),1)

	UPDATE Parametros
	SET ProximoNumeroRequerimiento=@NumeroRequerimiento+1
   END

IF IsNull(@Aprobo,0)>0 and IsNull(@CircuitoFirmasCompleto,'')<>'SI'
   BEGIN
	DECLARE @GrupoObraParaFirmas integer, @GrupoObraActual integer, @ObrasALaFirma varchar(1000), @ModalidadesTiposCompraSinFirma varchar(50), @Modalidad varchar(2)
	
	SET @GrupoObraParaFirmas=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Grupo de obra para firma obligatoria'),0)
	SET @ObrasALaFirma=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Ids de obras para firma obligatoria'),'')
	SET @GrupoObraActual=Isnull((Select Top 1 IdGrupoObra From Obras Where IdObra=@IdObra),0)
	IF (IsNull(@TipoRequerimiento,'')='OP' or IsNull(@TipoRequerimiento,'')='OT') and @GrupoObraParaFirmas>0 and @GrupoObraActual<>@GrupoObraParaFirmas and Patindex('%('+Convert(varchar,@IdObra)+')%', @ObrasALaFirma)=0
		SET @CircuitoFirmasCompleto='SI'

	SET @ModalidadesTiposCompraSinFirma=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
							Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
							Where pic.Clave='Modalidad tipo de compra en RM sin circuito de firma'),'')
	SET @Modalidad=IsNull((Select Top 1 Modalidad From TiposCompra Where IdTipoCompra=@IdTipoCompra),'')
	IF Len(@ModalidadesTiposCompraSinFirma)>0 and Patindex('%('+Convert(varchar,@Modalidad)+')%', @ModalidadesTiposCompraSinFirma)>0
		SET @CircuitoFirmasCompleto='SI'
   END

INSERT INTO Requerimientos
(
 NumeroRequerimiento,
 FechaRequerimiento,
 LugarEntrega,
 Observaciones,
 IdObra,
 IdCentroCosto,
 IdSolicito,
 IdSector,
 MontoPrevisto,
 IdComprador,
 Aprobo,
 FechaAprobacion,
 MontoParaCompra,
 Cumplido,
 Consorcial,
 UsuarioAnulacion,
 FechaAnulacion,
 MotivoAnulacion,
 EnviarEmail,
 IdRequerimientoOriginal,
 IdOrigenTransmision,
 IdAutorizoCumplido,
 IdDioPorCumplido,
 FechaDadoPorCumplido,
 ObservacionesCumplido,
 IdMoneda,
 Detalle,
 DirectoACompras,
 IdAutorizoDirectoACompras,
 PRESTOContrato,
 Confirmado,
 FechaImportacionTransmision,
 IdEquipoDestino,
 Impresa,
 Recepcionado,
 Entregado,
 TipoRequerimiento,
 IdOrdenTrabajo,
 Aprobo2,
 FechaAprobacion2,
 IdTipoCompra,
 IdImporto,
 FechaLlegadaImportacion,
 CircuitoFirmasCompleto,
 IdCuentaPresupuesto,
 MesPresupuesto,
 RequisitosSeguridad,
 Adjuntos,
 ConfirmadoPorWeb,
 DetalleImputacion,
 IdUsuarioDeslibero,
 FechaDesliberacion,
 NumeradorDesliberaciones,
 IdUsuarioEliminoFirmas, 
 FechaEliminacionFirmas, 
 NumeradorEliminacionesFirmas,
 NumeradorModificaciones,
 ParaTaller,
 FechasLiberacion,
 Presupuestos,
 Comparativas,
 Pedidos,
 Recepciones,
 SalidasMateriales
)
VALUES
(
 @NumeroRequerimiento,
 @FechaRequerimiento,
 @LugarEntrega,
 @Observaciones,
 @IdObra,
 @IdCentroCosto,
 @IdSolicito,
 @IdSector,
 @MontoPrevisto,
 @IdComprador,
 @Aprobo,
 @FechaAprobacion,
 @MontoParaCompra,
 @Cumplido,
 @Consorcial,
 @UsuarioAnulacion,
 @FechaAnulacion,
 @MotivoAnulacion,
 @EnviarEmail,
 @IdRequerimientoOriginal,
 @IdOrigenTransmision,
 @IdAutorizoCumplido,
 @IdDioPorCumplido,
 @FechaDadoPorCumplido,
 @ObservacionesCumplido,
 @IdMoneda,
 @Detalle,
 @DirectoACompras,
 @IdAutorizoDirectoACompras,
 @PRESTOContrato,
 @Confirmado,
 @FechaImportacionTransmision,
 @IdEquipoDestino,
 @Impresa,
 @Recepcionado,
 @Entregado,
 @TipoRequerimiento,
 @IdOrdenTrabajo,
 @Aprobo2,
 @FechaAprobacion2,
 @IdTipoCompra,
 @IdImporto,
 @FechaLlegadaImportacion,
 @CircuitoFirmasCompleto,
 @IdCuentaPresupuesto,
 @MesPresupuesto,
 @RequisitosSeguridad,
 @Adjuntos,
 @ConfirmadoPorWeb,
 @DetalleImputacion,
 @IdUsuarioDeslibero,
 @FechaDesliberacion,
 @NumeradorDesliberaciones,
 @IdUsuarioEliminoFirmas, 
 @FechaEliminacionFirmas, 
 @NumeradorEliminacionesFirmas,
 @NumeradorModificaciones,
 @ParaTaller,
 @FechasLiberacion,
 @Presupuestos,
 @Comparativas,
 @Pedidos,
 @Recepciones,
 @SalidasMateriales
)

SELECT @IdRequerimiento=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdRequerimiento)