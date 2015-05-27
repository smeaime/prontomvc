CREATE Procedure [dbo].[DescripcionIva_TX_PorId]

@IdCodigoIva tinyint 

AS 

SELECT *
FROM DescripcionIva 
WHERE (IdCodigoIva=@IdCodigoIva)