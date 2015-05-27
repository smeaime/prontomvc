


CREATE Procedure [dbo].[RubrosContables_TX_PorId]
@IdRubroContable int
AS 
SELECT *
FROM RubrosContables
WHERE (IdRubroContable=@IdRubroContable)


