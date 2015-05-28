CREATE Procedure [dbo].[DetPolizas_TX_PorIdPoliza]

@IdPoliza int

AS 

SELECT *
FROM DetallePolizas
WHERE IdPoliza=@IdPoliza