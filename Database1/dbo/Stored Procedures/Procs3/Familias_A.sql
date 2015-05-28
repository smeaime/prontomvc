





























CREATE Procedure [dbo].[Familias_A]
@IdFamilia int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@EnviarEmail tinyint
AS 
Insert into [Familias]
(
Descripcion,
Abreviatura,
EnviarEmail
)
Values
(
@Descripcion,
@Abreviatura,
@EnviarEmail
)
Select @IdFamilia=@@identity
Return(@IdFamilia)






























