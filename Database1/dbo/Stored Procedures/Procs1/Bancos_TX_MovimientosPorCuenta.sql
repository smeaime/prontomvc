CREATE Procedure [dbo].[Bancos_TX_MovimientosPorCuenta]

@IdCuentaBancariaAConciliar Int,
@FechaDesde datetime,
@FechaHasta datetime,
@Todos int

AS 

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaArranqueCajaYBancos datetime, @IdTarjetaCredito int, 
		@IdMonedaPesos int, @IdMonedaCaja int, @Saldo as numeric(18,2), @IdBanco int

SET @ActivarCircuitoChequesDiferidos=IsNull((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaArranqueCajaYBancos=IsNull((Select FechaArranqueCajaYBancos From Parametros Where IdParametro=1),Convert(datetime,'01/01/1980'))
SET @IdMonedaPesos=IsNull((Select IdMoneda From Parametros Where IdParametro=1),1)
SET @IdMonedaCaja=IsNull((Select IdMoneda From CuentasBancarias Where IdCuentaBancaria=@IdCuentaBancariaAConciliar),1)
SET @IdTarjetaCredito=IsNull((Select IdTipoComprobanteTarjetaCredito From Parametros Where IdParametro=1),0)
SET @IdBanco=IsNull((Select IdBanco From CuentasBancarias Where IdCuentaBancaria=@IdCuentaBancariaAConciliar),0)
SET @Saldo=0

DECLARE @vector_X varchar(50),@vector_T varchar(50)

IF @IdMonedaCaja=@IdMonedaPesos
	BEGIN
		Set @vector_X='0111166166611111111111161111111111133'
		Set @vector_T='0099333399994034024444320132422232500'
	END
ELSE
	BEGIN
		Set @vector_X='0111166166611111111111161111111111133'
		Set @vector_T='0099333313334034024444320132422232500'
	END

CREATE TABLE #Auxiliar1(Ingresos NUMERIC(18, 2), Egresos NUMERIC(18, 2), IngresosPesos NUMERIC(18, 2), EgresosPesos NUMERIC(18, 2))

IF @Todos<>-1
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT Valores.Importe, Null, Valores.Importe * Isnull(Valores.CotizacionMoneda,1), Null
	 FROM Valores 
	 WHERE ((Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=@IdCuentaBancariaAConciliar) or 
			(Valores.IdTipoValor=@IdTarjetaCredito and Valores.IdBanco=@IdBanco and Valores.IdTipoComprobante=2)) and 
			IsNull(Valores.Anulado,'NO')<>'SI' and 
			IsNull(Valores.FechaDeposito,Valores.FechaComprobante)>=@FechaArranqueCajaYBancos and 
			IsNull(Valores.FechaDeposito,Valores.FechaComprobante)<@FechaDesde 

	INSERT INTO #Auxiliar1 
	 SELECT Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
					Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
					Else Null 
			End,
			Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
					Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
					Else Null 
			End,
			Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
					Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
					Else Null 
			End * Isnull(Valores.CotizacionMoneda,1),
			Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
					Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
					Else Null 
			End * Isnull(Valores.CotizacionMoneda,1)
	 FROM Valores 
	 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	 WHERE (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
				Then 	Case When (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor) is not null
						Then (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor)
						Else Valores.FechaValor
					End
				Else Valores.FechaComprobante 
			End<@FechaDesde and 
			Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
				Then 	Case When (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor) is not null
						Then (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor)
						Else Valores.FechaValor
					End
				Else Valores.FechaComprobante 
			End>=@FechaArranqueCajaYBancos and 
			not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
				IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
				IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

	INSERT INTO #Auxiliar1 
	 SELECT Case When TiposComprobante.Coeficiente=-1 Then Valores.Importe Else Null End,
			Case When TiposComprobante.Coeficiente=1 Then Valores.Importe Else Null End,
			Case When TiposComprobante.Coeficiente=-1 Then Valores.Importe Else Null End * Isnull(Valores.CotizacionMoneda,1),
			Case When TiposComprobante.Coeficiente=1 Then Valores.Importe Else Null End * Isnull(Valores.CotizacionMoneda,1)
	 FROM Valores 
	 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
	 WHERE Valores.Estado='G' And Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.FechaComprobante<@FechaDesde and Valores.FechaComprobante>=@FechaArranqueCajaYBancos

	INSERT INTO #Auxiliar1 
	 SELECT Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select Top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				Then Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
							Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
							Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					 End 
				Else Null 
			End,
			Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				Then Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
							Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
							Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					 End 
				Else Null 
			End,
			Case When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
				Then Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
						Then Case When Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
									Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
									Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
							 End 
						Else Null 
					 End * Isnull(Valores.CotizacionMoneda,1) 
				Else Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)>0 Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) Else Null End
			End,
			Case When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
				Then Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
						Then Case When Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 				Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
								Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
							 End 
						Else Null 
					 End * Isnull(Valores.CotizacionMoneda,1) 
				Else Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)<0 Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) * -1 Else Null End
			End
	 FROM Valores 
	 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	 LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
	 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	 WHERE NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			Valores.Estado is null and IsNull(Valores.Anulado,'NO')<>'SI' and 
			Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and 
			Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
				Then 	Case When (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor) is not null
						Then (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor)
						Else Valores.FechaValor
					End
				Else Valores.FechaComprobante 
			End<@FechaDesde and 
			Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
				Then 	Case When (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor) is not null
						Then (Select Top 1 Asientos.FechaAsiento 
							From DetalleAsientos da 
							Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
							Where da.IdValor=Valores.IdValor)
						Else Valores.FechaValor
					End
				Else Valores.FechaComprobante 
			End>=@FechaArranqueCajaYBancos and 
			not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
				IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
				IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')
   END

