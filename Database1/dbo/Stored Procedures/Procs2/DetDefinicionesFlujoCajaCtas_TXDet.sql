CREATE PROCEDURE [dbo].[DetDefinicionesFlujoCajaCtas_TXDet]

@IdDefinicionFlujoCaja int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111133'
Set @vector_T='0IH59900'

SELECT 
 dfc.IdDetalleDefinicionFlujoCaja as [IdAux],
 Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion as [Cuenta contable],
 Convert(varchar,RubrosContables.Codigo)+' '+RubrosContables.Descripcion as [Rubro],
 dfc.OtroConcepto as [Otros conceptos],
 Case When dfc.IdCuenta=0 Then Null Else dfc.IdCuenta End as [IdCuenta],
 Case When dfc.IdRubroContable=0 Then Null Else dfc.IdRubroContable End as [IdRubroContable],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDefinicionesFlujoCajaCuentas dfc 
LEFT OUTER JOIN Cuentas ON dfc.IdCuenta = Cuentas.IdCuenta 
LEFT OUTER JOIN RubrosContables ON dfc.IdRubroContable = RubrosContables.IdRubroContable 
WHERE (dfc.IdDefinicionFlujoCaja = @IdDefinicionFlujoCaja)
ORDER by [Rubro], [Cuenta contable], dfc.OtroConcepto