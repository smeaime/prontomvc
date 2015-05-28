CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_A]

@IdPresupuestoObraRedeterminacion int  output,
@IdObra int,
@Fecha datetime,
@NumeroCertificado int,
@Importe numeric(18,2),
@Año int,
@Mes int,
@IdPresupuestoObrasNodo int,
@Observaciones ntext

AS 

INSERT INTO [PresupuestoObrasRedeterminaciones]
(
 IdObra,
 Fecha,
 NumeroCertificado,
 Importe,
 Año,
 Mes,
 IdPresupuestoObrasNodo,
 Observaciones
)
VALUES
(
 @IdObra,
 @Fecha,
 @NumeroCertificado,
 @Importe,
 @Año,
 @Mes,
 @IdPresupuestoObrasNodo,
 @Observaciones
)

SELECT @IdPresupuestoObraRedeterminacion=@@identity

RETURN(@IdPresupuestoObraRedeterminacion)