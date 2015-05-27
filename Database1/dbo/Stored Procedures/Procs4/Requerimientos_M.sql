CREATE Procedure [dbo].[Requerimientos_M]

@IdRequerimiento int,
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

SET NOCOUNT ON

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

SET NOCOUNT OFF

UPDATE Requerimientos
SET 
 NumeroRequerimiento=@NumeroRequerimiento,
 FechaRequerimiento=@FechaRequerimiento,
 LugarEntrega=@LugarEntrega,
 Observaciones=@Observaciones,
 IdObra=@IdObra,
 IdCentroCosto=@IdCentroCosto,
 IdSolicito=@IdSolicito,
 IdSector=@IdSector,
 MontoPrevisto=@MontoPrevisto,
 IdComprador=@IdComprador,
 Aprobo=@Aprobo,
 FechaAprobacion=@FechaAprobacion,
 MontoParaCompra=@MontoParaCompra,
 Cumplido=@Cumplido,
 Consorcial=@Consorcial,
 UsuarioAnulacion=@UsuarioAnulacion,
 FechaAnulacion=@FechaAnulacion,
 MotivoAnulacion=@MotivoAnulacion,
 EnviarEmail=@EnviarEmail,
 IdRequerimientoOriginal=@IdRequerimientoOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdAutorizoCumplido=@IdAutorizoCumplido,
 IdDioPorCumplido=@IdDioPorCumplido,
 FechaDadoPorCumplido=@FechaDadoPorCumplido,
 ObservacionesCumplido=@ObservacionesCumplido,
 IdMoneda=@IdMoneda,
 Detalle=@Detalle,
 DirectoACompras=@DirectoACompras,
 IdAutorizoDirectoACompras=@IdAutorizoDirectoACompras,
 PRESTOContrato=@PRESTOContrato,
 Confirmado=@Confirmado,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 IdEquipoDestino=@IdEquipoDestino,
-- Impresa=@Impresa
 Recepcionado=@Recepcionado,
 Entregado=@Entregado,
 TipoRequerimiento=@TipoRequerimiento,
 IdOrdenTrabajo=@IdOrdenTrabajo,
 Aprobo2=@Aprobo2,
 FechaAprobacion2=@FechaAprobacion2,
 IdTipoCompra=@IdTipoCompra,
 IdImporto=@IdImporto,
 FechaLlegadaImportacion=@FechaLlegadaImportacion,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 IdCuentaPresupuesto=@IdCuentaPresupuesto,
 MesPresupuesto=@MesPresupuesto,
 RequisitosSeguridad=@RequisitosSeguridad,
 Adjuntos=@Adjuntos,
 ConfirmadoPorWeb=@ConfirmadoPorWeb,
 DetalleImputacion=@DetalleImputacion,
 IdUsuarioDeslibero=@IdUsuarioDeslibero,
 FechaDesliberacion=@FechaDesliberacion,
 NumeradorDesliberaciones=@NumeradorDesliberaciones, 
 IdUsuarioEliminoFirmas=@IdUsuarioEliminoFirmas,
 FechaEliminacionFirmas=@FechaEliminacionFirmas,
 NumeradorEliminacionesFirmas=@NumeradorEliminacionesFirmas,
 NumeradorModificaciones=IsNull(@NumeradorModificaciones,0)+1,
 ParaTaller=@ParaTaller,
 FechasLiberacion=@FechasLiberacion,
 Presupuestos=@Presupuestos,
 Comparativas=@Comparativas,
 Pedidos=@Pedidos,
 Recepciones=@Recepciones,
 SalidasMateriales=@SalidasMateriales
WHERE (IdRequerimiento=@IdRequerimiento)

RETURN(@IdRequerimiento)