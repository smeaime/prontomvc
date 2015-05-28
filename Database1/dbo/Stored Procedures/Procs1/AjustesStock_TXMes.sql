CREATE Procedure [dbo].[AjustesStock_TXMes]

@Anio int,
@TipoAjuste varchar(1) = Null

AS

SET @TipoAjuste=IsNull(@TipoAjuste,'*')

SELECT Min(CONVERT(varchar,MONTH(FechaAjuste)) + '/' + CONVERT(varchar, YEAR(FechaAjuste)) )  as [Periodo],
 YEAR(FechaAjuste), 
 MONTH(FechaAjuste),
 CASE 
	WHEN MONTH(FechaAjuste)=1 THEN 'Enero'
	WHEN MONTH(FechaAjuste)=2 THEN 'Febrero'
	WHEN MONTH(FechaAjuste)=3 THEN 'Marzo'
	WHEN MONTH(FechaAjuste)=4 THEN 'Abril'
	WHEN MONTH(FechaAjuste)=5 THEN 'Mayo'
	WHEN MONTH(FechaAjuste)=6 THEN 'Junio'
	WHEN MONTH(FechaAjuste)=7 THEN 'Julio'
	WHEN MONTH(FechaAjuste)=8 THEN 'Agosto'
	WHEN MONTH(FechaAjuste)=9 THEN 'Setiembre'
	WHEN MONTH(FechaAjuste)=10 THEN 'Octubre'
	WHEN MONTH(FechaAjuste)=11 THEN 'Noviembre'
	WHEN MONTH(FechaAjuste)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM AjustesStock  
WHERE YEAR(FechaAjuste)=@Anio and 
	((@TipoAjuste='*' and (IsNull(AjustesStock.TipoAjuste,'N')='N' or IsNull(AjustesStock.TipoAjuste,'N')='I')) or @TipoAjuste=IsNull(AjustesStock.TipoAjuste,'N'))
GROUP BY YEAR(FechaAjuste), MONTH(FechaAjuste)  
ORDER BY YEAR(FechaAjuste)  desc, MONTH(FechaAjuste)  desc