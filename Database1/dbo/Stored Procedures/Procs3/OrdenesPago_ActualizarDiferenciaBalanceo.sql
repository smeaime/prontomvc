





















CREATE Procedure [dbo].[OrdenesPago_ActualizarDiferenciaBalanceo]

@IdOrdenPagoAnterior int,
@IdOrdenPagoNueva int

As

Declare @IdOrdenPagoComplementariaAnterior int,@IdOrdenPagoComplementariaNueva int,
	@IdMonedaDolar int,@IdMonedaOrdenPagoAnterior int,@IdMonedaOrdenPagoNueva int
Declare @DiferenciaBalanceoAnterior numeric(18,2),@DiferenciaBalanceoNueva numeric(18,2),
	@DiferenciaBalanceoComplementariaAnterior numeric(18,2),
	@DiferenciaBalanceoComplementariaNueva numeric(18,2)

Set @IdMonedaDolar=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1)


/*	Obtener los Id de las ordenes de pago actual y anterior y sus respectivas
	complementarias si es que existen	*/
IF NOT (Select op.IdOPComplementariaFF From OrdenesPago op
	Where op.IdOrdenPago=@IdOrdenPagoAnterior) IS NULL
	Set @IdOrdenPagoComplementariaAnterior=(Select op.IdOPComplementariaFF 
						From OrdenesPago op
						Where op.IdOrdenPago=@IdOrdenPagoAnterior)
ELSE
	Set @IdOrdenPagoComplementariaAnterior=0

IF NOT (Select op.IdMoneda From OrdenesPago op
	Where op.IdOrdenPago=@IdOrdenPagoAnterior) IS NULL
	Set @IdMonedaOrdenPagoAnterior=(Select op.IdMoneda 
					From OrdenesPago op
					Where op.IdOrdenPago=@IdOrdenPagoAnterior)
ELSE
	Set @IdMonedaOrdenPagoAnterior=0

IF NOT (Select op.IdOPComplementariaFF From OrdenesPago op
	Where op.IdOrdenPago=@IdOrdenPagoNueva) IS NULL
	Set @IdOrdenPagoComplementariaNueva=(Select op.IdOPComplementariaFF 
						From OrdenesPago op
						Where op.IdOrdenPago=@IdOrdenPagoNueva)
ELSE
	Set @IdOrdenPagoComplementariaNueva=0

IF NOT (Select op.IdMoneda From OrdenesPago op
	Where op.IdOrdenPago=@IdOrdenPagoNueva) IS NULL
	Set @IdMonedaOrdenPagoNueva=(Select op.IdMoneda 
					From OrdenesPago op
					Where op.IdOrdenPago=@IdOrdenPagoNueva)
ELSE
	Set @IdMonedaOrdenPagoNueva=0

/*	Calcular la nueva diferencia de balanceo de OP anterior		*/
IF @IdOrdenPagoAnterior<>0
	BEGIN 
		IF NOT (Select Sum(cp.TotalComprobante) From ComprobantesProveedores cp
			Where 	cp.IdOrdenPago=@IdOrdenPagoAnterior or 
				cp.IdOrdenPago=@IdOrdenPagoComplementariaAnterior) IS NULL
			Set @DiferenciaBalanceoAnterior=(Select Sum(Case When @IdMonedaOrdenPagoAnterior=@IdMonedaDolar
										Then 	Case When cp.CotizacionDolar<>0 
												Then cp.TotalComprobante*cp.CotizacionMoneda/cp.CotizacionDolar
												Else 0 End
										Else cp.TotalComprobante*cp.CotizacionMoneda End)
							 From ComprobantesProveedores cp
							 Where 	cp.IdOrdenPago=@IdOrdenPagoAnterior or 
								cp.IdOrdenPago=@IdOrdenPagoComplementariaAnterior)
		ELSE
			Set @DiferenciaBalanceoAnterior=0
		
		IF NOT (Select Sum(op.Valores) From OrdenesPago op
			Where 	op.IdOrdenPago=@IdOrdenPagoAnterior or 
				op.IdOrdenPago=@IdOrdenPagoComplementariaAnterior) IS NULL
			Set @DiferenciaBalanceoAnterior=@DiferenciaBalanceoAnterior - 
				(Select Sum(op.Valores) From OrdenesPago op 
				 Where 	op.IdOrdenPago=@IdOrdenPagoAnterior or 
					op.IdOrdenPago=@IdOrdenPagoComplementariaAnterior)

		Update OrdenesPago
		Set DiferenciaBalanceo=@DiferenciaBalanceoAnterior
		Where IdOrdenPago=@IdOrdenPagoAnterior
	END

