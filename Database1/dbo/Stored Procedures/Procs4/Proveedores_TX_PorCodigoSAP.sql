﻿































CREATE Procedure [dbo].[Proveedores_TX_PorCodigoSAP]
@CodigoSAP varchar(10)
AS 
SELECT * 
FROM Proveedores
WHERE Eventual is null And CodigoEmpresa=@CodigoSAP































