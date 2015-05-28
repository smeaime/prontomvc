


CREATE Procedure [dbo].[DetDefinicionAnulaciones_T]
@IdDetalleDefinicionAnulacion int
AS 
SELECT *
FROM [DetalleDefinicionAnulaciones]
WHERE (IdDetalleDefinicionAnulacion=@IdDetalleDefinicionAnulacion)


