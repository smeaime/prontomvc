CREATE PROCEDURE [dbo].[Recibos_TXFecha]

@Desde datetime,
@Hasta datetime

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111166666111111133'
SET @vector_T='0192521122044456262600200'

SELECT 
	Recibos.IdRecibo, 
	Recibos.PuntoVenta AS [Pto.vta.], 
	Recibos.IdRecibo as [IdAux], 
	Recibos.NumeroRecibo AS [Recibo], 
	Recibos.FechaRecibo AS [Fecha Recibo], 
	Case When Recibos.Tipo='CC' Then 'Cta. cte.' When Recibos.Tipo='OT' Then 'Otros' Else '' End as [Tipo],
	Recibos.Anulado AS [Anulado], 
	Clientes.CodigoCliente AS [Cod.Cli.], 
	Clientes.RazonSocial AS [Cliente],
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>Recibos.FechaRecibo 
		Order By dc.FechaCambio),Cuentas.Descripcion) AS [Cuenta],
	Monedas.Abreviatura AS [Mon.],
	Recibos.Deudores AS [Deudores],
	Recibos.Valores AS [Total valores],
	Recibos.RetencionIVA AS [Ret.IVA],
	Recibos.RetencionGanancias AS [Ret.Ganancias],
	IsNull(Recibos.Otros1,0)+IsNull(Recibos.Otros2,0)+IsNull(Recibos.Otros3,0)+IsNull(Recibos.Otros4,0)+IsNull(Recibos.Otros5,0)+ 
		IsNull(Recibos.Otros6,0)+IsNull(Recibos.Otros7,0)+IsNull(Recibos.Otros8,0)+IsNull(Recibos.Otros9,0)+IsNull(Recibos.Otros10,0) as [Otros conceptos],
	E1.Nombre as [Ingreso],
	Recibos.FechaIngreso as [Fecha ingreso],
	E2.Nombre as [Modifico],
	Recibos.FechaModifico as [Fecha modif.],
	V1.Nombre as [Vendedor],
	V2.Nombre as [Cobrador],
	Recibos.Observaciones AS [Observaciones],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Recibos 
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Recibos.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Recibos.IdUsuarioModifico
LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor = Recibos.IdVendedor
LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor = Recibos.IdCobrador
WHERE Recibos.FechaRecibo between @Desde and @hasta
ORDER BY Recibos.FechaRecibo,Recibos.NumeroRecibo