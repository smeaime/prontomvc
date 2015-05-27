
CREATE Procedure [dbo].[DefinicionArticulos_A]

@IdDef int  output,
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

AS 

INSERT INTO [DefinicionArticulos]
(
 IdRubro,
 IdSubrubro,
 IdFamilia,
 AddNombre,
 Orden,
 Campo,
 Etiqueta,
 TablaCombo,
 CampoCombo,
 CampoUnidad,
 UnidadDefault,
 Antes,
 Despues,
 UsaAbreviatura,
 AgregaUnidadADescripcion,
 UsaAbreviaturaUnidad,
 InformacionAdicional,
 CampoSiNo
)
VALUES
(
 @IdRubro,
 @IdSubrubro,
 @IdFamilia,
 @AddNombre,
 @Orden,
 @Campo,
 @Etiqueta,
 @TablaCombo,
 @CampoCombo,
 @CampoUnidad,
 @UnidadDefault,
 @Antes,
 @Despues,
 @UsaAbreviatura,
 @AgregaUnidadADescripcion,
 @UsaAbreviaturaUnidad,
 @InformacionAdicional,
 @CampoSiNo
)

SELECT @IdDef=@@identity
RETURN(@IdDef)
