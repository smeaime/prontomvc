





























CREATE Procedure [dbo].[DetAcoNormas_A]
@IdDetalleAcoNorma int  output,
@IdAcoNorma int,
@IdNorma int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoNormas]
(
IdAcoNorma,
IdNorma
)
Values
(
@IdAcoNorma,
@IdNorma
)
Select @IdDetalleAcoNorma=@@identity
Return(@IdDetalleAcoNorma)






























