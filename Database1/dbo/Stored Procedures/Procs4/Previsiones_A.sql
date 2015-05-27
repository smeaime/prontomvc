CREATE Procedure [dbo].[Previsiones_A]

@IdPrevision int  output,
@Numero int,
@Fecha datetime,
@IdRubroFinanciero int,
@IdBanco int,
@Observaciones ntext,
@FechaCaducidad datetime,
@Importe numeric(18,2),
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@TipoMovimiento varchar(1),
@IdObra int,
@PostergarFechaCaducidad varchar(2)

AS 

INSERT INTO [Previsiones]
(
 Numero,
 Fecha,
 IdRubroFinanciero,
 IdBanco,
 Observaciones,
 FechaCaducidad,
 Importe,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 TipoMovimiento,
 IdObra,
 PostergarFechaCaducidad
)
VALUES
(
 @Numero,
 @Fecha,
 @IdRubroFinanciero,
 @IdBanco,
 @Observaciones,
 @FechaCaducidad,
 @Importe,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @TipoMovimiento,
 @IdObra,
 @PostergarFechaCaducidad
)

SELECT @IdPrevision=@@identity

RETURN(@IdPrevision)