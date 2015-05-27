  
alter Procedure [dbo].[wRecibos_TX_PorIdConDatos]  
  
@IdRecibo int  
  
AS   
  
SELECT   
 Recibos.*,   
 Case When Recibos.Tipo='CC' Then 'Cta. cte.'   
 When Recibos.Tipo='OT' Then 'Otros'   
 Else ''  
 End as [TipoRecibo],  
 Clientes.CodigoCliente as [CodigoCliente],   
 Clientes.RazonSocial as [Cliente],  
 Monedas.Abreviatura as [Moneda],  
 IsNull(Recibos.Otros1,0)+IsNull(Recibos.Otros2,0)+IsNull(Recibos.Otros3,0)+IsNull(Recibos.Otros4,0)+IsNull(Recibos.Otros5,0)+   
 IsNull(Recibos.Otros6,0)+IsNull(Recibos.Otros7,0)+IsNull(Recibos.Otros8,0)+IsNull(Recibos.Otros9,0)+IsNull(Recibos.Otros10,0) as [OtrosConceptos],  
 Cuentas.Descripcion as [Cuenta],  
 IsNull(Obras.NumeroObra,'') as [NumeroObra]
 ,   Obras.NumeroObra+' '+Obras.Descripcion  COLLATE DATABASE_DEFAULT as [Obra]  
FROM Recibos  
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente   
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta  
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda  
LEFT OUTER JOIN Obras ON Obras.IdObra = Recibos.IdObra  
WHERE (Recibos.IdRecibo=@IdRecibo)  
  
  go
  
  wRecibos_TX_PorIdConDatos 1