




















CREATE PROCEDURE [dbo].[DetPedidos_TX_TodosSinPrecios]

@IdPedido int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0010011101101111101000011110000000000001133'
set @vector_T='0000001100000449900000031310000000000003300'

SELECT
 DetPed.IdDetallePedido,
 DetPed.IdPedido,
 DetPed.NumeroItem as [Item],
 DetPed.IdDetalleAcopios,
 DetPed.IdDetalleRequerimiento,
 DetPed.Cantidad as [Cant.],
 DetPed.Cantidad1 as [Med.1],
 DetPed.Cantidad2 as [Med.2],
 DetPed.IdUnidad,
 ( SELECT Unidades.Descripcion
 	FROM Unidades
	WHERE Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
 Substring(ControlesCalidad.Descripcion,1,10) as [Control de Calidad],
 DetPed.IdArticulo,
 Articulos.Descripcion as Articulo,
 DetPed.FechaEntrega as [F.entrega],
 DetPed.FechaNecesidad as [F.necesidad],
 DetPed.Precio,
 (DetPed.Cantidad*DetPed.Precio) as Importe,
 DetPed.IdControlCalidad,
 DetPed.Cumplido as [Cum],
 CASE 
	WHEN Acopios.IdObra IS NOT NULL THEN  Acopios.IdObra
	WHEN Requerimientos.IdObra IS NOT NULL THEN Requerimientos.IdObra
	ELSE null
 END as [IdObra],
 DetPed.Adjunto,
 DetPed.ArchivoAdjunto,
 DetPed.Observaciones,
 Acopios.NumeroAcopio as [Nro.Acopio],
 DetalleAcopios.NumeroItem as [It.LA],
 Requerimientos.NumeroRequerimiento as [Nro.RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetPed.IdCuenta,
 DetPed.OrigenDescripcion,
 DetPed.ArchivoAdjunto1,
 DetPed.ArchivoAdjunto2,
 DetPed.ArchivoAdjunto3,
 DetPed.ArchivoAdjunto4,
 DetPed.ArchivoAdjunto5,
 DetPed.ArchivoAdjunto6,
 DetPed.ArchivoAdjunto7,
 DetPed.ArchivoAdjunto8,
 DetPed.ArchivoAdjunto9,
 DetPed.ArchivoAdjunto10,
 Case 	When Acopios.IdObra IS NOT NULL Then  Acopios.IdObra
	When Requerimientos.IdObra IS NOT NULL Then Requerimientos.IdObra
	Else null
 End as [Obra],
 Case 	When DetalleAcopios.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos
		Where Equipos.IdEquipo=DetalleAcopios.IdEquipo)
	When DetalleRequerimientos.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos
		Where Equipos.IdEquipo=DetalleRequerimientos.IdEquipo)
	Else null
 End as [Equipo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetPed.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem




















