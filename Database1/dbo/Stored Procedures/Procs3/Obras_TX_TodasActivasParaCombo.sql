CREATE Procedure [dbo].[Obras_TX_TodasActivasParaCombo]

@ControlarFechas varchar(2) = Null,
@Fecha datetime = Null, 
@EsPlantaDeProduccionInterna varchar(2) = Null,
@ActivarPresupuestoObra varchar(2) = Null,
@IdUsuario int = Null

AS 

SET @ControlarFechas=IsNull(@ControlarFechas,'')
SET @Fecha=IsNull(@Fecha,0)
SET @EsPlantaDeProduccionInterna=IsNull(@EsPlantaDeProduccionInterna,'')
SET @ActivarPresupuestoObra=IsNull(@ActivarPresupuestoObra,'')
SET @IdUsuario=IsNull(@IdUsuario,-1)

SELECT IdObra, NumeroObra+' - '+Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS+' ('+NumeroObra+')' as [Titulo]
FROM Obras
WHERE IsNull(Obras.Activa,'SI')='SI' and 
	(IsNull(@ControlarFechas,'NO')<>'SI' or (IsNull(@ControlarFechas,'NO')='SI' and IsNull(Obras.FechaEntrega,@Fecha)>=@Fecha and IsNull(Obras.FechaInicio,@Fecha)<=@Fecha)) and 
	(@EsPlantaDeProduccionInterna='' or 
	 (@EsPlantaDeProduccionInterna='SI' and IsNull(AuxiliarDeMateriales,'')<>'SI' and (IsNull(EsPlantaDeProduccionInterna,'')='SI' or IsNull(EsPlantaDeProduccionInterna,'')='AU')) or 
	 (@EsPlantaDeProduccionInterna='NO' and IsNull(EsPlantaDeProduccionInterna,'')='')) and 
	(@ActivarPresupuestoObra='' or IsNull(ActivarPresupuestoObra,'')=@ActivarPresupuestoObra) and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Obras.IdObra))
ORDER BY NumeroObra