CREATE Procedure [dbo].[wDepositosBancarios_TX_PorIdConDatos]

@IdDepositoBancario int 

AS 

DECLARE @Valores numeric(18,2)

SET @Valores=IsNull((Select Sum(IsNull(Valores.Importe,0)) From DetalleDepositosBancarios DetDep
			Left Outer Join Valores On Valores.IdValor=DetDep.IdValor
			Where DetDep.IdDepositoBancario=@IdDepositoBancario),0)

SELECT 
 DepositosBancarios.*, 
 @Valores as [Valores],
 IsNull(DepositosBancarios.Efectivo,0)+@Valores as [TotalDeposito],
 CuentasBancarias.Detalle as [CuentaBancaria],
 Bancos.Nombre as [Banco],
 Cajas.Descripcion as [CajaEfectivo],
 Monedas.Abreviatura as [MonedaEfectivo]
FROM DepositosBancarios
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=DepositosBancarios.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DepositosBancarios.IdBanco
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DepositosBancarios.IdCaja
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=DepositosBancarios.IdMonedaEfectivo
WHERE DepositosBancarios.IdDepositoBancario=@IdDepositoBancario