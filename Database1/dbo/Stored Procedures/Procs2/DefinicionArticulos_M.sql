




CREATE  Procedure [dbo].[DefinicionArticulos_M]
@IdDef int,
@IdRubro int,
@IdSubrubro int,
@IdFamilia int,
@AddNombre varchar(2),
@Orden smallint,
@Campo varchar(50),
@Etiqueta varchar(30),
@TablaCombo varchar(30),
@CampoCombo varchar(30),
@CampoUnidad varchar(30),
@UnidadDefault int,
@Antes varchar(15),
@Despues varchar(15),
@UsaAbreviatura varchar(2),
@AgregaUnidadADescripcion varchar(2),
@UsaAbreviaturaUnidad varchar(2),
@InformacionAdicional varchar(2),
@CampoSiNo varchar(2)
As
Update DefinicionArticulos
Set 
 IdRubro=@IdRubro,
 IdSubrubro=@IdSubrubro,
 IdFamilia=@IdFamilia,
 AddNombre=@AddNombre,
 Orden=@Orden,
 Campo=@Campo,
 Etiqueta=@Etiqueta,
 TablaCombo=@TablaCombo,
 CampoCombo=@CampoCombo,
 CampoUnidad=@CampoUnidad,
 UnidadDefault=@UnidadDefault,
 Antes=@Antes,
 Despues=@Despues,
 UsaAbreviatura=@UsaAbreviatura,
 AgregaUnidadADescripcion=@AgregaUnidadADescripcion,
 UsaAbreviaturaUnidad=@UsaAbreviaturaUnidad,
 InformacionAdicional=@InformacionAdicional,
 CampoSiNo=@CampoSiNo
Where (IdDef=@IdDef)
Return(@IdDef)




