CREATE Procedure [dbo].[Bancos_TX_MovimientosAnio]

@IdCuentaBancariaAConciliar Int

AS

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaArranqueCajaYBancos datetime

SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaArranqueCajaYBancos=ISNULL((Select FechaArranqueCajaYBancos From Parametros Where IdParametro=1),Convert(datetime,'01/01/1980'))

CREATE TABLE #Auxiliar1(Fecha DATETIME)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar1 (Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT Case When IsNull(v.Estado,'')='D' Then IsNull(v.FechaDeposito,v.FechaComprobante)
		When IsNull(v.Estado,'')='G' Then v.FechaComprobante
		Else Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End
	End
 FROM Valores v
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON v.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras bc ON dopv.IdBancoChequera=bc.IdBancoChequera
 WHERE v.FechaComprobante is not null and 
	(
	 (v.Estado='D' and v.IdCuentaBancariaDeposito=@IdCuentaBancariaAConciliar and IsNull(v.FechaDeposito,v.FechaComprobante)>=@FechaArranqueCajaYBancos) 
	 or  
	 ((v.IdTipoComprobante=17 or v.IdDetalleComprobanteProveedor is not null) and v.IdCuentaBancaria=@IdCuentaBancariaAConciliar and 
	  Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End >=@FechaArranqueCajaYBancos and 
	  not (@ActivarCircuitoChequesDiferidos='SI' and v.IdTipoValor=6 and IsNull(bc.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(v.RegistroContableChequeDiferido,'NO')='NO'))
	 or
	 (v.Estado='G' and v.IdCuentaBancaria=@IdCuentaBancariaAConciliar and v.FechaComprobante>=@FechaArranqueCajaYBancos)
	 or 
	 (not (v.IdTipoComprobante=17 or v.IdDetalleComprobanteProveedor is not null) and v.Estado is null and v.IdCuentaBancaria=@IdCuentaBancariaAConciliar and 
	  Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End >=@FechaArranqueCajaYBancos and 
	  not (@ActivarCircuitoChequesDiferidos='SI' and v.IdTipoValor=6 and IsNull(bc.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(v.RegistroContableChequeDiferido,'NO')='NO'))
	 )

SET NOCOUNT OFF

SELECT Min(Convert(varchar, Year(Fecha))) as [Período], Year(Fecha)
FROM #Auxiliar1
GROUP BY Year(Fecha) 
ORDER BY Year(Fecha) desc

DROP TABLE #Auxiliar1
