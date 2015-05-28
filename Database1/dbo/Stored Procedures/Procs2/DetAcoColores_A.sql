





























CREATE Procedure [dbo].[DetAcoColores_A]
@IdDetalleAcoColor int  output,
@IdAcoColor int,
@IdColor int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoColores]
(
IdAcoColor,
IdColor
)
Values
(
@IdAcoColor,
@IdColor
)
Select @IdDetalleAcoColor=@@identity
Return(@IdDetalleAcoColor)






























