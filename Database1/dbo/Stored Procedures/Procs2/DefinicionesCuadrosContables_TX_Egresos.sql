





CREATE Procedure [dbo].[DefinicionesCuadrosContables_TX_Egresos]

@IdCuenta int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='03400'

SELECT 
 dcc.IdCuentaEgreso,
 Cuentas.Descripcion,
 Cuentas.Codigo,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DefinicionesCuadrosContables dcc 
LEFT OUTER JOIN Cuentas ON dcc.IdCuentaEgreso=Cuentas.IdCuenta
WHERE IsNull(dcc.IdCuentaEgreso,0)<>0 and dcc.IdCuenta=@IdCuenta
ORDER by Cuentas.Codigo





