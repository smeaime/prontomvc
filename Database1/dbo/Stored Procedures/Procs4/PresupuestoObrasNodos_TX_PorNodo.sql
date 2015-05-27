CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_PorNodo]

@IdNodo int,
@CodigoPresupuesto int = Null,
@IdObra int = Null

AS 

SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)
SET @IdObra=IsNull(@IdObra,-1)

IF @IdNodo=0
	SELECT P.*, O.Descripcion as [DescripcionObra], U.Abreviatura as [Unidad], IsNull(R.Descripcion,'Varios') as [Rubro], 
		Case When IsNull(P.UnidadAvance,'')='' Then U.Abreviatura Else P.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1], 
		IsNull((Select Count(*) From PresupuestoObrasNodos P1 Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo),0) as [Hijos], 
		PD.IdPresupuestoObrasNodoDatos, PD.Importe, PD.Cantidad, PD.CantidadBase, PD.Rendimiento, PD.Incidencia, PD.Costo
	FROM PresupuestoObrasNodos P
	LEFT OUTER JOIN PresupuestoObrasNodosDatos PD ON PD.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo and PD.CodigoPresupuesto=@CodigoPresupuesto
	LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
	LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	WHERE (@IdObra<=0 or P.IdObra=@IdObra) and P.IdNodoPadre is null and IsNull(O.ActivarPresupuestoObra,'NO')='SI'
	ORDER BY P.TipoNodo, P.Lineage, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, P.Descripcion, P.DescripcionObra, P.IdPresupuestoObrasNodo

ELSE	--estos son los datos del padre
	SELECT P.*, O.Descripcion as [DescripcionObra], U.Abreviatura as [Unidad], IsNull(R.Descripcion,'Varios') as [Rubro], 
		Case When IsNull(P.UnidadAvance,'')='' Then U.Abreviatura Else P.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1], 
		IsNull((Select Count(*) From PresupuestoObrasNodos P1 Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo),0) as [Hijos], 
		PD.IdPresupuestoObrasNodoDatos, PD.Importe, PD.Cantidad, PD.CantidadBase, PD.Rendimiento, PD.Incidencia, PD.Costo
	FROM PresupuestoObrasNodos P
	LEFT OUTER JOIN PresupuestoObrasNodosDatos PD ON PD.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo and PD.CodigoPresupuesto=@CodigoPresupuesto
	LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
	LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	WHERE (@IdObra<=0 or P.IdObra=@IdObra) and P.IdPresupuestoObrasNodo=@IdNodo and IsNull(O.ActivarPresupuestoObra,'NO')='SI'
	
	UNION
	
	--y esto el contenido
	SELECT P.*, O.Descripcion as [DescripcionObra], U.Abreviatura as [Unidad], IsNull(R.Descripcion,'Varios') as [Rubro], 
		Case When IsNull(P.UnidadAvance,'')='' Then U.Abreviatura Else P.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1],
		IsNull((Select Count(*) From PresupuestoObrasNodos P1 Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo),0) as [Hijos], 
		PD.IdPresupuestoObrasNodoDatos, PD.Importe, PD.Cantidad, PD.CantidadBase, PD.Rendimiento, PD.Incidencia, PD.Costo
	FROM PresupuestoObrasNodos P
	LEFT OUTER JOIN PresupuestoObrasNodosDatos PD ON PD.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo and PD.CodigoPresupuesto=@CodigoPresupuesto
	LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
	LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	WHERE (@IdObra<=0 or P.IdObra=@IdObra) and P.IdNodoPadre=@IdNodo and IsNull(O.ActivarPresupuestoObra,'NO')='SI'

	ORDER BY P.TipoNodo, P.Lineage, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, P.Descripcion, P.DescripcionObra, P.IdPresupuestoObrasNodo