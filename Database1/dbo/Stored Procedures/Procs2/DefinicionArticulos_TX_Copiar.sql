
CREATE PROCEDURE [dbo].[DefinicionArticulos_TX_Copiar]

@IdRubroDesde int,
@IdSubrubroDesde int,
@IdFamiliaDesde int,
@IdRubroFinal int,
@IdSubrubroFinal int,
@IdFamiliaFinal int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdRubro int,
			 IdSubrubro int,
			 IdFamilia int,
			 AddNombre varchar(2),
			 Orden smallint,
			 Campo varchar(50),
			 Etiqueta varchar(30),
		 	 TablaCombo varchar(30),
			 CampoCombo varchar(30),
			 CampoUnidad varchar(30),
			 UnidadDefault int,
			 Antes varchar(15),
			 Despues varchar(15),
			 UsaAbreviatura varchar(2),
			 AgregaUnidadADescripcion varchar(2),
			 UsaAbreviaturaUnidad varchar(2),
			 InformacionAdicional varchar(2),
			 CampoSiNo varchar(2)
			)
INSERT INTO #Auxiliar1 
 SELECT IdRubro, IdSubrubro, IdFamilia, AddNombre, Orden, Campo, Etiqueta, TablaCombo, CampoCombo, CampoUnidad, UnidadDefault, 
	Antes, Despues, UsaAbreviatura, AgregaUnidadADescripcion, UsaAbreviaturaUnidad, InformacionAdicional, CampoSiNo
 FROM DefinicionArticulos 
 WHERE IdRubro=@IdRubroDesde and IdSubrubro=@IdSubrubroDesde and IdFamilia=@IdFamiliaDesde

UPDATE #Auxiliar1
SET IdRubro=@IdRubroFinal, IdSubrubro=@IdSubrubroFinal, IdFamilia=@IdFamiliaFinal 

DELETE DefinicionArticulos
WHERE IdRubro=@IdRubroFinal and IdSubrubro=@IdSubrubroFinal and IdFamilia=@IdFamiliaFinal 

INSERT INTO DefinicionArticulos 
 SELECT IdRubro, IdSubrubro, IdFamilia, AddNombre, Orden, Campo, Etiqueta, TablaCombo, CampoCombo, CampoUnidad, UnidadDefault, 
	Antes, Despues, UsaAbreviatura, AgregaUnidadADescripcion, UsaAbreviaturaUnidad, InformacionAdicional, CampoSiNo
 FROM #Auxiliar1 

SET NOCOUNT OFF

