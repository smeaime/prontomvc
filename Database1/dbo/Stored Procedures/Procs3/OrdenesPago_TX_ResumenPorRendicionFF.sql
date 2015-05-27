CREATE  Procedure [dbo].[OrdenesPago_TX_ResumenPorRendicionFF]

@IdCuentaFF int,
@NumeroRendicionFF int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteDevolucionFondoFijo int

SET @IdTipoComprobanteDevolucionFondoFijo=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoComprobanteDevolucionFondoFijo'),0)

SET NOCOUNT OFF

SELECT 
 IsNull((Select Sum(IsNull(op.Valores,0)) 
			From OrdenesPago op 
			Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=@IdCuentaFF and IsNull(op.NumeroRendicionFF,0)=0 and IsNull(op.OPInicialFF,'NO')='SI'),0)
/*
	+ IsNull((Select Sum(IsNull(op.Valores,0)) 
		  From OrdenesPago op 
		  Where IsNull(op.IdCuenta,0)=@IdCuentaFF and 
			IsNull(op.NumeroRendicionFF,0)<>0 and 
			IsNull(op.NumeroRendicionFF,0)<@NumeroRendicionFF),0)
	- IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
		  From ComprobantesProveedores cp 
		  Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=@IdCuentaFF and 
			IsNull(cp.NumeroRendicionFF,0)<@NumeroRendicionFF),0)
*/
	- IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
				From ComprobantesProveedores cp 
				Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=@IdCuentaFF and cp.IdTipoComprobante=@IdTipoComprobanteDevolucionFondoFijo),0) 
 as [FondoAsignado], 

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=@IdCuentaFF and IsNull(op.NumeroRendicionFF,0)=@NumeroRendicionFF and IsNull(op.NumeroRendicionFF,0)<>0 and 
	IsNull(op.ConfirmacionAcreditacionFF,'NO')='NO') as [PendienteAcreditar],

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=@IdCuentaFF and IsNull(op.NumeroRendicionFF,0)<@NumeroRendicionFF and IsNull(op.NumeroRendicionFF,0)<>0 and 
	IsNull(op.ConfirmacionAcreditacionFF,'NO')='NO') as [PendienteAcreditarAnteriores],

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=@IdCuentaFF and IsNull(op.NumeroRendicionFF,0)=@NumeroRendicionFF and IsNull(op.NumeroRendicionFF,0)<>0 and 
	IsNull(op.ConfirmacionAcreditacionFF,'NO')='SI') as [Acreditadas],

 IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
	 From ComprobantesProveedores cp 
	 Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=@IdCuentaFF and IsNull(cp.NumeroRendicionFF,0)<@NumeroRendicionFF),0) - 
	IsNull((Select Sum(IsNull(op.Valores,0)) 
		From OrdenesPago op 
		Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=@IdCuentaFF and IsNull(op.NumeroRendicionFF,0)<>0 and IsNull(op.ConfirmacionAcreditacionFF,'NO')='SI' and 
			IsNull(op.NumeroRendicionFF,0)<@NumeroRendicionFF),0) as [TotalPendiente]