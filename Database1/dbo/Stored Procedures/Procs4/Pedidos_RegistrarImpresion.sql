CREATE Procedure [dbo].[Pedidos_RegistrarImpresion]

@IdPedido int,
@Marca varchar(2),
@MarcarEnvioProveedor varchar(2) = Null,
@FechaEnvioProveedor datetime = Null,
@IdUsuarioEnvioProveedor int = Null

AS

SET @MarcarEnvioProveedor=IsNull(@MarcarEnvioProveedor,'')

UPDATE Pedidos
SET Impresa=@Marca
WHERE (IdPedido=@IdPedido)

IF @MarcarEnvioProveedor='SI'
	UPDATE Pedidos
	SET FechaEnvioProveedor=@FechaEnvioProveedor, IdUsuarioEnvioProveedor=@IdUsuarioEnvioProveedor
	WHERE (IdPedido=@IdPedido)

RETURN(@IdPedido)