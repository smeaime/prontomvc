CREATE Procedure [dbo].[FondosFijos_TX_Resumen]

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoFF INT

SET @IdTipoCuentaGrupoFF=IsNull((Select Top 1 IdTipoCuentaGrupoFF From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 Descripcion VARCHAR(100),
			 NumeroRendicion INTEGER,
			 FondosAsignados NUMERIC(18, 2),
			 ReposicionSolicitada NUMERIC(18, 2),
			 ReposicionPendiente NUMERIC(18, 2),
			 RendicionesReintegradas NUMERIC(18, 2),
			 PagosPendientesReintegrar NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
SELECT 
 Cuentas.IdCuenta,
 Cuentas.Descripcion + ' ' + Convert(varchar,Codigo),
 Cuentas.NumeroAuxiliar,

 IsNull((Select Sum(IsNull(op.Valores,0)) 
	 From OrdenesPago op 
	 Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)=0 and IsNull(op.OPInicialFF,'NO')='SI'),0), 

 IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
	 From ComprobantesProveedores cp 
	 Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=Cuentas.IdCuenta and IsNull(cp.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar),0), 

 IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
	 From ComprobantesProveedores cp 
	 Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=Cuentas.IdCuenta and IsNull(cp.NumeroRendicionFF,0)<Cuentas.NumeroAuxiliar),0) - 
	IsNull((Select Sum(IsNull(op.Valores,0)) 
		From OrdenesPago op 
		Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)<>0 and IsNull(op.ConfirmacionAcreditacionFF,'NO')='SI' and IsNull(op.NumeroRendicionFF,0)<Cuentas.NumeroAuxiliar),0),

(Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar and IsNull(op.ConfirmacionAcreditacionFF,'NO')='SI'),

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)<=Cuentas.NumeroAuxiliar and IsNull(op.ConfirmacionAcreditacionFF,'NO')='NO')
FROM Cuentas
WHERE Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoFF and Len(LTrim(IsNull(Cuentas.Descripcion,'')))>0 

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50) 
SET @vector_X='01111111133' 
SET @vector_T='00255555500' 

SELECT 
 IdCuenta,
 Descripcion as [Cuenta FF],
 NumeroRendicion as [Rendicion],
 FondosAsignados as [Fondos asignados],
 ReposicionSolicitada as [Reposicion solicitada],
 ReposicionPendiente as [Reposicion pendiente],
 RendicionesReintegradas as [Rendiciones reintegradas],
 IsNull(FondosAsignados,0)-IsNull(ReposicionSolicitada,0)-IsNull(ReposicionPendiente,0)+IsNull(RendicionesReintegradas,0) as [Saldo],
 PagosPendientesReintegrar as [PagosPendientesReintegrar],
 @Vector_T as [Vector_T],
 @Vector_X as [Vector_X]
FROM #Auxiliar1
ORDER BY Descripcion

DROP TABLE #Auxiliar1