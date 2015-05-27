





























CREATE Procedure [dbo].[ControlesCalidad_TX_Alfabetico]
AS 
Select 
IdControlCalidad,
Descripcion as [Control],
Inspeccion as [Inspeccion],
Abreviatura as [Abreviatura],
Detalle as [Detalle]
FROM ControlesCalidad
ORDER BY Descripcion






























