










CREATE Procedure [dbo].[Monedas_TT]
AS 
Select 
 IdMoneda,
 Nombre as [Denominacion],
 Abreviatura as [Abreviatura],
 CodigoAFIP as [Codigo AFIP],
 GeneraImpuestos as [Genera ret.?]
FROM Monedas
ORDER by Nombre










