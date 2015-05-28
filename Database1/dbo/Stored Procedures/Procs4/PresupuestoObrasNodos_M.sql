CREATE Procedure [dbo].[PresupuestoObrasNodos_M]

@IdPresupuestoObrasNodo int,
@IdNodoPadre int,
@Depth int,
@Lineage  varchar(255),
@TipoNodo int,
@IdObra int,
@Descripcion varchar(200),
@IdUnidad int,
@CantidadAvanzada numeric(18,2),
@Item varchar(20),
@UnidadAvance varchar(1),
@IdPresupuestoObraRubro int,
@IdPresupuestoObraGrupoMateriales int,
@IdCuentaGasto int,
@IdSubrubro int,
@SubItem1 varchar(10),
@SubItem2 varchar(10),
@SubItem3 varchar(10),
@IdNodoAuxiliar int,
@SubItem4 varchar(10),
@SubItem5 varchar(10),
@IdCuenta int,
@IdArticulo int

AS

UPDATE PresupuestoObrasNodos
SET
 IdNodoPadre=@IdNodoPadre,
 Depth=@Depth,
 Lineage=@Lineage,
 TipoNodo=@TipoNodo,
 IdObra=@IdObra,
 Descripcion=@Descripcion,
 IdUnidad=@IdUnidad,
 CantidadAvanzada=@CantidadAvanzada,
 Item=@Item,
 UnidadAvance=@UnidadAvance,
 IdPresupuestoObraRubro=@IdPresupuestoObraRubro,
 IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales,
 IdCuentaGasto=@IdCuentaGasto,
 IdSubrubro=@IdSubrubro,
 SubItem1=@SubItem1,
 SubItem2=@SubItem2,
 SubItem3=@SubItem3,
 IdNodoAuxiliar=@IdNodoAuxiliar,
 SubItem4=@SubItem4,
 SubItem5=@SubItem5,
 IdCuenta=@IdCuenta,
 IdArticulo=@IdArticulo
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)

RETURN(@IdPresupuestoObrasNodo)