SET NOCOUNT OFF

SELECT 
 0 as [IdValor],
 'INI' as [Tipo],
 0 as [IdVal],
 @IdCuentaBancariaAConciliar as [IdCta],
 Null as [Numero valor],
 Sum(IsNull(Ingresos,0)) as [Ingresos],
 Sum(IsNull(Egresos,0)) as [Egresos],
 @Saldo as [Saldo],
 Null as [Conv.a $],
 Sum(IsNull(IngresosPesos,0)) as [Ingresos $],
 Sum(IsNull(EgresosPesos,0)) as [Egresos $],
 @Saldo as [Saldo $],
 @FechaDesde as [Fec.Comp.],
 Null as [Conc.],
 Null as [Confirmado],
 Null as [Fecha conf.],
 Null as [Cuenta],
 Null as [Nro.Extracto],
 Null as [Fec.Extracto],
 Null as [Nro.Int.],
 Null as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Null as [Iva],
 Null as [Mon.],
 Null as [Banco origen],
 Null as [Tipo Comp.],
 Null as [Comp.],
 Null as [Fecha Orig.],
 Null as [Cliente],
 Null as [Proveedor],
 Null as [Cuenta contable],
 Null as [Detalle],
 Null as [As.Ch.Dif.],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

UNION ALL 

