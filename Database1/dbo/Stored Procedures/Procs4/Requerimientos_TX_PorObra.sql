


CREATE  Procedure [dbo].[Requerimientos_TX_PorObra]

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111111111133'
set @vector_T='059410051123D00'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
	Articulos.Descripcion as [Equipo destino],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
WHERE Requerimientos.IdObra is not null and 
	 (Requerimientos.Cumplido is null or Requerimientos.Cumplido='NO') and 
	 (Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO')
ORDER BY Requerimientos.FechaRequerimiento Desc, 
	Requerimientos.NumeroRequerimiento Desc


