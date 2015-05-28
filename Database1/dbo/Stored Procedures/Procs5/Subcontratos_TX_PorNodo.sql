CREATE Procedure [dbo].[Subcontratos_TX_PorNodo]

@NumeroSubcontrato int,
@IdNodo int

AS 

IF @IdNodo=0
	SELECT C.*, Unidades.Abreviatura as [Unidad], 0 as [Item1], --Case When IsNumeric(C.Item)=1 Then Convert(int,C.Item) Else 0 End as [Item1],
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM Subcontratos C
	--LEFT OUTER JOIN SubcontratosPxQ PxQ ON C.IdSubcontrato=PxQ.IdSubcontrato
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroSubcontrato=@NumeroSubcontrato and C.idNodoPadre is null
	ORDER BY C.TipoNodo, [Item1], C.Item, C.Descripcion, C.IdSubcontrato

ELSE	--estos son los datos del padre

	SELECT C.*, Unidades.Abreviatura as [Unidad], 0 as [Item1], --Case When IsNumeric(C.Item)=1 Then Convert(int,C.Item) Else 0 End as [Item1],
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM Subcontratos C
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroSubcontrato=@NumeroSubcontrato and C.IdSubcontrato=@IdNodo

	UNION ALL

	SELECT C.*, Unidades.Abreviatura as [Unidad], 0 as [Item1], --Case When IsNumeric(C.Item)=1 Then Convert(int,C.Item) Else 0 End as [Item1],
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM Subcontratos C
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroSubcontrato=@NumeroSubcontrato and IsNull(C.idNodoPadre,0)=@IdNodo

	ORDER BY C.TipoNodo, C.Lineage, [Item1], C.Item, C.Descripcion, C.IdSubcontrato