
CREATE Procedure [dbo].[Bancos_TT]

AS 

DECLARE @vector_X varchar(40),@vector_T varchar(40),@vector_C varchar(500)
SET @vector_X='01111111111133'
SET @vector_T='05555555552900'
SET @vector_C=' Bancos : IdBanco | '+
		' T : CodigoUniversal |'+
		' |'+
		' |'+
		' |'+
		' |'+
		' T : Cuit |'

SELECT  
 Bancos.IdBanco,
 Bancos.Nombre as [Banco],
 CodigoUniversal as [Codigo unico],
 Cuentas.Codigo as [Codigo cuenta],
 Cuentas.Descripcion as [Cuenta],
 (Select Top 1 Ctas.Codigo 
	From Cuentas Ctas 
	Where Ctas.IdCuenta=Bancos.IdCuentaParaChequesDiferidos) as [Cod.cuenta cheques diferidos],
 (Select Top 1 Ctas.Descripcion 
	From Cuentas Ctas 
	Where Ctas.IdCuenta=Bancos.IdCuentaParaChequesDiferidos) as [Cuenta cheques diferidos],
 Bancos.Cuit as [Cuit],
 DescripcionIva.Descripcion as [Condicion IVA], 
 Bancos.Codigo as [Cod.p/Cobros],
 Bancos.CodigoResumen as [Cod.p/Resumen],
 @Vector_C as Vector_C,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Bancos 
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Bancos.IdCuenta
LEFT OUTER JOIN DescripcionIva ON Bancos.IdCodigoIva = DescripcionIva.IdCodigoIva 
ORDER by Bancos.Nombre
