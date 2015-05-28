





























CREATE Procedure [dbo].[RubrosValores_A]
@IdRubroValor int  output,
@Codigo varchar(5),
@Descripcion varchar(50)
AS 
Insert into [RubrosValores]
(
Codigo,
Descripcion
)
Values
(
@Codigo,
@Descripcion
)
Select @IdRubroValor=@@identity
Return(@IdRubroValor)






























