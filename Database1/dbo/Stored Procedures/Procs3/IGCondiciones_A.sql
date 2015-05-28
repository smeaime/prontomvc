





























CREATE Procedure [dbo].[IGCondiciones_A]
@IdIGCondicion int  output,
@Descripcion varchar(50)
AS 
Insert into [IGCondiciones]
(Descripcion)
Values(@Descripcion)
Select @IdIGCondicion=@@identity
Return(@IdIGCondicion)






























