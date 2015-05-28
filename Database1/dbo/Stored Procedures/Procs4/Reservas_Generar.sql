






















CREATE Procedure [dbo].[Reservas_Generar]

AS

TRUNCATE TABLE _TempReservasStock

INSERT INTO _TempReservasStock
 SELECT
  DetLA.IdDetalleAcopios,
  'Acopio',
  Acopios.NumeroAcopio, 
  Acopios.Nombre,
  DetLA.NumeroItem,
  Acopios.IdObra,
  Obras.NumeroObra,
  (Select Top 1 Equipos.Tag From Equipos 
   Where Equipos.IdEquipo=(Select Top 1 LMateriales.IdEquipo 
			 From LMateriales
			 Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales 
							  From DetalleLMateriales
							  Where DetalleLMateriales.IdDetalleAcopios=DetLA.IdDetalleAcopios))),
  Articulos.Descripcion,
  DetLA.Cantidad,
  Unidades.Abreviatura,
  (SELECT Sum(Stock.CantidadUnidades) 
	FROM Stock
	WHERE Stock.IdArticulo=DetLA.IdArticulo),
  (SELECT Sum(dr.CantidadUnidades) 
	FROM DetalleReservas dr
	WHERE dr.IdArticulo=DetLA.IdArticulo),
  Null,
  Null,
  Empleados.Nombre,
  DetLA.FechaNecesidad,
  DetLA.Observaciones,
  Acopios.IdAcopio,
  Null,
  DetLA.IdArticulo,
  DetLA.IdUnidad
 FROM DetalleAcopios DetLA
 LEFT OUTER JOIN Acopios ON DetLA.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN Obras ON Acopios.IdObra = Obras.IdObra
 LEFT OUTER JOIN Empleados ON Acopios.Realizo=Empleados.IdEmpleado
 LEFT OUTER JOIN Articulos ON DetLA.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Unidades ON DetLA.IdUnidad = Unidades.IdUnidad
 WHERE Acopios.Aprobo is not null AND DetLA.IdAproboAlmacen is null

 UNION ALL

 SELECT
  DetRM.IdDetalleRequerimiento,
  'R.M.',
  Requerimientos.NumeroRequerimiento,
  Null,
  DetRM.NumeroItem,
  Requerimientos.IdObra,
  Obras.NumeroObra,
  (Select Top 1 Equipos.Tag From Equipos 
   Where Equipos.IdEquipo=(Select Top 1 LMateriales.IdEquipo 
			 From LMateriales
			 Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales 
							  From DetalleLMateriales
							  Where DetalleLMateriales.IdDetalleLMateriales=DetRM.IdDetalleLMateriales))),
  Articulos.Descripcion,
  DetRM.Cantidad,
  Unidades.Abreviatura,
  (SELECT Sum(Stock.CantidadUnidades) 
	FROM Stock
	WHERE Stock.IdArticulo=DetRM.IdArticulo),
  (SELECT Sum(dr.CantidadUnidades) 
	FROM DetalleReservas dr
	WHERE dr.IdArticulo=DetRM.IdArticulo),
  Null,
  Null,
  Empleados.Nombre,
  DetRM.FechaEntrega,
  DetRM.Observaciones,
  Null,
  Requerimientos.IdRequerimiento,
  DetRM.IdArticulo,
  DetRM.IdUnidad
 FROM DetalleRequerimientos DetRM
 LEFT OUTER JOIN Requerimientos ON DetRM.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
 LEFT OUTER JOIN Empleados ON Requerimientos.IdSolicito=Empleados.IdEmpleado
 LEFT OUTER JOIN Articulos ON DetRM.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Unidades ON DetRM.IdUnidad = Unidades.IdUnidad
 WHERE Requerimientos.Aprobo is not null and DetRM.IdAproboAlmacen is null and 
	 (Requerimientos.DirectoACompras is null or Requerimientos.DirectoACompras='NO')






















