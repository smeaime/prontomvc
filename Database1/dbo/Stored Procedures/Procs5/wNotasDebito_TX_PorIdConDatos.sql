CREATE Procedure [dbo].[wNotasDebito_TX_PorIdConDatos]

@IdNotaDebito int

AS 

SELECT 
 NotasDebito.*,
 NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito) as [Numero],
 Clientes.CodigoCliente as [CodigoCliente], 
 Clientes.RazonSocial as [Cliente], 
 DescripcionIva.Descripcion as [CondicionIVA], 
 Clientes.Cuit as [CuitCliente], 
 Monedas.Abreviatura as [Moneda],
 IsNull(Obras.NumeroObra,'') as [NumeroObra],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 (IsNull(NotasDebito.ImporteTotal,0)-IsNull(NotasDebito.ImporteIva1,0)-IsNull(NotasDebito.ImporteIva2,0) - 
	IsNull(NotasDebito.PercepcionIVA,0)-
	IsNull(NotasDebito.RetencionIBrutos1,0)-IsNull(NotasDebito.RetencionIBrutos2,0)-IsNull(NotasDebito.RetencionIBrutos3,0)-
	IsNull(NotasDebito.OtrasPercepciones1,0)-IsNull(NotasDebito.OtrasPercepciones2,0)-IsNull(NotasDebito.OtrasPercepciones3,0)) as [Subtotal],
 NotasDebito.ImporteIva1 as [Iva],
 NotasDebito.RetencionIBrutos1+NotasDebito.RetencionIBrutos2+NotasDebito.RetencionIBrutos3 as [IIBB],
 IsNull(NotasDebito.OtrasPercepciones1,0)+IsNull(NotasDebito.OtrasPercepciones2,0)+IsNull(NotasDebito.OtrasPercepciones3,0) as [OtrasPercepciones]
FROM NotasDebito
LEFT OUTER JOIN Obras ON Obras.IdObra = NotasDebito.IdObra
LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Monedas ON NotasDebito.IdMoneda = Monedas.IdMoneda
WHERE (IdNotaDebito=@IdNotaDebito)