

CREATE PROCEDURE [dbo].[Recepciones_TX_MaterialesRecibidosAprobados]

@Desde datetime,
@Hasta datetime,
@IdObra int

AS

SELECT 
 Articulos.Descripcion as [Material],
 Articulos.Codigo as [Codigo],
 dcc.Observaciones as [Observaciones],
 dcc.Fecha as [Fecha],
 dcc.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Case 	When dr.Cantidad1 is null Then ''
	Else Convert(varchar(10),dr.Cantidad1)
 End as [Med.1],
 Case 	When dr.Cantidad2 is null Then ''
	Else Convert(varchar(10),dr.Cantidad2)
 End as [Med.2],
 Case
	When dr.IdDetalleAcopios is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleAcopios=dr.IdDetalleAcopios))
	When dr.IdDetalleRequerimiento is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetalleRequerimientos.IdDetalleLMateriales
														From DetalleRequerimientos
														Where DetalleRequerimientos.IdDetalleRequerimiento=dr.IdDetalleRequerimiento)))
	When dr.IdDetallePedido is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetallePedidos.IdDetalleLMateriales
														From DetallePedidos
														Where DetallePedidos.IdDetallePedido=dr.IdDetallePedido)))
 End as [L.Materiales],
 str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8) as [Recepcion],
 (Select Obras.NumeroObra
  From Obras 
  Where Obras.IdObra=(Select Top 1 Requerimientos.IdObra
			From Requerimientos
			Where Requerimientos.IdRequerimiento=Recepciones.IdRequerimiento)) as [Obra],
 Case
	When dr.IdDetalleAcopios is not null 
		Then (Select Equipos.Tag
			From Equipos
			Where Equipos.IdEquipo=(Select LMateriales.IdEquipo 
						From LMateriales
						Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
										From DetalleLMateriales
										Where DetalleLMateriales.IdDetalleAcopios=dr.IdDetalleAcopios)))
	When dr.IdDetalleRequerimiento is not null 
		Then (Select Equipos.Tag
			From Equipos
			Where Equipos.IdEquipo=(Select LMateriales.NumeroLMateriales
						From LMateriales
						Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
										From DetalleLMateriales
										Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetalleRequerimientos.IdDetalleLMateriales
																From DetalleRequerimientos
																Where DetalleRequerimientos.IdDetalleRequerimiento=dr.IdDetalleRequerimiento))))
	When dr.IdDetallePedido is not null 
		Then (Select Equipos.Tag
			From Equipos
			Where Equipos.IdEquipo=(Select LMateriales.NumeroLMateriales
						From LMateriales
						Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
										From DetalleLMateriales
										Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetallePedidos.IdDetalleLMateriales
																From DetallePedidos
																Where DetallePedidos.IdDetallePedido=dr.IdDetallePedido))))
 End as [Equipo],
 Case
	When dr.IdDetalleRequerimiento is not null 
		Then (Select Requerimientos.NumeroRequerimiento
			From Requerimientos
			Where Requerimientos.IdRequerimiento=(Select Top 1 DetalleRequerimientos.IdRequerimiento
								From DetalleRequerimientos
								Where DetalleRequerimientos.IdDetalleRequerimiento=dr.IdDetalleRequerimiento))
	When dr.IdDetallePedido is not null 
		Then (Select Requerimientos.NumeroRequerimiento
			From Requerimientos
			Where Requerimientos.IdRequerimiento=(Select Top 1 DetalleRequerimientos.IdRequerimiento
								From DetalleRequerimientos
								Where DetalleRequerimientos.IdDetalleRequerimiento=(Select Top 1 DetallePedidos.IdDetalleRequerimiento
															From DetallePedidos
															Where DetallePedidos.IdDetallePedido=dr.IdDetallePedido)))
 End as [R.M.],
 Case
	When dr.IdDetalleAcopios is not null 
		Then (Select Acopios.NumeroAcopio
			From Acopios
			Where Acopios.IdAcopio=(Select Top 1 DetalleAcopios.IdAcopio
						From DetalleAcopios
						Where DetalleAcopios.IdDetalleAcopios=dr.IdDetalleAcopios))
	When dr.IdDetallePedido is not null 
		Then (Select Acopios.NumeroAcopio
			From Acopios
			Where Acopios.IdAcopio=(Select Top 1 DetalleAcopios.IdAcopio
						From DetalleAcopios
						Where DetalleAcopios.IdDetalleAcopios=(Select Top 1 DetallePedidos.IdDetalleAcopios
											From DetallePedidos
											Where DetallePedidos.IdDetallePedido=dr.IdDetallePedido)))
 End as [L.Acopio],
 Proveedores.RazonSocial as [Proveedor],
 dr.Trasabilidad,
 Rubros.Descripcion as [Rubro]
From DetalleControlesCalidad dcc
Left Outer Join DetalleRecepciones dr On dcc.IdDetalleRecepcion=dr.IdDetalleRecepcion
Left Outer Join Recepciones On dcc.IdRecepcion=Recepciones.IdRecepcion
Left Outer Join Proveedores On Recepciones.IdProveedor=Proveedores.IdProveedor
Left Outer Join Articulos On dr.IdArticulo=Articulos.IdArticulo
Left Outer Join Rubros On Articulos.IdRubro=Rubros.IdRubro
Left Outer Join Unidades On dr.IdUnidad=Unidades.IdUnidad
Where 	dcc.Fecha Between @Desde and @Hasta And 
	dcc.Cantidad>0 And 
	(@IdObra=-1 or @IdObra=(Select Top 1 Requerimientos.IdObra
					From Requerimientos
					Where Requerimientos.IdRequerimiento=Recepciones.IdRequerimiento))

