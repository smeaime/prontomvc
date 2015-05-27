
CREATE  Procedure [dbo].[PresupuestoObrasRubros_M]

@IdPresupuestoObraRubro int ,
@Descripcion varchar(50),
@TipoConsumo int

AS

UPDATE PresupuestoObrasRubros
SET
 Descripcion=@Descripcion,
 TipoConsumo=@TipoConsumo
WHERE (IdPresupuestoObraRubro=@IdPresupuestoObraRubro)

RETURN(@IdPresupuestoObraRubro)
