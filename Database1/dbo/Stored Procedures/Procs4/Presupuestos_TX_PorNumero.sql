
CREATE Procedure [dbo].[Presupuestos_TX_PorNumero]

@Numero int,
@SubNumero int

AS 

SELECT Presupuestos.*, PlazosEntrega.Descripcion as [PlazoEntrega]
FROM Presupuestos
LEFT OUTER JOIN PlazosEntrega ON PlazosEntrega.IdPlazoEntrega=Presupuestos.IdPlazoEntrega
WHERE Numero=@Numero AND SubNumero=@SubNumero
