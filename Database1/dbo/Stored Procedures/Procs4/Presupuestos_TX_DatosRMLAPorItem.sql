




CREATE Procedure [dbo].[Presupuestos_TX_DatosRMLAPorItem]
@IdDetallePresupuesto int
AS 
SELECT 
	Case 	When dp.IdDetalleAcopios is not null Then 'LA'
	 	When dp.IdDetalleRequerimiento is not null Then 'RM'
		Else Null
	End as [Tipo],
	Case 	When dp.IdDetalleAcopios is not null Then Acopios.NumeroAcopio
	 	When dp.IdDetalleRequerimiento is not null Then Requerimientos.NumeroRequerimiento
		Else Null
	End as [Numero],
	Case 	When dp.IdDetalleAcopios is not null Then DetalleAcopios.NumeroItem
	 	When dp.IdDetalleRequerimiento is not null Then DetalleRequerimientos.NumeroItem
		Else Null
	End as [Item],
	Case 	When dp.IdDetalleAcopios is not null 
		 Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Acopios.IdObra)
	 	When dp.IdDetalleRequerimiento is not null 
		 Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
		Else Null
	End as [Obra],
	Case 	When dp.IdDetalleAcopios is not null 
		 Then (Select Obras.Descripcion From Obras Where Obras.IdObra=Acopios.IdObra)
	 	When dp.IdDetalleRequerimiento is not null 
		 Then (Select Obras.Descripcion From Obras Where Obras.IdObra=Requerimientos.IdObra)
		Else Null
	End as [NombreObra],
	Case 	When dp.IdDetalleAcopios is not null 
		 Then (Select Equipos.Tag From Equipos Where Equipos.IdEquipo=DetalleAcopios.IdEquipo)
	 	When dp.IdDetalleRequerimiento is not null 
		 Then (Select Equipos.Tag From Equipos Where Equipos.IdEquipo=LMateriales.IdEquipo)
		Else Null
	End as [Equipo]
FROM DetallePresupuestos dp
Left Outer Join DetalleAcopios On DetalleAcopios.IdDetalleAcopios=dp.IdDetalleAcopios
Left Outer Join Acopios On Acopios.IdAcopio=DetalleAcopios.IdAcopio
Left Outer Join DetalleRequerimientos On DetalleRequerimientos.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DetalleRequerimientos.IdRequerimiento
Left Outer Join DetalleLMateriales On DetalleLMateriales.IdDetalleLMateriales=DetalleRequerimientos.IdDetalleLMateriales
Left Outer Join LMateriales On LMateriales.IdLMateriales=DetalleLMateriales.IdLMateriales
WHERE dp.IdDetallePresupuesto = @IdDetallePresupuesto