SELECT 
 Valores.IdValor as [IdValor],
 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.IdValor as [IdVal],
 @IdCuentaBancariaAConciliar as [IdCta],
 Valores.NumeroValor as [Numero valor],
 Valores.Importe as [Ingresos],
 Null as [Egresos],
 @Saldo as [Saldo],
 Valores.CotizacionMoneda as [Conv.a $],
 Valores.Importe * Isnull(Valores.CotizacionMoneda,1) as [Ingresos $],
 Null as [Egresos $],
 @Saldo as [Saldo $],
 Case When Valores.FechaDeposito is not null Then Valores.FechaDeposito Else Valores.FechaComprobante End as [Fec.Comp.],
 Case When Valores.Conciliado is null Then 'NO' Else Valores.Conciliado End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null Then 'NO' Else Valores.MovimientoConfirmadoBanco End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Valores.FechaDeposito as [Fecha dep.],
 Valores.NumeroDeposito as [Nro. dep.],
 Null as [Iva],
 Monedas.Abreviatura as [Mon.],
 Bancos.Nombre as [Banco origen],
 TiposComprobante.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fecha Orig.],
 Clientes.RazonSocial as [Cliente],
 Null as [Proveedor],
 Null as [Cuenta contable],
 Valores.Detalle as [Detalle],
 Null as [As.Ch.Dif.],
 Recibos.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancariaDeposito=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleRecibosValores drv ON drv.IdDetalleReciboValores=Valores.IdDetalleReciboValores
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo = drv.IdRecibo
WHERE ((Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=@IdCuentaBancariaAConciliar) or 
		(Valores.IdTipoValor=@IdTarjetaCredito and Valores.IdBanco=@IdBanco and Valores.IdTipoComprobante=2)) and 
		IsNull(Valores.Anulado,'NO')<>'SI' and 
		IsNull(Valores.FechaDeposito,Valores.FechaComprobante)>=@FechaArranqueCajaYBancos and 
		(@Todos=-1 or (IsNull(Valores.FechaDeposito,Valores.FechaComprobante) between @FechaDesde and @FechaHasta))

UNION ALL 

SELECT 
 Valores.IdValor as [IdValor],
 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.IdValor as [IdVal],
 @IdCuentaBancariaAConciliar as [IdCta],
 Valores.NumeroValor as [Numero valor],
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else Null 
 End as [Ingresos],
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else Null 
 End as [Egresos],
 @Saldo as [Saldo],
 Valores.CotizacionMoneda as [Conv.a $], 
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else Null 
 End * Isnull(Valores.CotizacionMoneda,1) as [Ingresos $],
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else Null 
 End * Isnull(Valores.CotizacionMoneda,1) as [Egresos $],
 @Saldo as [Saldo $],
 Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then Case When (Select Top 1 Asientos.FechaAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor) is not null
					Then (Select Top 1 Asientos.FechaAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor)
					Else Valores.FechaValor
			 End
		Else Valores.FechaComprobante 
 End as [Fec.Comp.],
 Case When Valores.Conciliado is null Then 'NO' Else Valores.Conciliado End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null Then 'NO' Else Valores.MovimientoConfirmadoBanco End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Null as [Iva],
 Monedas.Abreviatura as [Mon.],
 Null as [Banco origen],
 tc.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 OrdenesPago.FechaOrdenPago as [Fecha Orig.],
 Null as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 Cuentas.Descripcion as [Cuenta contable],
 Valores.Detalle as [Detalle],
 (Select Top 1 Asientos.NumeroAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor) as [As.Ch.Dif.],
 OrdenesPago.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Cuentas ON OrdenesPago.IdCuenta = Cuentas.IdCuenta
