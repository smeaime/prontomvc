





























CREATE Procedure [dbo].[Densidades_A]
@IdDensidad int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Densidades]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdDensidad=@@identity
Return(@IdDensidad)






























