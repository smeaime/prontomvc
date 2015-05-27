CREATE Procedure [dbo].[DescripcionIva_TX_PorCodigoAFIP]

@CodigoAFIP int 

AS 

SELECT *
FROM DescripcionIva 
WHERE CodigoAFIP=@CodigoAFIP