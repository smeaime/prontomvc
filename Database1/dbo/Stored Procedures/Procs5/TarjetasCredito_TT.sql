CREATE Procedure [dbo].[TarjetasCredito_TT]

AS 

SELECT 
 TarjetasCredito.IdTarjetaCredito,
 TarjetasCredito.Nombre as [Tarjeta],
 TarjetasCredito.Codigo as [Codigo],
 Cuentas.Descripcion as [Cuenta contable] ,
 Monedas.Nombre as [Moneda],
 Case When IsNull(TarjetasCredito.TipoTarjeta,'P')='P' Then 'PROPIA' Else 'TERCEROS' End as [Tipo de tarjeta],
 TarjetasCredito.DiseñoRegistro as [Codigo diseño registro],
 TarjetasCredito.NumeroEstablecimiento as [Nro,Establecimiento],
 TarjetasCredito.CodigoServicio as [Cod.Servicio],
 TarjetasCredito.NumeroServicio as [Nro.Servicio]
FROM TarjetasCredito
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=TarjetasCredito.IdCuenta
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=TarjetasCredito.IdMoneda
ORDER BY TarjetasCredito.Nombre