





























CREATE Procedure [dbo].[DetAcoFormas_A]
@IdDetalleAcoForma int  output,
@IdAcoForma int,
@IdForma int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoFormas]
(
IdAcoForma,
IdForma
)
Values
(
@IdAcoForma,
@IdForma
)
Select @IdDetalleAcoForma=@@identity
Return(@IdDetalleAcoForma)






























