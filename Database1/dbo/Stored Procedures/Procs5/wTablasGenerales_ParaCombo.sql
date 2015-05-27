
CREATE Procedure [dbo].[wTablasGenerales_ParaCombo]

@Tabla varchar(50)

AS 

IF @Tabla='DescripcionIva'
	SELECT IdCodigoIva, Descripcion as [Titulo]
	FROM DescripcionIva 
	ORDER BY Descripcion

IF @Tabla='TiposComprobante'
	SELECT IdTipoComprobante, Descripcion as [Titulo]
	FROM TiposComprobante 
	ORDER BY Descripcion

