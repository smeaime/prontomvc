































CREATE Procedure [dbo].[DefinicionArticulos_TX_CamposPorGrupo]
@IdRubro int,
@IdSubrubro int,
@IdFamilia int
as
Select Campo
From DefinicionArticulos
Where (IdRubro=@IdRubro and IdSubrubro=@IdSubrubro and IdFamilia=@IdFamilia)
Order By [Campo]
































