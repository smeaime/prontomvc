















CREATE Procedure [dbo].[VentasEnCuotas_TX_PorIdClienteParaCombo]
@IdCliente int
AS 
SELECT 
 vec.IdVentaEnCuotas,
 Articulos.Descripcion as [Titulo]
FROM VentasEnCuotas vec
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
WHERE vec.IdCliente=@IdCliente
ORDER by Articulos.Descripcion















