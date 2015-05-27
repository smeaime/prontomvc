CREATE Procedure [dbo].[TiposComprobante_TX_PorAbreviatura]

@DescripcionAB varchar(5)

AS 

SELECT *
FROM TiposComprobante
WHERE (DescripcionAB=@DescripcionAB)