

CREATE Procedure [dbo].[Valores_TXMes1]

@Anio int,
@Tipo varchar(2) = Null,
@IdBanco int = Null

AS

SET @Tipo=IsNull(@Tipo,'TT')
SET @IdBanco=IsNull(@IdBanco,-1)

SELECT 
 Min(CONVERT(varchar, MONTH(FechaComprobante)) + '/' + CONVERT(varchar, YEAR(FechaComprobante)) )  AS Período,
 YEAR(FechaComprobante), 
 MONTH(FechaComprobante),
 CASE 
	WHEN MONTH(FechaComprobante)=1 THEN 'Enero'
	WHEN MONTH(FechaComprobante)=2 THEN 'Febrero'
	WHEN MONTH(FechaComprobante)=3 THEN 'Marzo'
	WHEN MONTH(FechaComprobante)=4 THEN 'Abril'
	WHEN MONTH(FechaComprobante)=5 THEN 'Mayo'
	WHEN MONTH(FechaComprobante)=6 THEN 'Junio'
	WHEN MONTH(FechaComprobante)=7 THEN 'Julio'
	WHEN MONTH(FechaComprobante)=8 THEN 'Agosto'
	WHEN MONTH(FechaComprobante)=9 THEN 'Setiembre'
	WHEN MONTH(FechaComprobante)=10 THEN 'Octubre'
	WHEN MONTH(FechaComprobante)=11 THEN 'Noviembre'
	WHEN MONTH(FechaComprobante)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM Valores
WHERE YEAR(FechaComprobante)=@Anio and Valores.IdTipoValor=6 and 
	(@Tipo='TT' or 
	 (@Tipo='IN' and Valores.IdTipoComprobante<>17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBancoDeposito,0)=@IdBanco)) or 
	 (@Tipo='EG' and Valores.IdTipoComprobante=17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco)))
GROUP BY YEAR(FechaComprobante) , MONTH(FechaComprobante)  
ORDER BY YEAR(FechaComprobante)  desc , MONTH(FechaComprobante)  desc

