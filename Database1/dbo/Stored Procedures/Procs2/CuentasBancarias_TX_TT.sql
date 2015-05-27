CREATE Procedure [dbo].[CuentasBancarias_TX_TT]

@IdCuentaBancaria int

AS 

SELECT 
 CuentasBancarias.IdCuentaBancaria as [IdCuentaBancaria],
 CuentasBancarias.Detalle as [Detalle],
 CuentasBancarias.Cuenta as [Cuenta],
 Bancos.Nombre as [Banco],
 Monedas.Nombre as [Moneda],
 Provincias.Nombre as [Cuenta en provincia],
 CuentasBancarias.PlantillaChequera as [Plantilla chequera],
 CuentasBancarias.ChequesPorPlancha as [Cheques p/plancha],
 IsNull(CuentasBancarias.Activa,'SI') as [Activa]
FROM CuentasBancarias 
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=CuentasBancarias.IdMoneda
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=CuentasBancarias.IdProvincia
WHERE (IdCuentaBancaria=@IdCuentaBancaria)