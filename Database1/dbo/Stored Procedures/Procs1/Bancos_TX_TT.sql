
CREATE Procedure [dbo].[Bancos_TX_TT]

@IdBanco int

AS 

SELECT
 Bancos.IdBanco,
 Bancos.Nombre as [Banco],
 CodigoUniversal as [Codigo unico],
 Cuentas.Codigo as [Codigo cuenta],
 Cuentas.Descripcion as [Cuenta],
 Ctas.Codigo as [Cod.cuenta cheques diferidos],
 Ctas.Descripcion as [Cuenta cheques diferidos],
 Bancos.Cuit as [Cuit],
 DescripcionIva.Descripcion as [Condicion IVA], 
 Bancos.Codigo as [Cod.p/Cobros],
 Bancos.CodigoResumen as [Cod.p/Resumen]
FROM Bancos 
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Bancos.IdCuenta
LEFT OUTER JOIN Cuentas Ctas ON Ctas.IdCuenta=Bancos.IdCuentaParaChequesDiferidos
LEFT OUTER JOIN DescripcionIva ON Bancos.IdCodigoIva = DescripcionIva.IdCodigoIva 
WHERE (IdBanco=@IdBanco)
