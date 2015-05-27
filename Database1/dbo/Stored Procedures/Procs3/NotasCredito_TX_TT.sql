CREATE Procedure [dbo].[NotasCredito_TX_TT]

@IdNotaCredito int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111111133'
SET @vector_T='0290144114065555551638172655500'

SELECT 
	NotasCredito.IdNotaCredito, 
	Case When (NotasCredito.CtaCte='SI' or NotasCredito.CtaCte is null) and IdFacturaVenta_RecuperoGastos is null 
		Then 'Normal'
		Else 'Interna'
	End as [Tipo],
	NotasCredito.IdNotaCredito as [IdAux],
	NotasCredito.TipoABC as [A/B/E],
	NotasCredito.PuntoVenta as [Pto.vta.], 
	NotasCredito.NumeroNotaCredito as [Nota credito], 
	NotasCredito.FechaNotaCredito as [Fecha credito],
	NotasCredito.Anulada as [Anulada], 
	Clientes.CodigoCliente as [Cod.Cli.], 
	Clientes.RazonSocial as [Cliente], 
	DescripcionIva.Descripcion as [Condicion IVA], 
	Clientes.Cuit as [Cuit], 
	(IsNull(NotasCredito.ImporteTotal,0) - IsNull(NotasCredito.ImporteIva1,0) - IsNull(NotasCredito.ImporteIva2,0) - 
		IsNull(NotasCredito.PercepcionIVA,0) - 
		IsNull(NotasCredito.RetencionIBrutos1,0) - IsNull(NotasCredito.RetencionIBrutos2,0) - IsNull(NotasCredito.RetencionIBrutos3,0) - 
		IsNull(NotasCredito.OtrasPercepciones1,0) - IsNull(NotasCredito.OtrasPercepciones2,0) - IsNull(NotasCredito.OtrasPercepciones3,0)) as [Neto gravado],
	NotasCredito.ImporteIva1 as [Iva],
	IsNull(NotasCredito.RetencionIBrutos1,0)+IsNull(NotasCredito.RetencionIBrutos2,0)+IsNull(NotasCredito.RetencionIBrutos3,0) as [Ing.Brutos],
	NotasCredito.PercepcionIVA as [Perc.IVA],
	IsNull(NotasCredito.OtrasPercepciones1,0) + IsNull(NotasCredito.OtrasPercepciones2,0) + IsNull(NotasCredito.OtrasPercepciones3,0) as [Otras perc.],
	NotasCredito.ImporteTotal as [Total credito],
	Monedas.Abreviatura as [Mon.],
	Obras.NumeroObra as [Obra],
	Provincias.Nombre as [Provincia destino],
	NotasCredito.Observaciones,
	Vendedores.Nombre as [Vendedor],
	NotasCredito.FechaAnulacion as [Fecha anulacion], 
	Empleados.Nombre as [Ingreso],
	NotasCredito.FechaIngreso as [Fecha ingreso],
	NotasCredito.CAE as [CAE],
	NotasCredito.RechazoCAE as [Rech.CAE],
	NotasCredito.FechaVencimientoORechazoCAE as [Fecha vto.CAE],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM NotasCredito 
LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Obras ON NotasCredito.IdObra = Obras.IdObra
LEFT OUTER JOIN Vendedores ON NotasCredito.IdVendedor = Vendedores.IdVendedor
LEFT OUTER JOIN Monedas ON NotasCredito.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Provincias ON NotasCredito.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN Empleados ON NotasCredito.IdUsuarioIngreso = Empleados.IdEmpleado
WHERE NotasCredito.IdNotaCredito=@IdNotaCredito
