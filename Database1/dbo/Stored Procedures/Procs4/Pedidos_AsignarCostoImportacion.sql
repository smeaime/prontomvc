CREATE Procedure [dbo].[Pedidos_AsignarCostoImportacion]

@IdDetallePedido int,
@CostoAsignado numeric(18,4),
@CostoAsignadoDolar numeric(18,4),
@IdUsuarioAsignoCosto int

As

Declare @IdArticulo int
Set @IdArticulo=IsNull((Select Top 1 DetallePedidos.IdArticulo
			From DetallePedidos 
			Where DetallePedidos.IdDetallePedido=@IdDetallePedido),0)
Update Articulos
Set 
	CostoReposicion=@CostoAsignado,
	CostoReposicionDolar=@CostoAsignadoDolar
Where IdArticulo=@IdArticulo

Update [DetallePedidos]
Set 
 CostoAsignado=@CostoAsignado,
 CostoAsignadoDolar=@CostoAsignadoDolar,
 IdUsuarioAsignoCosto=@IdUsuarioAsignoCosto,
 FechaAsignacionCosto=GetDate()
Where (IdDetallePedido=@IdDetallePedido)