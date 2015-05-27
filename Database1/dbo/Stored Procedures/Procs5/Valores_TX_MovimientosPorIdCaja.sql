
CREATE Procedure [dbo].[Valores_TX_MovimientosPorIdCaja]

@IdCaja Int,
@FechaDesde datetime,
@FechaHasta datetime,
@Todos int

AS 

SET NOCOUNT ON

DECLARE @FechaArranqueCajaYBancos datetime, @IdMonedaPesos int, @IdMonedaCaja int, @Saldo as numeric(18,2)

SET @FechaArranqueCajaYBancos=IsNull((Select FechaArranqueCajaYBancos From Parametros Where IdParametro=1),Convert(datetime,'01/01/1980'))
SET @IdMonedaPesos=IsNull((Select IdMoneda From Parametros Where IdParametro=1),1)
SET @IdMonedaCaja=IsNull((Select IdMoneda From Cajas Where IdCaja=@IdCaja),1)
SET @Saldo=0

DECLARE @vector_X varchar(30),@vector_T varchar(30)

IF @IdMonedaCaja=@IdMonedaPesos
	BEGIN
		SET @vector_X='01111166666661111111133'
		SET @vector_T='03990044499993034222A00'
	END
ELSE
	BEGIN
		SET @vector_X='01111166666661111111133'
		SET @vector_T='03990044414443034222A00'
	END

CREATE TABLE #Auxiliar1(Ingresos NUMERIC(18, 2), Egresos NUMERIC(18, 2), 
			IngresosPesos NUMERIC(18, 2), EgresosPesos NUMERIC(18, 2))
IF @Todos<>-1
    BEGIN
	INSERT INTO #Auxiliar1 
	SELECT 
	 Case 	When 	((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
						 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			 (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
						 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
			and not Valores.IdTipoComprobante=14
		 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
				 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
				 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
			End 
		 Else Null 
	 End as [Ingresos],
	 Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
			Valores.IdTipoComprobante=14
		 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
				 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
				 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
			End 
		 Else Null 
	 End as [Egresos],
	 Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
		 Then 	Case When ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				    Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
				  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				    Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
				  and not Valores.IdTipoComprobante=14
				Then 	Case 	When Valores.Importe * 
							Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
										From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
										From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				Else Null 
			End * Isnull(Valores.CotizacionMoneda,1) 
		 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)>0
				Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)
				Else Null
			End
	 End as [Ingresos $],
	 Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
	 	 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
				  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
				  Valores.IdTipoComprobante=14
				Then 	Case 	When Valores.Importe * 
							Isnull((Select top 1 TiposComprobante.Coeficiente
								From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
										From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
										From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				Else Null 
			End * Isnull(Valores.CotizacionMoneda,1) 
		 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)<0
				Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) * -1
				Else Null
			End
	 End as [Egresos $]
	FROM Valores 
	LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
	LEFT OUTER JOIN Cuentas ON OrdenesPago.IdCuenta = Cuentas.IdCuenta
	WHERE Valores.IdCaja is not null and Valores.IdCaja=@IdCaja and IsNull(Valores.Anulado,'NO')<>'SI' and 
		Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
			Then Valores.FechaDeposito
			Else Valores.FechaComprobante 
		End>=@FechaArranqueCajaYBancos and 
		(Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
				Then Valores.FechaDeposito
				Else Valores.FechaComprobante 
		 End<@FechaDesde)
    END

SET NOCOUNT OFF

SELECT 
 0 as [IdValor],
 'INI' as [Tipo],
 0 as [IdVal],
 0 as [IdCaja],
 Null as [Conc.],
 Null as [Mon.],
 Sum(IsNull(Ingresos,0)) as [Ingresos],
 Sum(IsNull(Egresos,0)) as [Egresos],
 @Saldo as [Saldo],
 Null as [Conv.a $],
 Sum(IsNull(IngresosPesos,0)) as [Ingresos $],
 Sum(IsNull(EgresosPesos,0)) as [Egresos $],
 @Saldo as [Saldo $],
 Null as [Iva],
 Null as [Tipo Comp.],
 Null as [Comp.],
 @FechaDesde as [Fec.Comp.],
 Null as [Cliente],
 Null as [Proveedor],
 Null as [Cuenta contable],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

UNION ALL

SELECT 
 Valores.IdValor as [IdValor],
 (Select top 1 TiposComprobante.DescripcionAb
  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.IdValor as [IdVal],
 Valores.IdCaja as [IdCaja],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Monedas.Abreviatura as [Mon.],
 Case 	When 	((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		 (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
		and not Valores.IdTipoComprobante=14
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
 End as [Ingresos],
 Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
		Valores.IdTipoComprobante=14
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
 End as [Egresos],
 @Saldo as [Saldo],
 Valores.CotizacionMoneda as [Conv.a $],
 Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
	 Then 	Case When ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			    Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			    Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
			  and not Valores.IdTipoComprobante=14
			Then 	Case 	When Valores.Importe * 
						Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
					 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
				End 
			Else Null 
		End * Isnull(Valores.CotizacionMoneda,1) 
	 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)>0
			Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)
			Else Null
		End
 End as [Ingresos $],
 Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
 	 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
			  Valores.IdTipoComprobante=14
			Then 	Case 	When Valores.Importe * 
						Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
					 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
				End 
			Else Null 
		End * Isnull(Valores.CotizacionMoneda,1) 
	 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)<0
			Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) * -1
			Else Null
		End
 End as [Egresos $],
 @Saldo as [Saldo $],
 Null as [Iva],
 tc.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
	Then Valores.FechaDeposito
	Else Valores.FechaComprobante 
 End as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 Cuentas.Descripcion as [Cuenta contable],
 IsNull(Convert(varchar(4000),OrdenesPago.Observaciones),Convert(varchar(4000),Recibos.Observaciones)) as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores = drv.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas = drc.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON IsNull(drv.IdRecibo,drc.IdRecibo) = Recibos.IdRecibo
LEFT OUTER JOIN Cuentas ON IsNull(OrdenesPago.IdCuenta,Recibos.IdCuenta) = Cuentas.IdCuenta
WHERE Valores.IdCaja is not null and Valores.IdCaja=@IdCaja and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
		Then Valores.FechaDeposito
		Else Valores.FechaComprobante 
	End>=@FechaArranqueCajaYBancos and 
	(@Todos=-1 or 
		(Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
				Then Valores.FechaDeposito
				Else Valores.FechaComprobante 
		 End between @FechaDesde and @FechaHasta))

ORDER BY [Fec.Comp.], [Comp.]

DROP TABLE #Auxiliar1
