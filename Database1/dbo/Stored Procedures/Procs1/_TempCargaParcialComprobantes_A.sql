CREATE Procedure [dbo].[_TempCargaParcialComprobantes_A]

@Fecha datetime,
@IdEntidad int,
@IdTipoComprobante int,
@IdPuntoVenta int,
@NumeroComprobante int,
@IdArticulo int,
@IdColor int,
@Talle varchar(2),
@Cantidad numeric(18,2),
@IdUsuario int,
@Orden int

AS 

INSERT INTO [_TempCargaParcialComprobantes]
(
 Fecha,
 IdEntidad,
 IdTipoComprobante,
 IdPuntoVenta,
 NumeroComprobante,
 IdArticulo,
 IdColor,
 Talle,
 Cantidad,
 IdUsuario,
 Orden
)
VALUES
(
 @Fecha,
 @IdEntidad,
 @IdTipoComprobante,
 @IdPuntoVenta,
 @NumeroComprobante,
 @IdArticulo,
 @IdColor,
 @Talle,
 @Cantidad,
 @IdUsuario,
 @Orden
)