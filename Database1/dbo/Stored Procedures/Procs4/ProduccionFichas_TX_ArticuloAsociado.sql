
CREATE Procedure ProduccionFichas_TX_ArticuloAsociado
@IdArticuloAsociado int,
@IdColor int=0
AS 
SELECT * 
FROM ProduccionFichas
WHERE (IdArticuloAsociado=@IdArticuloAsociado)
and (IdColor=@IdColor or @Idcolor=0)

