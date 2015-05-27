CREATE Procedure [dbo].[Proveedores_TX_ValidarPorCuit]

@IdProveedor int,
@Cuit varchar(13)

AS 

SELECT * 
FROM Proveedores
WHERE Cuit=@Cuit and IdProveedor<>@IdProveedor