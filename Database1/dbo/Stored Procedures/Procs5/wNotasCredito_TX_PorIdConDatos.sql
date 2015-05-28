CREATE Procedure [dbo].[wNotasCredito_TX_PorIdConDatos]

@IdNotaCredito int

AS 

SELECT 
 NotasCredito.*,
 NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito) as [Numero],
 Clientes.CodigoCliente as [CodigoCliente], 
 Clientes.RazonSocial as [Cliente], 
 DescripcionIva.Descripcion as [CondicionIVA], 
 Clientes.Cuit as [CuitCliente], 
 Monedas.Abreviatura as [Moneda],
 IsNull(Obras.NumeroObra,'') as [NumeroObra],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 (IsNull(NotasCredito.ImporteTotal,0)-IsNull(NotasCredito.ImporteIva1,0)-IsNull(NotasCredito.ImporteIva2,0) - 
	IsNull(NotasCredito.PercepcionIVA,0)-
	IsNull(NotasCredito.RetencionIBrutos1,0)-IsNull(NotasCredito.RetencionIBrutos2,0)-IsNull(NotasCredito.RetencionIBrutos3,0)-
	IsNull(NotasCredito.OtrasPercepciones1,0)-IsNull(NotasCredito.OtrasPercepciones2,0)-IsNull(NotasCredito.OtrasPercepciones3,0)) as [Subtotal],
 NotasCredito.ImporteIva1 as [Iva],
 NotasCredito.RetencionIBrutos1+NotasCredito.RetencionIBrutos2+NotasCredito.RetencionIBrutos3 as [IIBB],
 IsNull(NotasCredito.OtrasPercepciones1,0)+IsNull(NotasCredito.OtrasPercepciones2,0)+IsNull(NotasCredito.OtrasPercepciones3,0) as [OtrasPercepciones]
FROM NotasCredito
LEFT OUTER JOIN Obras ON Obras.IdObra = NotasCredito.IdObra
LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Monedas ON NotasCredito.IdMoneda = Monedas.IdMoneda
WHERE (IdNotaCredito=@IdNotaCredito)