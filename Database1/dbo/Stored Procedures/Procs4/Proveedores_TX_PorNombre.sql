CREATE Procedure [dbo].[Proveedores_TX_PorNombre]

@RazonSocial varchar(50)

AS 
SELECT TOP 1 * 
FROM Proveedores
WHERE Upper(@RazonSocial)=Upper(RazonSocial)