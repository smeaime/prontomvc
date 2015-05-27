





























CREATE Procedure [dbo].[DetAcoCalidades_A]
@IdDetalleAcoCalidad int  output,
@IdAcoCalidad int,
@IdCalidad int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoCalidades]
(
IdAcoCalidad,
IdCalidad
)
Values
(
@IdAcoCalidad,
@IdCalidad
)
Select @IdDetalleAcoCalidad=@@identity
Return(@IdDetalleAcoCalidad)






























