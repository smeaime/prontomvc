





























CREATE Procedure [dbo].[Rangos_A]
@IdRango int  output,
@Descripcion varchar(50)
AS 
Insert into [Rangos]
(Descripcion)
Values(@Descripcion)
Select @IdRango=@@identity
Return(@IdRango)






























