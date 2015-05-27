
CREATE Procedure [dbo].[wProveedores_TX_PorCuit]
@Cuit varchar(13)
AS 
SELECT * 
FROM Proveedores
WHERE Cuit=@Cuit

