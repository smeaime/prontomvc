CREATE Procedure [dbo].[DetPolizas_T]

@IdDetallePoliza int

AS 

SELECT *
FROM DetallePolizas
WHERE (IdDetallePoliza=@IdDetallePoliza)