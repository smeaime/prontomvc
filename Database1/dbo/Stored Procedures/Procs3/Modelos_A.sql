





























CREATE Procedure [dbo].[Modelos_A]
@IdModelo int  output,
@Descripcion varchar(50)
AS 
Insert into [Modelos]
(Descripcion)
Values(@Descripcion)
Select @IdModelo=@@identity
Return(@IdModelo)






























