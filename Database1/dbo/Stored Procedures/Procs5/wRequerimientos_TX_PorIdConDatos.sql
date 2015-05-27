CREATE  Procedure [dbo].[wRequerimientos_TX_PorIdConDatos]

@IdRequerimiento int

AS 

SELECT 
 Requerimientos.*,
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
 dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
 dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
 dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
 dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], 
 E1.Nombre as [Libero],
 E2.Nombre as [Solicito],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion as [EquipoDestino],
 TiposCompra.Descripcion as [TipoCompra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador 
				From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [FechasLiberacionParaCompras],
 OrdenesTrabajo.NumeroOrdenTrabajo as [NumeroOrdenTrabajo]
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Requerimientos.Aprobo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Requerimientos.IdSolicito
LEFT OUTER JOIN OrdenesTrabajo ON OrdenesTrabajo.IdOrdenTrabajo=Requerimientos.IdOrdenTrabajo
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento