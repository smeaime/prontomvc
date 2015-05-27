




CREATE Procedure [dbo].[DescripcionIva_TX_TT]
@IdCodigoIva tinyint 
AS 
SELECT *
FROM DescripcionIva 
WHERE (IdCodigoIva=@IdCodigoIva)




