CREATE Procedure [dbo].[DetRequerimientos_TX_UnItem]

@IdDetalleRequerimiento int

AS 

SELECT *
FROM [DetalleRequerimientos]
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)