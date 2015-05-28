CREATE Procedure [dbo].[Bancos_TX_MovimientosMes]

@IdCuentaBancariaAConciliar Int,
@Anio int

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

SELECT Min(Convert(varchar, Month(Fecha)) + '/' + Convert(varchar, Year(Fecha))) as [Período],
 Year(Fecha), Month(Fecha),
 Case 
	When Month(Fecha)=1 Then 'Enero'
	When Month(Fecha)=2 Then 'Febrero'
	When Month(Fecha)=3 Then 'Marzo'
	When Month(Fecha)=4 Then 'Abril'
	When Month(Fecha)=5 Then 'Mayo'
	When Month(Fecha)=6 Then 'Junio'
	When Month(Fecha)=7 Then 'Julio'
	When Month(Fecha)=8 Then 'Agosto'
	When Month(Fecha)=9 Then 'Setiembre'
	When Month(Fecha)=10 Then 'Octubre'
	When Month(Fecha)=11 Then 'Noviembre'
	When Month(Fecha)=12 Then 'Diciembre'
	ELSE 'Error'
 End as [Mes]
FROM #Auxiliar1
WHERE Year(Fecha)=@Anio
GROUP BY Year(Fecha), Month(Fecha)  
ORDER BY Year(Fecha) desc, Month(Fecha) desc

DROP TABLE #Auxiliar1
