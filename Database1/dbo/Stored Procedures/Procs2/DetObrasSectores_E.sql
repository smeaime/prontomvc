
CREATE Procedure [dbo].[DetObrasSectores_E]

@IdDetalleObraSector int  

AS 

DELETE [DetalleObrasSectores]
WHERE (IdDetalleObraSector=@IdDetalleObraSector)
