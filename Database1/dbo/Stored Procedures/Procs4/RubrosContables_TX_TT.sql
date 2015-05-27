





CREATE Procedure [dbo].[RubrosContables_TX_TT]
@IdRubroContable int
AS 
Select 
 IdRubroContable,
 Codigo,
 Descripcion as [Rubro],
 Nivel
FROM RubrosContables 
WHERE (IdRubroContable=@IdRubroContable)





