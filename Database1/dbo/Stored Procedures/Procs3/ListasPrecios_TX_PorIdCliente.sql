CREATE Procedure [dbo].[ListasPrecios_TX_PorIdCliente]

@IdCliente int

AS 

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='01D333600'
ELSE
	SET @vector_T='01E499900'

SELECT 
 lpd.IdListaPreciosDetalle,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Descripcion],
 lpd.Precio3 as [Precio3],
 lpd.Precio6 as [Precio6],
 lpd.Precio9 as [Precio9],
 lpd.FechaVigenciaHasta as [Fecha vigencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ListasPreciosDetalle lpd
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=lpd.IdArticulo
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=lpd.IdCliente
WHERE lpd.IdCliente=@IdCliente
ORDER BY Articulos.Codigo