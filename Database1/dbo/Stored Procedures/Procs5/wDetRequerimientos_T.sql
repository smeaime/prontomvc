
CREATE Procedure [dbo].[wDetRequerimientos_T]

@IdDetalleRequerimiento int

AS 

SELECT *
FROM [DetalleRequerimientos]
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)

