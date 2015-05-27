CREATE Procedure [dbo].[CertificacionesObras_TX_PorNodo]

@NumeroProyecto int,
@IdNodo int

AS 

IF @IdNodo=0
	SELECT C.*, Unidades.Abreviatura as [Unidad], 
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM CertificacionesObras C
	--LEFT OUTER JOIN CertificacionesObrasPxQ PxQ ON C.IdCertificacionObras=PxQ.IdCertificacionObras
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroProyecto=@NumeroProyecto and C.idNodoPadre is null
	ORDER BY C.TipoNodo, C.Item, C.Descripcion, C.IdCertificacionObras

ELSE	--estos son los datos del padre

	SELECT C.*, Unidades.Abreviatura as [Unidad], 
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM CertificacionesObras C
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroProyecto=@NumeroProyecto and C.IdCertificacionObras=@IdNodo

	UNION ALL

	SELECT C.*, Unidades.Abreviatura as [Unidad], 
		Case When IsNull(C.UnidadAvance,'')='' Then Unidades.Abreviatura Else C.UnidadAvance COLLATE SQL_Latin1_General_CP1_CI_AS End as [UnidadAvance1]
	FROM CertificacionesObras C
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=C.IdUnidad
	WHERE C.NumeroProyecto=@NumeroProyecto and IsNull(C.idNodoPadre,0)=@IdNodo

	ORDER BY C.TipoNodo, C.Lineage, C.Item, C.Descripcion, C.IdCertificacionObras
