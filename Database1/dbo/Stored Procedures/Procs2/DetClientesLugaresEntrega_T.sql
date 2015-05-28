CREATE Procedure [dbo].[DetClientesLugaresEntrega_T]

@IdDetalleClienteLugarEntrega int

AS 

SELECT *
FROM DetalleClientesLugaresEntrega
WHERE (IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega)