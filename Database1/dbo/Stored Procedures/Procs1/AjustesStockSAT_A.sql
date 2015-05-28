


CREATE Procedure [dbo].[AjustesStockSAT_A]
@IdAjusteStock int  output,
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
Insert into AjustesStockSAT
(
 NumeroAjusteStock,
 FechaAjuste,
 Observaciones,
 IdRealizo,
 FechaRegistro,
 IdAprobo,
 NumeroMarbete,
 TipoAjuste,
 EnviarEmail,
 IdAjusteStockOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision
)
Values
(
 @NumeroAjusteStock,
 @FechaAjuste,
 @Observaciones,
 @IdRealizo,
 @FechaRegistro,
 @IdAprobo,
 @NumeroMarbete,
 @TipoAjuste,
 @EnviarEmail,
 @IdAjusteStockOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision
)
Select @IdAjusteStock=@@identity
Return(@IdAjusteStock)



