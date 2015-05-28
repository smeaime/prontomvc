CREATE PROCEDURE [dbo].[DetPedidos_TXPed]

@IdPedido int

AS

SET NOCOUNT ON

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdDetallePedido INTEGER, IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePedido,IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
    BEGIN
	SET @sql1='Select Distinct dp.IdDetallePedido, a.IdArticulo, a.Descripcion, a.NumeroInventario 
			From DetallePedidos dp
			Left Outer Join Pedidos On Pedidos.IdPedido = dp.IdPedido
			Left Outer Join DetalleRequerimientos dr On dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
			Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On Requerimientos.IdEquipoDestino = a.IdArticulo
			Where Pedidos.IdPedido='+Convert(varchar,@IdPedido)+' and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DISTINCT dp.IdDetallePedido, a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetallePedidos dp
	 LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = dp.IdPedido
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON Requerimientos.IdEquipoDestino = a.IdArticulo
	 WHERE Pedidos.IdPedido=@IdPedido and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(70),@vector_T varchar(70)
SET @vector_X='001001110110111111111111010001111100000000000011111661111111133'
SET @vector_T='0000009900902D444333333400000531310000000000003992934061192D200'

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
 (Select IsNull(Unidades.Abreviatura,Unidades.Descripcion) From Unidades Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
 Substring(ControlesCalidad.Descripcion,1,10) as [Control de Calidad],
 DetPed.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.FechaEntrega as [F.entrega],
 DetPed.FechaNecesidad as [F.necesidad],
 DetPed.Precio,
 (DetPed.Cantidad*DetPed.Precio) as [Subtotal],
 DetPed.PorcentajeBonificacion as [% Bon],
 DetPed.ImporteBonificacion as [Bonif.],
 Case When DetPed.ImporteBonificacion is null Then (DetPed.Cantidad*DetPed.Precio) Else (DetPed.Cantidad*DetPed.Precio)-DetPed.ImporteBonificacion End as [Subtotal grav.],
 DetPed.PorcentajeIVA as [% IVA],
 DetPed.ImporteIVA as [IVA],
 DetPed.ImporteTotalItem as [Importe],
 DetPed.IdControlCalidad,
 DetPed.Cumplido as [Cum],
 Case When Acopios.IdObra IS NOT NULL Then  Acopios.IdObra When Requerimientos.IdObra IS NOT NULL Then Requerimientos.IdObra Else null End as [IdObra],
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
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Obras.NumeroObra From Obras Where Obras.IdObra=Acopios.IdObra)
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
	Else null
 End as [Obra],
 Case 	When DetalleAcopios.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos Where Equipos.IdEquipo=DetalleAcopios.IdEquipo) 
	When DetalleRequerimientos.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos Where Equipos.IdEquipo=DetalleRequerimientos.IdEquipo)
	Else null
 End as [Equipo],
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=(Select Top 1 Obras.IdCliente From Obras Where Obras.IdObra=Acopios.IdObra))
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=(Select Top 1 Obras.IdCliente From Obras Where Obras.IdObra=Requerimientos.IdObra))
	Else null
 End as [Cliente],
 DetPed.Costo,
 DetPed.IdDetallePedido as [IdAux],
 DetPed.CostoAsignado as [Costo Asig.],
 DetPed.CostoAsignadoDolar as [Costo Asig.u$s],
 E1.Nombre as [Costo asignado por],
 DetPed.FechaAsignacionCosto as [Fecha asig.costo],
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Acopios.Realizo)
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Requerimientos.IdSolicito)
	Else null
 End as [RM solicitada por],
 DetPed.PlazoEntrega as [Plazo entrega],
 0 as [Reservado],
 #Auxiliar1.NumeroInventario as [Cod.Eq.Destino],
 #Auxiliar1.Descripcion as [Equipo destino],
 DetalleRequerimientos.ObservacionesFirmante as [Observaciones firmante],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetPed.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = DetPed.IdUsuarioAsignoCosto
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetallePedido=DetPed.IdDetallePedido
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem

DROP TABLE #Auxiliar1