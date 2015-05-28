




CREATE Procedure [dbo].[OrdenesPago_EliminarOrdenesDePagoAConfirmar]

@IdOrdenPago int

AS 

Delete From DetalleOrdenesPago
Where DetalleOrdenesPago.IdOrdenPago=@IdOrdenPago and 
	Isnull((Select Top 1 OrdenesPago.Confirmado
		From OrdenesPago
		Where OrdenesPago.IdOrdenPago=DetalleOrdenesPago.IdOrdenPago),'SI')='NO'

Delete From DetalleOrdenesPagoCuentas
Where DetalleOrdenesPagoCuentas.IdOrdenPago=@IdOrdenPago and 
	Isnull((Select Top 1 OrdenesPago.Confirmado
		From OrdenesPago
		Where OrdenesPago.IdOrdenPago=DetalleOrdenesPagoCuentas.IdOrdenPago),'SI')='NO'

Delete From DetalleOrdenesPagoImpuestos
Where DetalleOrdenesPagoImpuestos.IdOrdenPago=@IdOrdenPago and 
	Isnull((Select Top 1 OrdenesPago.Confirmado
		From OrdenesPago
		Where OrdenesPago.IdOrdenPago=DetalleOrdenesPagoImpuestos.IdOrdenPago),'SI')='NO'

Delete From DetalleOrdenesPagoRubrosContables
Where DetalleOrdenesPagoRubrosContables.IdOrdenPago=@IdOrdenPago and 
	Isnull((Select Top 1 OrdenesPago.Confirmado
		From OrdenesPago
		Where OrdenesPago.IdOrdenPago=DetalleOrdenesPagoRubrosContables.IdOrdenPago),'SI')='NO'

Delete From DetalleOrdenesPagoValores
Where DetalleOrdenesPagoValores.IdOrdenPago=@IdOrdenPago and 
	Isnull((Select Top 1 OrdenesPago.Confirmado
		From OrdenesPago
		Where OrdenesPago.IdOrdenPago=DetalleOrdenesPagoValores.IdOrdenPago),'SI')='NO'

Delete From OrdenesPago
Where OrdenesPago.IdOrdenPago=@IdOrdenPago and Isnull(Confirmado,'SI')='NO'





