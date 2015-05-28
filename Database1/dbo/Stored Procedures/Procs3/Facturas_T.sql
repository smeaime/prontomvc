CREATE Procedure [dbo].[Facturas_T]

@IdFactura int

AS 

SELECT *
FROM Facturas
WHERE (IdFactura=@IdFactura)