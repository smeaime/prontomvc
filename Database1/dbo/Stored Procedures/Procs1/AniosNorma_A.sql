































CREATE Procedure [dbo].[AniosNorma_A]
@IdAnioNorma int  output,
@Descripcion varchar(50)
AS 
Insert into [AniosNorma]
(Descripcion)
Values(@Descripcion)
Select @IdAnioNorma=@@identity
Return(@IdAnioNorma)
































