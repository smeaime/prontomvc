CREATE Procedure [dbo].[Obras_GenerarEstado]

@IdArticulo int,
@IdRequerimiento int = null

AS

SET NOCOUNT ON

SET @IdRequerimiento=IsNull(@IdRequerimiento,-1)

DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))

IF Len(@BasePRONTOMANT)>0 
  BEGIN
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From '+@BasePRONTOMANT+'.dbo.Articulos A 
				Where IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
  END

SET NOCOUNT OFF

TRUNCATE TABLE _TempEstadoDeObras

INSERT INTO _TempEstadoDeObras
SELECT
 DetLA.IdDetalleAcopios,
 Obras.NumeroObra,
 Case When DetLA.IdEquipo is not Null 
	Then (Select Top 1 Equipos.Tag COLLATE SQL_Latin1_General_CP1_CI_AS From Equipos Where Equipos.IdEquipo=DetLA.IdEquipo)
	Else (Select Top 1 Equipos.Tag COLLATE SQL_Latin1_General_CP1_CI_AS From Equipos Where Equipos.IdEquipo=(Select Top 1 LMateriales.IdEquipo From LMateriales Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales From DetalleLMateriales Where DetalleLMateriales.IdDetalleAcopios=DetLA.IdDetalleAcopios)))
 End,
 Null,
 'L.Acopio',
 Acopios.NumeroAcopio,
 DetLA.NumeroItem,
 Empleados.Nombre,
 Sectores.Descripcion,
 DetLA.FechaNecesidad,
 (Select COUNT(*) From DetalleAcopios da Where da.IdAcopio=DetLA.IdAcopio),
 DetLA.Cumplido,
 (Select Top 1 AutorizacionesPorComprobante.FechaAutorizacion From AutorizacionesPorComprobante Where AutorizacionesPorComprobante.IdFormulario=1 and AutorizacionesPorComprobante.IdComprobante=DetLA.IdAcopio),
 Articulos.Descripcion as [Articulo],
 DetLA.Cantidad,
 (Select Top 1 Unidades.Descripcion From Unidades Where Unidades.IdUnidad=DetLA.IdUnidad),
 (Select SUM(IsNull(dp.Cantidad,0)) 
	From DetallePedidos dp
	LEFT OUTER JOIN Pedidos ON dp.IdPedido = Pedidos.IdPedido
	Where dp.IdDetalleAcopios=DetLA.IdDetalleAcopios and (Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and (dp.Cumplido is null or dp.Cumplido<>'AN')),
 (Select SUM(IsNull(dr.Cantidad,0)) 
	From DetalleRecepciones dr
	LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
	Where dr.IdDetalleAcopios=DetLA.IdDetalleAcopios and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),
 (Select COUNT(*) From FacturasCompra fc Where fc.TipoComprobante=1 and fc.IdDetalleComprobante=DetLA.IdDetalleAcopios),
 Cuentas.Descripcion,
 DetLA.Observaciones,
 Acopios.IdObra,
 Proveedores.RazonSocial as [Proveedor asignado],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Acopios.IdComprador),
 DetLA.FechaLlamadoAProveedor,
 Acopios.Nombre,
 Acopios.Fecha,
 DetLA.Cantidad1,
 DetLA.Cantidad2,
 Null,
 Articulos.Codigo
FROM DetalleAcopios DetLA
LEFT OUTER JOIN Acopios ON DetLA.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON Acopios.Realizo=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Articulos ON DetLA.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Cuentas ON DetLA.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Proveedores ON DetLA.IdProveedor = Proveedores.IdProveedor

UNION ALL

SELECT
 DetRM.IdDetalleRequerimiento,
 Obras.NumeroObra,
 #Auxiliar1.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS,
 CentrosCosto.Descripcion,
 'R.M.',
 Requerimientos.NumeroRequerimiento,
 DetRM.NumeroItem,
 Empleados.Nombre,
 Sectores.Descripcion,
 DetRM.FechaEntrega,
 (Select COUNT(*) From DetalleRequerimientos dr Where dr.IdRequerimiento=DetRM.IdRequerimiento),
 DetRM.Cumplido,
 (Select TOP 1 AutorizacionesPorComprobante.FechaAutorizacion From AutorizacionesPorComprobante Where AutorizacionesPorComprobante.IdFormulario=3 and AutorizacionesPorComprobante.IdComprobante=DetRM.IdRequerimiento),
 Articulos.Descripcion,
 DetRM.Cantidad,
 (Select TOP 1 Unidades.Descripcion From Unidades Where Unidades.IdUnidad=DetRM.IdUnidad ),
 (Select SUM(IsNull(dp.Cantidad,0)) 
	From DetallePedidos dp
	LEFT OUTER JOIN Pedidos ON dp.IdPedido = Pedidos.IdPedido
	Where dp.IdDetalleRequerimiento=DetRM.IdDetalleRequerimiento and (Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and (dp.Cumplido is null or dp.Cumplido<>'AN')),
 (Select SUM(IsNull(dr.Cantidad,0)) 
	From DetalleRecepciones dr
	LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
	Where dr.IdDetalleRequerimiento=DetRM.IdDetalleRequerimiento and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),
 (Select SUM(IsNull(dr.Cantidad,0)) 
	From DetalleComprobantesProveedores dcp
	LEFT OUTER JOIN DetalleRecepciones dr ON dr.IdDetalleRecepcion=dcp.IdDetalleRecepcion
	Where dr.IdDetalleRequerimiento=DetRM.IdDetalleRequerimiento),
 Cuentas.Descripcion,
 DetRM.Observaciones,
 Requerimientos.IdObra,
 Proveedores.RazonSocial,
 (Select Empleados.Iniciales From Empleados Where Empleados.IdEmpleado=Requerimientos.IdComprador),
 DetRM.FechaLlamadoAProveedor,
 Null,
 Requerimientos.FechaRequerimiento,
 DetRM.Cantidad1,
 DetRM.Cantidad2,
 Requerimientos.IdEquipoDestino,
 Articulos.Codigo
FROM DetalleRequerimientos DetRM
LEFT OUTER JOIN Requerimientos ON DetRM.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON Requerimientos.IdSolicito=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Articulos ON DetRM.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Cuentas ON DetRM.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN CentrosCosto ON DetRM.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Proveedores ON DetRM.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdArticulo = DetRM.IdEquipoDestino
WHERE IsNull(Requerimientos.Confirmado,'')<>'NO' and 
		IsNull(Requerimientos.Cumplido,'')<>'AN' and 
		(@IdArticulo=-1 or Requerimientos.IdEquipoDestino=@IdArticulo) and 
		(@IdRequerimiento=-1 or DetRM.IdRequerimiento=@IdRequerimiento)

DROP TABLE #Auxiliar1