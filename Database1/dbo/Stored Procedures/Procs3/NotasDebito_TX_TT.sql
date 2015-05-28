CREATE Procedure [dbo].[NotasDebito_TX_TT]

@IdNotaDebito int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111111111133'
SET @vector_T='029013411406555555163817032655500'

SELECT 
	NotasDebito.IdNotaDebito, 
	Case When (NotasDebito.CtaCte='SI' or NotasDebito.CtaCte is null) and IdNotaCreditoVenta_RecuperoGastos is null 
		Then 'Normal'
		Else 'Interna'
	End as [Tipo],
	NotasDebito.IdNotaDebito as [IdAux],
	NotasDebito.TipoABC AS [A/B/E],
	NotasDebito.PuntoVenta AS [Pto.vta.], 
	NotasDebito.NumeroNotaDebito AS [Nota debito], 
	NotasDebito.FechaNotaDebito AS [Fecha debito],
	NotasDebito.Anulada AS [Anulada], 
	Clientes.CodigoCliente AS [Cod.Cli.], 
	Clientes.RazonSocial AS [Cliente], 
	DescripcionIva.Descripcion as [Condicion IVA], 
	Clientes.Cuit AS [Cuit], 
	(IsNull(NotasDebito.ImporteTotal,0)-IsNull(NotasDebito.ImporteIva1,0)-IsNull(NotasDebito.ImporteIva2,0) - 
		IsNull(NotasDebito.PercepcionIVA,0)-
		IsNull(NotasDebito.RetencionIBrutos1,0)-IsNull(NotasDebito.RetencionIBrutos2,0)-IsNull(NotasDebito.RetencionIBrutos3,0)-
		IsNull(NotasDebito.OtrasPercepciones1,0)-IsNull(NotasDebito.OtrasPercepciones2,0)-IsNull(NotasDebito.OtrasPercepciones3,0)) as [Neto gravado],
	NotasDebito.ImporteIva1 as [Iva],
	IsNull(NotasDebito.RetencionIBrutos1,0)+IsNull(NotasDebito.RetencionIBrutos2,0)+IsNull(NotasDebito.RetencionIBrutos3,0) as [Ing.Brutos],
	NotasDebito.PercepcionIVA as [Perc.IVA],
	IsNull(NotasDebito.OtrasPercepciones1,0)+IsNull(NotasDebito.OtrasPercepciones2,0)+IsNull(NotasDebito.OtrasPercepciones3,0) as [Otras perc.],
	NotasDebito.ImporteTotal as [Total debito],
	Monedas.Abreviatura as [Mon.],
	Obras.NumeroObra as [Obra],
	Provincias.Nombre as [Provincia destino],
	NotasDebito.Observaciones,
	Vendedores.Nombre AS [Vendedor],
	NotasDebito.FechaAnulacion AS [Fecha anulacion], 
	Articulos.Descripcion as [Venta en cuotas de],
	NotasDebito.NumeroCuota as [Nro.Cuota],
	Empleados.Nombre as [Ingreso],
	NotasDebito.FechaIngreso as [Fecha ingreso],
	NotasDebito.CAE as [CAE],
	NotasDebito.RechazoCAE as [Rech.CAE],
	NotasDebito.FechaVencimientoORechazoCAE as [Fecha vto.CAE],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM NotasDebito 
LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON  IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Obras ON NotasDebito.IdObra = Obras.IdObra
LEFT OUTER JOIN Vendedores ON NotasDebito.IdVendedor = Vendedores.IdVendedor
LEFT OUTER JOIN Monedas ON NotasDebito.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN VentasEnCuotas ON NotasDebito.IdVentaEnCuotas = VentasEnCuotas.IdVentaEnCuotas
LEFT OUTER JOIN Articulos ON VentasEnCuotas.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Provincias ON NotasDebito.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN Empleados ON NotasDebito.IdUsuarioIngreso = Empleados.IdEmpleado
WHERE NotasDebito.IdNotaDebito=@IdNotaDebito