/*	Calcular la nueva diferencia de balanceo de OP nueva		*/
IF @IdOrdenPagoNueva<>0
	BEGIN 
		IF NOT (Select Sum(cp.TotalComprobante) From ComprobantesProveedores cp
			Where 	cp.IdOrdenPago=@IdOrdenPagoNueva or 
				cp.IdOrdenPago=@IdOrdenPagoComplementariaNueva) IS NULL
			Set @DiferenciaBalanceoNueva=(Select Sum(Case When @IdMonedaOrdenPagoNueva=@IdMonedaDolar
									Then 	Case When cp.CotizacionDolar<>0 
											Then cp.TotalComprobante*cp.CotizacionMoneda/cp.CotizacionDolar
											Else 0 End
									Else cp.TotalComprobante*cp.CotizacionMoneda End)
							 From ComprobantesProveedores cp
							 Where 	cp.IdOrdenPago=@IdOrdenPagoNueva or 
								cp.IdOrdenPago=@IdOrdenPagoComplementariaNueva)
		ELSE
			Set @DiferenciaBalanceoNueva=0
		
		IF NOT (Select Sum(op.Valores) From OrdenesPago op
			Where 	op.IdOrdenPago=@IdOrdenPagoNueva or 
				op.IdOrdenPago=@IdOrdenPagoComplementariaNueva) IS NULL
			Set @DiferenciaBalanceoNueva=@DiferenciaBalanceoNueva - 
				(Select Sum(op.Valores) From OrdenesPago op 
				 Where 	op.IdOrdenPago=@IdOrdenPagoNueva or 
					op.IdOrdenPago=@IdOrdenPagoComplementariaNueva)

		Update OrdenesPago
		Set DiferenciaBalanceo=@DiferenciaBalanceoNueva
		Where IdOrdenPago=@IdOrdenPagoNueva
	END

/*	Calcular la nueva diferencia de balanceo de OP anterior complementaria		*/
IF @IdOrdenPagoComplementariaAnterior<>0
	BEGIN 
		IF NOT (Select Sum(cp.TotalComprobante) From ComprobantesProveedores cp
			Where 	cp.IdOrdenPago=@IdOrdenPagoAnterior or 
				cp.IdOrdenPago=@IdOrdenPagoComplementariaAnterior) IS NULL
			Set @DiferenciaBalanceoComplementariaAnterior=(Select Sum(Case When @IdMonedaOrdenPagoAnterior=@IdMonedaDolar
											Then 	Case When cp.CotizacionDolar<>0 
													Then cp.TotalComprobante*cp.CotizacionMoneda/cp.CotizacionDolar
													Else 0 End
											Else cp.TotalComprobante*cp.CotizacionMoneda End)
									From ComprobantesProveedores cp
									Where 	cp.IdOrdenPago=@IdOrdenPagoAnterior or 
										cp.IdOrdenPago=@IdOrdenPagoComplementariaAnterior)
		ELSE
			Set @DiferenciaBalanceoComplementariaAnterior=0

		IF NOT (Select Sum(op.Valores) From OrdenesPago op
			Where 	op.IdOrdenPago=@IdOrdenPagoAnterior or 
				op.IdOrdenPago=@IdOrdenPagoComplementariaAnterior) IS NULL
			Set @DiferenciaBalanceoComplementariaAnterior=@DiferenciaBalanceoComplementariaAnterior - 
				(Select Sum(op.Valores) From OrdenesPago op 
				 Where 	op.IdOrdenPago=@IdOrdenPagoAnterior or 
					op.IdOrdenPago=@IdOrdenPagoComplementariaAnterior)

		Update OrdenesPago
		Set DiferenciaBalanceo=@DiferenciaBalanceoComplementariaAnterior
		Where IdOrdenPago=@IdOrdenPagoComplementariaAnterior
	END

/*	Calcular la nueva diferencia de balanceo de OP nueva complementaria		*/
IF @IdOrdenPagoComplementariaNueva<>0
	BEGIN 
		IF NOT (Select Sum(cp.TotalComprobante) From ComprobantesProveedores cp
			Where 	cp.IdOrdenPago=@IdOrdenPagoNueva or 
				cp.IdOrdenPago=@IdOrdenPagoComplementariaNueva) IS NULL
			Set @DiferenciaBalanceoComplementariaNueva=(Select Sum(Case When @IdMonedaOrdenPagoNueva=@IdMonedaDolar
											Then 	Case When cp.CotizacionDolar<>0 
													Then cp.TotalComprobante*cp.CotizacionMoneda/cp.CotizacionDolar
													Else 0 End
											Else cp.TotalComprobante*cp.CotizacionMoneda End)
									From ComprobantesProveedores cp
									Where 	cp.IdOrdenPago=@IdOrdenPagoNueva or 
										cp.IdOrdenPago=@IdOrdenPagoComplementariaNueva)
		ELSE
			Set @DiferenciaBalanceoComplementariaNueva=0

		IF NOT (Select Sum(op.Valores) From OrdenesPago op
			Where 	op.IdOrdenPago=@IdOrdenPagoNueva or 
				op.IdOrdenPago=@IdOrdenPagoComplementariaNueva) IS NULL
			Set @DiferenciaBalanceoComplementariaNueva=@DiferenciaBalanceoComplementariaNueva - 
				(Select Sum(op.Valores) From OrdenesPago op 
				 Where 	op.IdOrdenPago=@IdOrdenPagoNueva or 
					op.IdOrdenPago=@IdOrdenPagoComplementariaNueva)

		Update OrdenesPago
		Set DiferenciaBalanceo=@DiferenciaBalanceoComplementariaNueva
		Where IdOrdenPago=@IdOrdenPagoComplementariaNueva
	END






















