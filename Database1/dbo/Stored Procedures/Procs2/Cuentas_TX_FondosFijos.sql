
CREATE Procedure [dbo].[Cuentas_TX_FondosFijos]

@IdCuentaFF int = Null

AS 

DECLARE @IdTipoCuentaGrupoFF INT
SET @IdTipoCuentaGrupoFF=(Select Top 1 Parametros.IdTipoCuentaGrupoFF
				From Parametros Where IdParametro=1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0595900'

SELECT 
 IdCuenta,
 Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo],
 IdCuenta as [IdAux],
 NumeroAuxiliar as [Prox.Nro.Rend.],
 NumeroAuxiliar as [IdAux1],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Cuentas
WHERE IdTipoCuentaGrupo=@IdTipoCuentaGrupoFF and 
	(IsNull(@IdCuentaFF,-1)=-1 or IsNull(@IdCuentaFF,-1)=IdCuenta) and 
	Len(LTrim(Descripcion))>0
--GROUP By IdCuenta, Codigo, Descripcion
ORDER by Descripcion
