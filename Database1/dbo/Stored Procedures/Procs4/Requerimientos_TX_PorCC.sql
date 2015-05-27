


CREATE  Procedure [dbo].[Requerimientos_TX_PorCC]

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111111133'
set @vector_T='05941053011255055D00'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra as [Obra],
 Case 	When Obras.Consorcial is null or Obras.Consorcial='NO' Then Null
	When Obras.Consorcial='SI' Then 
	 Case 	When Requerimientos.Consorcial is null or Requerimientos.Consorcial='SI' Then 'Consorcial'
		Else 'Cautiva'
	 End
	Else Null
 End as [Tipo obra],
 CentrosCosto.Descripcion as [Centro de costo],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 Sectores.Descripcion as [Sector],
 Requerimientos.MontoParaCompra as [Monto p/compra],
 Requerimientos.MontoPrevisto as [Monto previsto],
 Monedas.Nombre as [Moneda],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
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
WHERE Requerimientos.IdCentroCosto is not null and 
	 (Requerimientos.Cumplido is null or Requerimientos.Cumplido='NO') and 
	 (Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO')
ORDER BY Requerimientos.FechaRequerimiento Desc, 
	Requerimientos.NumeroRequerimiento Desc


