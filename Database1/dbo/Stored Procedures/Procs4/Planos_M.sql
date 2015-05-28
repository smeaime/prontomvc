





























CREATE  Procedure [dbo].[Planos_M]
@IdPlano int ,
@NumeroPlano varchar(30),
@Descripcion varchar(50),
@Revision varchar(10),
@EnviarEmail tinyint
AS
Update Planos
SET
NumeroPlano=@NumeroPlano,
Descripcion=@Descripcion,
Revision=@Revision,
EnviarEmail=@EnviarEmail
Where (IdPlano=@IdPlano)
Return(@IdPlano)






























