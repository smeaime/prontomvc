
CREATE Procedure [dbo].[TarifasFletes_TT]

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111133'
SET @vector_T='0444414400'

SELECT 
 TarifasFletes.IdTarifaFlete,
 TarifasFletes.Codigo as [Codigo],
 TarifasFletes.Descripcion as [Descripcion],
 TarifasFletes.LimiteInferior as [Limite inf.],
 TarifasFletes.LimiteSuperior as [Limite sup.],
 Unidades.Abreviatura as [Unidad],
 TarifasFletes.ValorUnitario as [Valor unit.],
 TarifasFletes.FechaVigencia as [Fecha vigencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM TarifasFletes
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=TarifasFletes.IdUnidad
ORDER BY Codigo, LimiteInferior