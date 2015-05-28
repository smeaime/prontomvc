


CREATE Procedure [dbo].[UnidadesOperativas_A]
@IdUnidadOperativa int  output,
@Descripcion varchar(50),
@EnviarEmail tinyint,
@Codigo varchar(10)
As 
Insert into [UnidadesOperativas]
(
 Descripcion,
 EnviarEmail,
 Codigo
)
Values
(
 @Descripcion,
 @EnviarEmail,
 @Codigo
)
Select @IdUnidadOperativa=@@identity
Return(@IdUnidadOperativa)


