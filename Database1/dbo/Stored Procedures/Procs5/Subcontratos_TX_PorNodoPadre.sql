CREATE Procedure [dbo].[Subcontratos_TX_PorNodoPadre]

@IdNodoPadre int

AS 

SELECT C.*
FROM Subcontratos C
WHERE IsNull(C.idNodoPadre,0)=@IdNodoPadre
ORDER BY C.TipoNodo, C.Descripcion, C.IdSubcontrato