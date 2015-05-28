CREATE Procedure [dbo].[PresupuestoObrasNodos_A]

@IdPresupuestoObrasNodo int output,
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

INSERT INTO [PresupuestoObrasNodos]
(
 IdNodoPadre,
 Depth ,
 Lineage ,
 TipoNodo ,
 IdObra ,
 Descripcion,
 IdUnidad ,
 CantidadAvanzada,
 Item,
 UnidadAvance,
 IdPresupuestoObraRubro,
 IdPresupuestoObraGrupoMateriales,
 IdCuentaGasto,
 IdSubrubro,
 SubItem1,
 SubItem2,
 SubItem3,
 IdNodoAuxiliar,
 SubItem4,
 SubItem5,
 IdCuenta,
 IdArticulo
)
VALUES
(
 @IdNodoPadre,
 @Depth ,
 @Lineage ,
 @TipoNodo ,
 @IdObra ,
 @Descripcion,
 @IdUnidad ,
 @CantidadAvanzada,
 @Item,
 @UnidadAvance, 
 @IdPresupuestoObraRubro,
 @IdPresupuestoObraGrupoMateriales,
 @IdCuentaGasto,
 @IdSubrubro,
 @SubItem1,
 @SubItem2,
 @SubItem3,
 @IdNodoAuxiliar,
 @SubItem4,
 @SubItem5,
 @IdCuenta,
 @IdArticulo
)

SELECT @IdPresupuestoObrasNodo=@@identity

RETURN(@IdPresupuestoObrasNodo)