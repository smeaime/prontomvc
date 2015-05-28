










CREATE Procedure [dbo].[Monedas_TX_TT]
@IdMoneda int
AS 
SELECT 
 IdMoneda,
 Nombre as [Denominacion],
 Abreviatura as [Abreviatura],
 CodigoAFIP as [Codigo AFIP],
 GeneraImpuestos as [Genera ret.?]
FROM Monedas
WHERE (IdMoneda=@IdMoneda)











