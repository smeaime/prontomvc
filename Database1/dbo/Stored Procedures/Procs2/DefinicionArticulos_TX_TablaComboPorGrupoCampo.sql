































CREATE Procedure [dbo].[DefinicionArticulos_TX_TablaComboPorGrupoCampo]
@IdRubro int,
@IdSubrubro int,
@IdFamilia int,
@Campo varchar(30)
as
Select Top 1 TablaCombo
From DefinicionArticulos
Where (IdRubro=@IdRubro and IdSubrubro=@IdSubrubro and IdFamilia=@IdFamilia and Campo=@Campo)
































