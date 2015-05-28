CREATE Procedure [dbo].[ListasPrecios_TX_DetallesPorId]

@IdListaPrecios int,
@IdCliente int = Null

AS 

SET NOCOUNT ON

SET @IdCliente=IsNull(@IdCliente,-1)

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='01E0444444444700'
ELSE
	SET @vector_T='01E9499999999900'

SELECT 
 lpd.IdListaPreciosDetalle,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Descripcion],
 Clientes.RazonSocial as [Cliente],
 lpd.Precio as [Precio1],
 lpd.Precio2 as [Precio2],
 lpd.Precio3 as [Precio3],
 lpd.Precio4 as [Precio4],
 lpd.Precio5 as [Precio5],
 lpd.Precio6 as [Precio6],
 lpd.Precio7 as [Precio7],
 lpd.Precio8 as [Precio8],
 lpd.Precio9 as [Precio9],
 lpd.FechaVigenciaHasta as [Fecha vigencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ListasPreciosDetalle lpd
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=lpd.IdArticulo
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=lpd.IdCliente
WHERE lpd.IdListaPrecios=@IdListaPrecios and (@IdCliente=-1 or IsNull(lpd.IdCliente,0)=@IdCliente)
ORDER by Clientes.RazonSocial, lpd.IdCliente, Articulos.Codigo