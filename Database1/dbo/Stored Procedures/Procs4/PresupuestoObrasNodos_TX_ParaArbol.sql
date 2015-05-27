CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_ParaArbol]

@IdObra int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)

CREATE TABLE #Auxiliar1 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 IdNodoPadre INTEGER,
			 Descripcion VARCHAR(255),
			 TipoNodo INTEGER,
			 Lineage VARCHAR(255),
			 Item VARCHAR(20),
			 SubItem1 VARCHAR(10),
			 SubItem2 VARCHAR(10),
			 SubItem3 VARCHAR(10),
			 SubItem4 VARCHAR(10),
			 SubItem5 VARCHAR(10),
			 SubItem10 INTEGER,
			 SubItem20 INTEGER,
			 SubItem30 INTEGER,
			 SubItem40 INTEGER,
			 SubItem50 INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT P.IdPresupuestoObrasNodo, P.IdNodoPadre, IsNull(P.Descripcion,O.Descripcion), P.TipoNodo, P.Lineage, P.Item, P.SubItem1, P.SubItem2, P.SubItem3,  P.SubItem4,  P.SubItem5, 
	Case When IsNumeric(P.SubItem1)=1 Then Convert(int,P.SubItem1) Else 0 End as [SubItem10], Case When IsNumeric(P.SubItem2)=1 Then Convert(int,P.SubItem2) Else 0 End as [SubItem20],
	Case When IsNumeric(P.SubItem3)=1 Then Convert(int,P.SubItem3) Else 0 End as [SubItem30], Case When IsNumeric(P.SubItem4)=1 Then Convert(int,P.SubItem4) Else 0 End as [SubItem40],
	Case When IsNumeric(P.SubItem5)=1 Then Convert(int,P.SubItem5) Else 0 End as [SubItem50]
 FROM PresupuestoObrasNodos P
 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
 WHERE (@IdObra<=0 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is null and IsNull(O.ActivarPresupuestoObra,'NO')='SI'
 ORDER BY [SubItem10], [SubItem20], [SubItem30], [SubItem40], [SubItem50], P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, IsNull(P.Descripcion,O.Descripcion), P.IdPresupuestoObrasNodo

INSERT INTO #Auxiliar1 
 SELECT P.IdPresupuestoObrasNodo, P.IdNodoPadre, P.Descripcion, P.TipoNodo, P.Lineage, P.Item, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, 
	Case When IsNumeric(P.SubItem1)=1 Then Convert(int,P.SubItem1) Else 0 End as [SubItem10], Case When IsNumeric(P.SubItem2)=1 Then Convert(int,P.SubItem2) Else 0 End as [SubItem20],
	Case When IsNumeric(P.SubItem3)=1 Then Convert(int,P.SubItem3) Else 0 End as [SubItem30], Case When IsNumeric(P.SubItem4)=1 Then Convert(int,P.SubItem4) Else 0 End as [SubItem40],
	Case When IsNumeric(P.SubItem5)=1 Then Convert(int,P.SubItem5) Else 0 End as [SubItem50]
 FROM PresupuestoObrasNodos P
 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
 WHERE (@IdObra<=0 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and IsNull(O.ActivarPresupuestoObra,'NO')='SI'
 ORDER BY P.IdNodoPadre, [SubItem10], [SubItem20], [SubItem30], [SubItem40], [SubItem50], P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, P.Descripcion, P.IdPresupuestoObrasNodo

SET NOCOUNT OFF

SELECT * FROM #Auxiliar1
ORDER BY IdNodoPadre, Lineage, SubItem1, SubItem2, SubItem3, SubItem4, SubItem5, SubItem10, SubItem20, SubItem30, SubItem40, SubItem50, Item, Descripcion

DROP TABLE #Auxiliar1