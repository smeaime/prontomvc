





























CREATE  Procedure [dbo].[EstadoPedidos_M]
@IdEstado int,
@IdProveedor int,
@Fecha datetime,
@IdTipoComprobante int,
@IdComprobante int,
@LetraComprobante varchar(1),
@NumeroComprobante1 int,
@NumeroComprobante2 int,
@IdImputacion int,
@CodigoProveedor varchar(10),
@NumeroComprobante varchar(13),
@NumeroSAP varchar(10),
@ImporteTotal numeric(18,2),
@Saldo numeric(18,2),
@SaldoTrs numeric(18,2),
@Marca varchar(1),
@NumeroPedido int,
@SubnumeroPedido int
AS
Update EstadoPedidos
SET 
 IdProveedor=@IdProveedor,
 Fecha=@Fecha,
 IdTipoComprobante=@IdTipoComprobante,
 IdComprobante=@IdComprobante,
 LetraComprobante=@LetraComprobante,
 NumeroComprobante1=@NumeroComprobante1,
 NumeroComprobante2=@NumeroComprobante2,
 IdImputacion=@IdImputacion,
 CodigoProveedor=@CodigoProveedor,
 NumeroComprobante=@NumeroComprobante,
 NumeroSAP=@NumeroSAP,
 ImporteTotal=@ImporteTotal,
 Saldo=@Saldo,
 SaldoTrs=@SaldoTrs,
 Marca=@Marca,
 NumeroPedido=@NumeroPedido,
 SubnumeroPedido=@SubnumeroPedido
WHERE (IdEstado=@IdEstado)
Return(@IdEstado)






























