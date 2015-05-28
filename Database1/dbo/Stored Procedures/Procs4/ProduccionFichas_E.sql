
CREATE Procedure ProduccionFichas_E
@IdProduccionFicha int  
AS 

DELETE DetalleProduccionFichaProcesos
WHERE (IdProduccionFicha=@IdProduccionFicha)

DELETE DetalleProduccionFichas
WHERE (IdProduccionFicha=@IdProduccionFicha)

DELETE ProduccionFichas
WHERE (IdProduccionFicha=@IdProduccionFicha)


