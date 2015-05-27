
CREATE Procedure [dbo].[Cajas_TX_PorIdMoneda]

@IdMoneda int

AS 

SELECT 
 IdCaja,
 Descripcion as [Titulo],
 IdCuenta
FROM Cajas
WHERE IdMoneda=@IdMoneda
ORDER BY Descripcion
