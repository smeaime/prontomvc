CREATE Procedure [dbo].[AjustesStock_M]

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
@FechaImportacionTransmision datetime,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@IdRecepcionSAT int,
@CircuitoFirmasCompleto varchar(2),
@IdSalidaMateriales int,
@TipoAjusteInventario varchar(1),
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100)

AS

UPDATE AjustesStock
SET
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
 FechaImportacionTransmision=@FechaImportacionTransmision,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,
 IdRecepcionSAT=@IdRecepcionSAT,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 IdSalidaMateriales=@IdSalidaMateriales,
 TipoAjusteInventario=@TipoAjusteInventario,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2
WHERE (IdAjusteStock=@IdAjusteStock)

RETURN(@IdAjusteStock)