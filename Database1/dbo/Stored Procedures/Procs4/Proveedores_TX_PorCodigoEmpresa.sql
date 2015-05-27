CREATE Procedure [dbo].[Proveedores_TX_PorCodigoEmpresa]

@CodigoEmpresa varchar(20)

AS 

SELECT * 
FROM Proveedores
WHERE Eventual is null And CodigoEmpresa=@CodigoEmpresa