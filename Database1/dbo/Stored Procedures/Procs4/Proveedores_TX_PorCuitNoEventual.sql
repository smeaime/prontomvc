




CREATE Procedure [dbo].[Proveedores_TX_PorCuitNoEventual]
@Cuit varchar(13)
AS 
SELECT * 
FROM Proveedores
WHERE Cuit=@Cuit and Eventual is null





