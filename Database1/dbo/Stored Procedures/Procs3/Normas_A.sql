





























CREATE Procedure [dbo].[Normas_A]
@IdNorma int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Normas]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdNorma=@@identity
Return(@IdNorma)






























