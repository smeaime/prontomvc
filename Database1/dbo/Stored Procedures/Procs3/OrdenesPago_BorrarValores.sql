
































CREATE Procedure [dbo].[OrdenesPago_BorrarValores]

@IdTipoComprobante int,
@NumeroComprobante int,
@FechaComprobante datetime

As

Delete Valores
Where 	IdTipoComprobante=@IdTipoComprobante and 
	NumeroComprobante=@NumeroComprobante and 
	FechaComprobante=@FechaComprobante

