WHERE (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	 Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(@Todos=-1 or 
	 (Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then 	Case When (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor) is not null
				Then (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor)
				Else Valores.FechaValor
			End
		Else Valores.FechaComprobante 
	  End between @FechaDesde and @FechaHasta)) and 

	Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then 	Case When (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor) is not null
				Then (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor)
				Else Valores.FechaValor
			End
		Else Valores.FechaComprobante 
	End>=@FechaArranqueCajaYBancos and 

	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

UNION ALL 

SELECT 
 Valores.IdValor as [IdValor],
 'GS' as [Tipo],
 Valores.IdValor as [IdVal],
 @IdCuentaBancariaAConciliar as [IdCta],
 Null as [Numero valor],
 Case When TiposComprobante.Coeficiente=-1 Then Valores.Importe Else Null End as [Ingresos],
 Case When TiposComprobante.Coeficiente=1 Then Valores.Importe Else Null End as [Egresos],
 @Saldo as [Saldo],
 Valores.CotizacionMoneda as [Conv.a $],
 Case When TiposComprobante.Coeficiente=-1 Then Valores.Importe Else Null End * Isnull(Valores.CotizacionMoneda,1) as [Ingresos $],
 Case When TiposComprobante.Coeficiente=1 Then Valores.Importe Else Null End * Isnull(Valores.CotizacionMoneda,1) as [Egresos $],
 @Saldo as [Saldo $],
 Valores.FechaComprobante as [Fec.Comp.],
 Case When Valores.Conciliado is null Then 'NO' Else Valores.Conciliado End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null Then 'NO' Else Valores.MovimientoConfirmadoBanco End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 Null as [Nro.Int.],
 Null as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Valores.Iva as [Iva],
 Monedas.Abreviatura as [Mon.],
 Null as [Banco origen],
 TiposComprobante.DescripcionAb as [Tipo Comp.], Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fecha Orig.],
 Null as [Cliente],
 Null as [Proveedor],
 Null as [Cuenta contable],
 Valores.Detalle as [Detalle],
 Null as [As.Ch.Dif.],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
WHERE Valores.Estado='G' And Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(@Todos=-1 or (Valores.FechaComprobante between @FechaDesde and @FechaHasta)) and 
	Valores.FechaComprobante>=@FechaArranqueCajaYBancos

UNION ALL 

SELECT
 Valores.IdValor as [IdValor],
 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.IdValor as [IdVal],
 @IdCuentaBancariaAConciliar as [IdCta],
 Valores.NumeroValor as [Numero valor],
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
		Then Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
				Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
				Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
			 End 
		Else Null 
 End as [Ingresos],
 Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
		Then Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
				Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
				Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
			 End 
		Else Null 
 End as [Egresos],
 @Saldo as [Saldo],
 Valores.CotizacionMoneda as [Conv.a $],
 Case When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
		Then Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
					Then Case When Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
								Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
								Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
						 End 
					Else Null 
			 End * Isnull(Valores.CotizacionMoneda,1) 
		Else Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)>0 Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) Else Null End
 End as [Ingresos $],
 Case When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
		Then Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
						Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
					Then Case When Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
								Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
								Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
						 End 
					Else Null 
			 End * Isnull(Valores.CotizacionMoneda,1) 
		Else Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)<0 Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) * -1 Else Null End
 End as [Egresos $],
 @Saldo as [Saldo $],
 Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then Case When (Select Top 1 Asientos.FechaAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor) is not null
					Then (Select Top 1 Asientos.FechaAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor)
					Else Valores.FechaValor
			 End
		Else Valores.FechaComprobante 
 End as [Fec.Comp.],
 Case When Valores.Conciliado is null Then 'NO' Else Valores.Conciliado End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null Then 'NO' Else Valores.MovimientoConfirmadoBanco End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Null as [Iva],
 Monedas.Abreviatura as [Mon.],
 Null as [Banco origen],
 tc.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 OrdenesPago.FechaOrdenPago as [Fecha Orig.],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 Cuentas.Descripcion as [Cuenta contable],
 Valores.Detalle as [Detalle],
 (Select Top 1 Asientos.NumeroAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor) as [As.Ch.Dif.],
 OrdenesPago.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Cuentas ON OrdenesPago.IdCuenta = Cuentas.IdCuenta
WHERE NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	Valores.Estado is null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.IdCuentaBancaria=@IdCuentaBancariaAConciliar and 
	(@Todos=-1 or 
	 (Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then 	Case When (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor) is not null
				Then (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor)
				Else Valores.FechaValor
			End
		Else Valores.FechaComprobante 
	  End between @FechaDesde and @FechaHasta)) and 

	Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then 	Case When (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor) is not null
				Then (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor)
				Else Valores.FechaValor
			End
		Else Valores.FechaComprobante 
	End>=@FechaArranqueCajaYBancos and 

	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

ORDER BY [Fec.Comp.], [Comp.]

DROP TABLE #Auxiliar1