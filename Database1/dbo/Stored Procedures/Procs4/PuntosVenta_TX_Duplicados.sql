





















CREATE Procedure [dbo].[PuntosVenta_TX_Duplicados]
@Letra varchar(1),
@IdTipoComprobante int,
@PuntoVenta int,
@IdPuntoVenta int
AS 
SELECT *
FROM PuntosVenta
WHERE (@IdPuntoVenta<=0 or IdPuntoVenta<>@IdPuntoVenta) And 
	Letra=@Letra And PuntoVenta=@PuntoVenta And 
	IdTipoComprobante=@IdTipoComprobante





















