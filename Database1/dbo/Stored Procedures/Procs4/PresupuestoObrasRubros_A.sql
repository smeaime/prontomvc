
CREATE Procedure [dbo].[PresupuestoObrasRubros_A]

@IdPresupuestoObraRubro int  output,
@Descripcion varchar(50),
@TipoConsumo int

AS 

INSERT INTO [PresupuestoObrasRubros]
(
 Descripcion,
 TipoConsumo
)
VALUES
(
 @Descripcion,
 @TipoConsumo
)

SELECT @IdPresupuestoObraRubro=@@identity
RETURN(@IdPresupuestoObraRubro)
