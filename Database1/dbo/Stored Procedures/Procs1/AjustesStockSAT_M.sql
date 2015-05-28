






CREATE Procedure [dbo].[AjustesStockSAT_M]
@IdAjusteStock int,
@NumeroAjusteStock int,
@FechaAjuste datetime,
@Observaciones ntext,
@IdRealizo int,
@FechaRegistro datetime,
@IdAprobo int,
@NumeroMarbete int,
@TipoAjuste varchar(1),
@EnviarEmail tinyint,
@IdAjusteStockOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime
As
Update AjustesStockSAT
Set 
 NumeroAjusteStock=@NumeroAjusteStock,
 FechaAjuste=@FechaAjuste,
 Observaciones=@Observaciones,
 IdRealizo=@IdRealizo,
 FechaRegistro=@FechaRegistro,
 IdAprobo=@IdAprobo,
 NumeroMarbete=@NumeroMarbete,
 TipoAjuste=@TipoAjuste,
 EnviarEmail=@EnviarEmail,
 IdAjusteStockOriginal=@IdAjusteStockOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 FechaImportacionTransmision=@FechaImportacionTransmision
Where (IdAjusteStock=@IdAjusteStock)
Return(@IdAjusteStock)



