CREATE Procedure [dbo].[Valores_MarcarComoConciliado]

@IdValor int

AS 

UPDATE Valores
SET 	Conciliado='SI',
	MovimientoConfirmadoBanco='SI',
	FechaConfirmacionBanco=GetDate()
WHERE (IdValor=@IdValor)