CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_PorItemConHijos]

@Item varchar(20),
@IdObra int = Null,
@PresupuestoObraRubro varchar(1) = Null,
@SinNodoPadre varchar(1) = Null,
@IdEntidad int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @PresupuestoObraRubro=IsNull(@PresupuestoObraRubro,'*')
SET @SinNodoPadre=IsNull(@SinNodoPadre,'N')
SET @IdEntidad=IsNull(@IdEntidad,-1)

DECLARE @IdPresupuestoObrasNodo int, @IdPresupuestoObraRubro int, @IdSubrubro int, @CantRegFiltrados int, @vector_X varchar(50), @vector_T varchar(50)

SET @vector_X='011133'
SET @vector_T='0EE200'

SET @IdPresupuestoObrasNodo=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where (@IdObra=-1 or IdObra=@IdObra) and RTrim(IsNull(Item,''))=@Item),0)

SET @IdPresupuestoObraRubro=-1
SET @IdSubrubro=-1
SET @CantRegFiltrados=0
IF @PresupuestoObraRubro='M'
    BEGIN
	SET @IdPresupuestoObraRubro=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloMateriales'),0)
	SET @IdSubrubro=IsNull((Select Top 1 IdSubrubro From Articulos Where IdArticulo=@IdEntidad),-1)
	SET @CantRegFiltrados=IsNull((Select Count(*) From PresupuestoObrasNodos p
					Where (p.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%',p.Lineage)>0) and 
						(@IdPresupuestoObraRubro=-1 or p.IdPresupuestoObraRubro=@IdPresupuestoObraRubro) and IsNull(p.IdSubrubro,0)=@IdSubrubro and 
						(@SinNodoPadre='N' or not Exists(Select Top 1 p1.IdPresupuestoObrasNodo From PresupuestoObrasNodos p1 Where IsNull(p1.IdNodoPadre,0)=p.IdPresupuestoObrasNodo))),0)
    END
IF @PresupuestoObraRubro='E'
	SET @IdPresupuestoObraRubro=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloEquipos'),0)
IF @PresupuestoObraRubro='O'
	SET @IdPresupuestoObraRubro=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloManoObra'),0)
IF @PresupuestoObraRubro='S'
	SET @IdPresupuestoObraRubro=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloSubcontratos'),0)

SET NOCOUNT OFF

SELECT 
 P.IdPresupuestoObrasNodo, 
 P.Descripcion as [Etapa], 
 (Select Top 1 P1.Descripcion From PresupuestoObrasNodos P1 Where P1.IdPresupuestoObrasNodo=P.IdNodoPadre) as [Nodo padre],
 P.Item as [Item], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM PresupuestoObrasNodos P
WHERE (P.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%',p.Lineage)>0) and 
	(@IdPresupuestoObraRubro=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro) and 
	(@SinNodoPadre='N' or not Exists(Select Top 1 P1.IdPresupuestoObrasNodo From PresupuestoObrasNodos P1 Where IsNull(P1.IdNodoPadre,0)=P.IdPresupuestoObrasNodo)) and 
	(@PresupuestoObraRubro<>'M' or (@PresupuestoObraRubro='M' and (@CantRegFiltrados=0 or (@CantRegFiltrados>0 and IsNull(p.IdSubrubro,0)=@IdSubrubro))))
ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item