






















CREATE Procedure [dbo].[Proveedores_TX_PorCodigoPresto]
@CodigoPresto varchar(13)
AS 
SELECT * 
FROM Proveedores
WHERE Eventual is null And CodigoPresto=@CodigoPresto























