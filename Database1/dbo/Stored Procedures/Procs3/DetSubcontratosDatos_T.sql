
CREATE Procedure [dbo].[DetSubcontratosDatos_T]

@IdDetalleSubcontratoDatos int

AS 

SELECT *
FROM [DetalleSubcontratosDatos]
WHERE (IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos)
