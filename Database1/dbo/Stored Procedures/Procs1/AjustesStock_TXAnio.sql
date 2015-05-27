CREATE Procedure [dbo].[AjustesStock_TXAnio]

@TipoAjuste varchar(1) = Null

AS

SET @TipoAjuste=IsNull(@TipoAjuste,'*')

SELECT Min(CONVERT(varchar,YEAR(AJ.FechaAjuste)))  as [Periodo], YEAR(AJ.FechaAjuste) as [Año]
FROM AjustesStock AJ
WHERE AJ.FechaAjuste is not null and 
	((@TipoAjuste='*' and (IsNull(AJ.TipoAjuste,'N')='N' or IsNull(AJ.TipoAjuste,'N')='I')) or @TipoAjuste=IsNull(AJ.TipoAjuste,'N'))
GROUP BY YEAR(AJ.FechaAjuste) 
ORDER BY YEAR(AJ.FechaAjuste)  desc