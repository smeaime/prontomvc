
CREATE Procedure [dbo].[Valores_DesmarcarConciliacion]
@IdValor int
AS 
UPDATE Valores
SET Conciliado=Null
WHERE (IdValor=@IdValor)
