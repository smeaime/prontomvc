CREATE Procedure [dbo].[Valores_TX_DatosParaEmisionDeCheque]

@IdValor int

AS 

SELECT 
 Valores.*,
 Case When dopv.ChequesALaOrdenDe is not null 
	Then dopv.ChequesALaOrdenDe
	Else Proveedores.ChequesALaOrdenDe
 End as [ChequesALaOrdenDe],
 dopv.NoALaOrden as [NoALaOrden],
 Proveedores.RazonSocial,
 Monedas.Nombre as [Moneda],
 CuentasBancarias.PlantillaChequera,
 CuentasBancarias.ChequesPorPlancha
FROM Valores
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Cuentas ON Valores.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
WHERE (Valores.IdValor=@IdValor)