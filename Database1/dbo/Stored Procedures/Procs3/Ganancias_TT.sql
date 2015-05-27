
CREATE Procedure [dbo].[Ganancias_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111133'
SET @vector_T='0333335300'

SELECT  
 Ganancias.IdGanancia,
 TRG.Descripcion as [Tipo],
 Ganancias.Desde,
 Ganancias.Hasta,
 Ganancias.SumaFija as [Suma fija],
 Ganancias.PorcentajeAdicional as [% Adic.],
 Ganancias.MinimoNoImponible as [Min. no imponible],
 Ganancias.MinimoARetener as [Min. a retener],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Ganancias
LEFT OUTER JOIN TiposRetencionGanancia TRG ON TRG.IdTipoRetencionGanancia=Ganancias.IdTipoRetencionGanancia
ORDER BY TRG.Descripcion,Ganancias.Desde
