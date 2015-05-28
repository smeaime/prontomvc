





























CREATE Procedure [dbo].[DetAcoSeries_A]
@IdDetalleAcoSerie int  output,
@IdAcoSerie int,
@IdSerie int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoSeries]
(
IdAcoSerie,
IdSerie
)
Values
(
@IdAcoSerie,
@IdSerie
)
Select @IdDetalleAcoSerie=@@identity
Return(@IdDetalleAcoSerie)






























