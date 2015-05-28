


















CREATE Procedure [dbo].[Valores_DesmarcarComoEmitido]
@IdValor int
AS 
UPDATE Valores
SET 	Emitido=Null,
	IdEmitio=Null,
	FechaEmision=Null
WHERE (IdValor=@IdValor)



















