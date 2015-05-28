





























CREATE Procedure [dbo].[DetAcoGrados_A]
@IdDetalleAcoGrado int  output,
@IdAcoGrado int,
@IdGrado int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoGrados]
(
IdAcoGrado,
IdGrado
)
Values
(
@IdAcoGrado,
@IdGrado
)
Select @IdDetalleAcoGrado=@@identity
Return(@IdDetalleAcoGrado)






























