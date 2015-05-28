
CREATE Procedure [dbo].[Articulos_TX_PorNumeroInventarioIdTransportista]
@NumeroInventario varchar(20),
@IdTransportista int
AS 
SELECT *
FROM Articulos
WHERE NumeroInventario=@NumeroInventario and IdTransportista=@IdTransportista
