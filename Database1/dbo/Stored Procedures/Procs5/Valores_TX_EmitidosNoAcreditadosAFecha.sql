CREATE  Procedure [dbo].[Valores_TX_EmitidosNoAcreditadosAFecha]

@Fecha datetime,
@IdBanco Int = Null

AS

SET @IdBanco=IsNull(@IdBanco,-1)

SELECT Sum(IsNull(Valores.Importe,0)) as [Importe]
FROM Valores 
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoValor=TiposComprobante.IdTipoComprobante
WHERE Valores.FechaComprobante<=@Fecha and 
	IsNull(Valores.Anulado,'NO')<>'SI' and 
	IsNull(Valores.IdTipoComprobante,0)=17 and 
	(IsNull(TiposComprobante.Agrupacion1,'')='CHEQUES' or Valores.IdTipoValor=21) and 
	(IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO' or (IsNull(Valores.MovimientoConfirmadoBanco,'NO')='SI' and Valores.FechaConfirmacionBanco>@Fecha)) and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco)