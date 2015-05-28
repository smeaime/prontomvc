






CREATE Procedure [dbo].[Acopios_TX_DatosAcopio]

@IdDetalleAcopios int

AS 

SELECT 
 DetAco.IdDetalleAcopios,
 DetAco.NumeroItem,
 DetAco.IdArticulo,
 DetAco.IdUnidad,
 DetAco.Cantidad,
 DetAco.Cantidad1,
 DetAco.Cantidad2,
 DetAco.IdControlCalidad,
 DetAco.IdCuenta,
 DetAco.Observaciones,
 Acopios.IdAcopio,
 Acopios.Fecha,
 Acopios.NumeroAcopio,
 Acopios.Aprobo,
 Articulos.Descripcion as [DescripcionArt],
 Unidades.Descripcion as [Unidad en],
 (Select Sum(DetRec.Cantidad)
  From DetalleRecepciones DetRec
  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
  Where DetAco.IdDetalleAcopios=DetRec.IdDetalleAcopios and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
 DetAco.Cantidad - Isnull((Select Sum(DetRec.Cantidad)
 				From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetalleAcopios=DetAco.IdDetalleAcopios and 
					(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0)
 as [Pendiente],
 Acopios.IdObra as [IdObra],
 Obras.NumeroObra as [Obra],
 Clientes.RazonSocial as [Cliente],
 Equipos.Descripcion as [Equipo],
 Articulos.Codigo
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetAco.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON Acopios.IdObra = Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Equipos ON DetAco.IdEquipo = Equipos.IdEquipo
WHERE (DetAco.IdDetalleAcopios=@IdDetalleAcopios)






