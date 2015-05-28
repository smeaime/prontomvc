


CREATE Procedure [dbo].[Obras_TX_PorIdClienteParaCombo]
@IdCliente int
AS 
SELECT 
 IdObra,
 NumeroObra+' - '+Descripcion as [Titulo]
FROM Obras
WHERE IdCliente=@IdCliente
ORDER BY NumeroObra


