





























CREATE Procedure [dbo].[Recepciones_TX_PorNumeroInterno]
@NumeroRecepcionAlmacen int
AS 
SELECT * 
FROM Recepciones
WHERE NumeroRecepcionAlmacen=@NumeroRecepcionAlmacen






























