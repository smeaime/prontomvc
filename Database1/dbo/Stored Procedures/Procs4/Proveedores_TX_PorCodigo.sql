CREATE Procedure [dbo].[Proveedores_TX_PorCodigo]

@CodigoProveedor int

AS 
SELECT * 
FROM Proveedores
WHERE Eventual is null And CodigoProveedor=@CodigoProveedor