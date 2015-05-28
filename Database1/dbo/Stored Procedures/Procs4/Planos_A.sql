





























CREATE Procedure [dbo].[Planos_A]
@IdPlano int  output,
@NumeroPlano varchar(30),
@Descripcion varchar(50),
@Revision varchar(10),
@EnviarEmail tinyint
AS 
Insert into [Planos]
(
NumeroPlano,
Descripcion,
Revision,
EnviarEmail
)
Values
(
@NumeroPlano,
@Descripcion,
@Revision,
@EnviarEmail
)
Select @IdPlano=@@identity
Return(@IdPlano)






























