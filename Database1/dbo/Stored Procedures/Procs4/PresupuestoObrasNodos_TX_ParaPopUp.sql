CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_ParaPopUp]

@IdObra int = Null, 
@IdPresupuestoObrasNodo int = Null,
@CodigoPresupuesto int = Null,
@SoloPadres varchar(2) = Null,
@Dia int = Null,
@Mes int = Null,
@Año int = Null

AS

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @IdPresupuestoObrasNodo=IsNull(@IdPresupuestoObrasNodo,-1)
SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)
SET @Dia=IsNull(@Dia,-1)
SET @Mes=IsNull(@Mes,-1)
SET @Año=IsNull(@Año,-1)
SET @SoloPadres=IsNull(@SoloPadres,'NO')

DECLARE @IdPresupuestoObraRubro1 int, @IdPresupuestoObraRubro2 int, @IdPresupuestoObraRubro3 int, @IdNodoPadre int, @Fecha datetime

IF @Dia>0
	SET @Fecha=Convert(datetime,Convert(varchar,@Dia)+'/'+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año),103)
ELSE
	SET @Fecha=0

SET @IdPresupuestoObraRubro1=Convert(int,IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloMateriales'),'0'))
SET @IdPresupuestoObraRubro2=Convert(int,IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloSubcontratos'),'0'))
SET @IdPresupuestoObraRubro3=Convert(int,IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloAuxiliares'),'0'))
SET @IdNodoPadre=-1
IF @IdPresupuestoObrasNodo>0
	SET @IdNodoPadre=IsNull((Select Top 1 IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)

CREATE TABLE #Auxiliar1 (IdPresupuestoObrasNodo INTEGER, IdNodoPadre INTEGER, IdObra INTEGER, NumeroObra VARCHAR(13), Descripcion VARCHAR(200), Lineage VARCHAR(255), Depth INTEGER, Item VARCHAR(20), 
				Materiales VARCHAR(1), Hoja VARCHAR(1), SubItem1 VARCHAR(10), SubItem2 VARCHAR(10), SubItem3 VARCHAR(10), SubItem4 VARCHAR(10), SubItem5 VARCHAR(10), 
				Anterior numeric(18,8), Dia numeric(18,8), Posterior numeric(18,8), Hijos INTEGER, Unidad VARCHAR(50), UnidadAvance1 VARCHAR(50), Rubro VARCHAR(50), IdPresupuestoObrasNodoDatos INTEGER, 
				Importe numeric(18,8), Cantidad numeric(18,8), CantidadBase numeric(18,2), Rendimiento numeric(18,2), Incidencia numeric(18,8), Costo numeric(18,8))
INSERT INTO #Auxiliar1 
 SELECT T.IdPresupuestoObrasNodo, T.IdNodoPadre, T.IdObra, O.NumeroObra, IsNull(T.Descripcion,O.Descripcion), T.Lineage, T.Depth, T.Item, 
	Case When T.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or T.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2 or T.IdPresupuestoObraRubro=@IdPresupuestoObraRubro3 Then 'S' Else '' End, 
	Case When Not Exists(Select Top 1 T1.IdPresupuestoObrasNodo From PresupuestoObrasNodos T1 Where T1.IdNodoPadre=T.IdPresupuestoObrasNodo) Then 'S' Else '' End, 
	T.SubItem1, T.SubItem2, T.SubItem3, T.SubItem4, T.SubItem5,
	Case When @Dia>0 Then IsNull((Select Sum(IsNull(pondia.CantidadAvance,0)) From PresupuestoObrasNodosPxQxPresupuestoPorDia pondia 
					Where pondia.IdPresupuestoObrasNodo = T.IdPresupuestoObrasNodo and Convert(datetime,Convert(varchar,pondia.Dia)+'/'+Convert(varchar,pondia.Mes)+'/'+Convert(varchar,pondia.Año),103)<@Fecha),0)
		Else 0
	End,
	Case When @Dia>0 Then IsNull((Select Sum(IsNull(pondia.CantidadAvance,0)) From PresupuestoObrasNodosPxQxPresupuestoPorDia pondia 
					Where pondia.IdPresupuestoObrasNodo = T.IdPresupuestoObrasNodo and Convert(datetime,Convert(varchar,pondia.Dia)+'/'+Convert(varchar,pondia.Mes)+'/'+Convert(varchar,pondia.Año),103)=@Fecha),0)
		Else 0
	End,
	Case When @Dia>0 Then IsNull((Select Sum(IsNull(pondia.CantidadAvance,0)) From PresupuestoObrasNodosPxQxPresupuestoPorDia pondia 
					Where pondia.IdPresupuestoObrasNodo = T.IdPresupuestoObrasNodo and Convert(datetime,Convert(varchar,pondia.Dia)+'/'+Convert(varchar,pondia.Mes)+'/'+Convert(varchar,pondia.Año),103)>@Fecha),0)
		Else 0
	End,
	IsNull((Select Count(*) From PresupuestoObrasNodos P1 Where P1.IdNodoPadre=T.IdPresupuestoObrasNodo),0),
	U.Abreviatura, Case When IsNull(T.UnidadAvance,'')='' Then U.Abreviatura Else T.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End,
	IsNull(R.Descripcion,'Varios'),
	PD.IdPresupuestoObrasNodoDatos, PD.Importe, PD.Cantidad, PD.CantidadBase, PD.Rendimiento, PD.Incidencia, PD.Costo
 FROM PresupuestoObrasNodos T 
 LEFT OUTER JOIN Obras O On O.IdObra=T.IdObra
 LEFT OUTER JOIN PresupuestoObrasNodosDatos PD ON PD.IdPresupuestoObrasNodo=T.IdPresupuestoObrasNodo and PD.CodigoPresupuesto=@CodigoPresupuesto
 LEFT OUTER JOIN Unidades U ON U.IdUnidad=T.idUnidad
 LEFT OUTER JOIN Tipos R On R.IdTipo=T.IdPresupuestoObraRubro
 WHERE (@IdObra=-1 or T.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and (@IdNodoPadre<=0 or Patindex('%/'+Convert(varchar,@IdNodoPadre)+'/%',Lineage)>0 ) and IsNull(O.ActivarPresupuestoObra,'')='SI'

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar1
WHERE @SoloPadres<>'SI' or Hijos>0
ORDER BY SubItem1, SubItem2, SubItem3, SubItem4, SubItem5, Item, Descripcion, IdPresupuestoObrasNodo, IdNodoPadre, Lineage

DROP TABLE #Auxiliar1