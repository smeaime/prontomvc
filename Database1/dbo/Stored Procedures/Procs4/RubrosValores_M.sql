





























CREATE  Procedure [dbo].[RubrosValores_M]
@IdRubroValor int ,
@Codigo varchar(5),
@Descripcion varchar(50)
AS
Update RubrosValores
SET
Codigo=@Codigo,
Descripcion=@Descripcion
Where (IdRubroValor=@IdRubroValor)
Return(@IdRubroValor)






























