

CREATE Procedure [dbo].[Valores_TXAnio]

@Tipo varchar(2) = Null,
@IdBanco int = Null

AS

SET @Tipo=IsNull(@Tipo,'TT')
SET @IdBanco=IsNull(@IdBanco,-1)

SELECT Min(CONVERT(varchar, YEAR(FechaComprobante))) as [Período], YEAR(FechaComprobante)
FROM Valores
WHERE Valores.IdTipoValor=6 and 
	(@Tipo='TT' or 
	 (@Tipo='IN' and Valores.IdTipoComprobante<>17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBancoDeposito,0)=@IdBanco)) or 
	 (@Tipo='EG' and Valores.IdTipoComprobante=17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco)))
GROUP BY YEAR(FechaComprobante) 
ORDER BY YEAR(FechaComprobante)  desc

