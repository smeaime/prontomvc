


















CREATE Procedure [dbo].[Valores_MarcarComoEmitido]
@IdValor int,
@IdEmitio int
AS 
UPDATE Valores
SET 	Emitido='SI',
	IdEmitio=@IdEmitio,
	FechaEmision=GetDate()
WHERE (IdValor=@IdValor)



















