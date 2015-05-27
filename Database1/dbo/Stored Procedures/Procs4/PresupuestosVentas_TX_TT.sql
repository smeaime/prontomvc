CREATE Procedure [dbo].[PresupuestosVentas_TX_TT]

@IdPresupuestoVenta int

AS

SET NOCOUNT ON
DECLARE @ConsolidacionDeBDs varchar(2)
SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111133'
SET @vector_T='03944520454444400'

SELECT 
 PresupuestosVentas.IdPresupuestoVenta, 
 PresupuestosVentas.Numero as [Numero], 
 PresupuestosVentas.IdPresupuestoVenta as [IdAux1],
 PresupuestosVentas.Fecha as [Fecha], 
 Case When IsNull(PresupuestosVentas.TipoVenta,1)=1 Then 'Normal' Else 'Muestra' End as [Tipo venta],
 Case When IsNull(PresupuestosVentas.TipoOperacion,'P')='P' Then 'Presupuesto' Else 'Devolucion' End as [Tipo operacion],
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial as [Cliente], 
 PresupuestosVentas.ImporteTotal as [Total],
 Clientes.Cuit as [Cuit], 
 Clientes.Telefono as [Telefono del cliente], 
 Vendedores.Nombre as [Vendedor],
 PresupuestosVentas.Observaciones as [Observaciones],
 Case When IsNull(PresupuestosVentas.Estado,'')='C' Then 'Cerrado' When IsNull(PresupuestosVentas.Estado,'')='P' Then 'Fac.Parcial' When IsNull(PresupuestosVentas.Estado,'')='A' Then 'Anulado' Else 'Pendiente' End as [Estado],
 (Select Count(*) From DetallePresupuestosVentas df Where df.IdPresupuestoVenta=PresupuestosVentas.IdPresupuestoVenta) as [Cant.Items],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PresupuestosVentas 
LEFT OUTER JOIN Clientes ON PresupuestosVentas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Vendedores ON IsNull(PresupuestosVentas.IdVendedor,Clientes.Vendedor1) = Vendedores.IdVendedor
WHERE PresupuestosVentas.IdPresupuestoVenta=@IdPresupuestoVenta and 
	((@ConsolidacionDeBDs='NO' and IsNull(PresupuestosVentas.TipoVenta,1)=1) or (@ConsolidacionDeBDs='SI' and IsNull(PresupuestosVentas.TipoVenta,1)=2))
ORDER BY PresupuestosVentas.Fecha,PresupuestosVentas.Numero