
CREATE Procedure [dbo].[DetObrasSectores_T]

@IdDetalleObraSector int

AS 

SELECT *
FROM [DetalleObrasSectores]
WHERE (IdDetalleObraSector=@IdDetalleObraSector)
