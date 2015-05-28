CREATE  Procedure [dbo].[Previsiones_M]

@IdPrevision int ,
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

UPDATE Previsiones
SET
 Numero=@Numero,
 Fecha=@Fecha,
 IdRubroFinanciero=@IdRubroFinanciero,
 IdBanco=@IdBanco,
 Observaciones=@Observaciones,
 FechaCaducidad=@FechaCaducidad,
 Importe=@Importe,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,
 TipoMovimiento=@TipoMovimiento,
 IdObra=@IdObra,
 PostergarFechaCaducidad=@PostergarFechaCaducidad
WHERE (IdPrevision=@IdPrevision)

RETURN(@IdPrevision)