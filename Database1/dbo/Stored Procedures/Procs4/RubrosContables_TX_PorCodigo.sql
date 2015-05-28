CREATE Procedure [dbo].[RubrosContables_TX_PorCodigo]

@Codigo int

AS 

SELECT *
FROM RubrosContables
WHERE (Codigo=@Codigo)