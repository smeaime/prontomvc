
CREATE Procedure [dbo].[wFondosFijos_TX_ResumenPorIdCuenta]
@IdCuentaFF INT

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
	 Where IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)=0 and 
		IsNull(op.OPInicialFF,'NO')='SI'),0) as [Fondo asignado], 

 IsNull((Select Sum(IsNull(cp.TotalComprobante,0)) 
	 From ComprobantesProveedores cp 
	 Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=Cuentas.IdCuenta and 
		IsNull(cp.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar),0) as [Reposicion solicitada], 

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar and 
	IsNull(op.ConfirmacionAcreditacionFF,'NO')='SI') as [Rendiciones reintegradas],

 (Select Sum(IsNull(op.Valores,0)) 
  From OrdenesPago op 
  Where IsNull(op.IdCuenta,0)=Cuentas.IdCuenta and IsNull(op.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar and 
	IsNull(op.ConfirmacionAcreditacionFF,'NO')='NO') as [Pagos pendientes de reintegrar]
FROM Cuentas
WHERE Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoFF and Len(LTrim(IsNull(Cuentas.Descripcion,'')))>0 

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50) 
SET @vector_X='0111111133' 
SET @vector_T='0028888800' 

SELECT 
 IdCuenta,
 Descripcion as [Cuenta FF],
 NumeroRendicion as [Rendicion],
 FondosAsignados as [Fondos asignados],
 ReposicionSolicitada as [Reposicion solicitada],
 RendicionesReintegradas as [Rendiciones reintegradas],
 IsNull(FondosAsignados,0)-IsNull(ReposicionSolicitada,0)+IsNull(RendicionesReintegradas,0) as [Saldo],
 PagosPendientesReintegrar as [PagosPendientesReintegrar],
 @Vector_T as [Vector_T],
 @Vector_X as [Vector_X]
FROM #Auxiliar1
where IdCuenta=@IdCuentaFF
ORDER BY Descripcion

DROP TABLE #Auxiliar1

