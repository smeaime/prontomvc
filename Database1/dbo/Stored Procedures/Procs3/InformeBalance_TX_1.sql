







CREATE PROCEDURE [dbo].[InformeBalance_TX_1]

@FechaDesde datetime,
@FechaHasta datetime

AS

SELECT
 Cuentas.IdCuenta,
 Cuentas.Codigo as [Cuenta],
 Cuentas.Jerarquia,
 Cuentas.Descripcion as [Detalle],
 CONVERT(MONEY,Null) as [Saldo inicial],
 SUM(DetAsi.Debe) as [Saldo deudor],
 SUM(DetAsi.Haber) as [Saldo acreedor],
 CONVERT(money,Null) as [Saldo final],
 CONVERT(varchar(30),Null) as Vector_T,
 CONVERT(varchar(30),Null) as Vector_X
FROM DetalleAsientos DetAsi
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta = Cuentas.IdCuenta
WHERE Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta
GROUP BY Cuentas.IdCuenta,Cuentas.Jerarquia,Cuentas.Codigo,Cuentas.Descripcion







