CREATE Procedure [dbo].[AjustesStock_A]

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

INSERT INTO AjustesStock
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
 FechaImportacionTransmision,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 IdRecepcionSAT,
 CircuitoFirmasCompleto,
 IdSalidaMateriales,
 TipoAjusteInventario,
 ArchivoAdjunto1,
 ArchivoAdjunto2
)
VALUES 
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
 @FechaImportacionTransmision,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @IdRecepcionSAT,
 @CircuitoFirmasCompleto,
 @IdSalidaMateriales,
 @TipoAjusteInventario,
 @ArchivoAdjunto1,
 @ArchivoAdjunto2
)

SELECT @IdAjusteStock=@@identity

RETURN(@IdAjusteStock)