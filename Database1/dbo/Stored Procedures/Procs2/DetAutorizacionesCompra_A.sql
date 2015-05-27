
CREATE Procedure [dbo].[DetAutorizacionesCompra_A]

@IdDetalleAutorizacionCompra int  output,
@IdAutorizacionCompra int,
@IdArticulo int,
@Cantidad numeric(18,2),
@IdUnidad int,
@Observaciones ntext

AS 

INSERT INTO [DetalleAutorizacionesCompra]
(
 IdAutorizacionCompra,
 IdArticulo,
 Cantidad,
 IdUnidad,
 Observaciones
)
VALUES 
(
 @IdAutorizacionCompra,
 @IdArticulo,
 @Cantidad,
 @IdUnidad,
 @Observaciones
)

SELECT @IdDetalleAutorizacionCompra=@@identity
RETURN(@IdDetalleAutorizacionCompra)
