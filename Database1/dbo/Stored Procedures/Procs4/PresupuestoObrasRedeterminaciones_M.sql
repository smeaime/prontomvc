CREATE  Procedure [dbo].[PresupuestoObrasRedeterminaciones_M]

@IdPresupuestoObraRedeterminacion int ,
@IdObra Int,
@Fecha datetime,
@NumeroCertificado int,
@Importe numeric(18,2),
@Año int,
@Mes int,
@IdPresupuestoObrasNodo int,
@Observaciones ntext

AS

UPDATE PresupuestoObrasRedeterminaciones
SET
 IdObra=@IdObra,
 Fecha=@Fecha,
 NumeroCertificado=@NumeroCertificado,
 Importe=@Importe,
 Año=@Año,
 Mes=@Mes,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 Observaciones=@Observaciones
WHERE (IdPresupuestoObraRedeterminacion=@IdPresupuestoObraRedeterminacion)

RETURN(@IdPresupuestoObraRedeterminacion)