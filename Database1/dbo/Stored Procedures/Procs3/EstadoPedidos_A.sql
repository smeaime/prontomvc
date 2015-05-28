





























CREATE Procedure [dbo].[EstadoPedidos_A]
@IdEstado int  output,
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
Insert into EstadoPedidos
(
 IdProveedor,
 Fecha,
 IdTipoComprobante,
 IdComprobante,
 LetraComprobante,
 NumeroComprobante1,
 NumeroComprobante2,
 IdImputacion,
 CodigoProveedor,
 NumeroComprobante,
 NumeroSAP,
 ImporteTotal,
 Saldo,
 SaldoTrs,
 Marca,
 NumeroPedido,
 SubnumeroPedido
)
Values
(
 @IdProveedor,
 @Fecha,
 @IdTipoComprobante,
 @IdComprobante,
 @LetraComprobante,
 @NumeroComprobante1,
 @NumeroComprobante2,
 @IdImputacion,
 @CodigoProveedor,
 @NumeroComprobante,
 @NumeroSAP,
 @ImporteTotal,
 @Saldo,
 @SaldoTrs,
 @Marca,
 @NumeroPedido,
 @SubnumeroPedido
)
Select @IdEstado=@@identity
Return(@IdEstado)






























