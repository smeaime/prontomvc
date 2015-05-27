





























CREATE Procedure [dbo].[Grados_A]
@IdGrado int  output,
@Descripcion varchar(50)
AS 
Insert into [Grados]
(Descripcion)
Values(@Descripcion)
Select @IdGrado=@@identity
Return(@IdGrado)






























