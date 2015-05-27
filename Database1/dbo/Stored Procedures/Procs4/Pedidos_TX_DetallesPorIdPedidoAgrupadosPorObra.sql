
CREATE Procedure [dbo].[Pedidos_TX_DetallesPorIdPedidoAgrupadosPorObra]

@IdPedido int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 IdPedido INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetPed.IdPedido,
  Case 	When Acopios.IdObra is NOT NULL Then Acopios.IdObra
	When Requerimientos.IdObra is NOT NULL Then Requerimientos.IdObra
	Else null
  End as [IdObra]
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos On DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Monedas On Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios On DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
 LEFT OUTER JOIN Acopios On DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos On DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos On DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetPed.IdPedido=@IdPedido

SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdPedido,
 #Auxiliar1.IdObra,
 IsNull(Obras.Descripcion,'') as [Obra],
 Obras.NumeroObra,
 UnidadesOperativas.Descripcion as [UnidadOperativa]
FROM #Auxiliar1
LEFT OUTER JOIN Obras On #Auxiliar1.IdObra = Obras.IdObra
LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
WHERE #Auxiliar1.IdObra is not null
GROUP BY #Auxiliar1.IdPedido, #Auxiliar1.IdObra, Obras.NumeroObra,
	Obras.Descripcion,UnidadesOperativas.Descripcion
ORDER BY #Auxiliar1.IdPedido, #Auxiliar1.IdObra, Obras.NumeroObra

DROP TABLE #Auxiliar1
