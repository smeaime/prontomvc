CREATE  Procedure [dbo].[Requerimientos_TX_TT]

@IdRequerimiento int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111111111111111111133'
SET @vector_T='049D22200666665112435D143E162525500'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
 dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
 dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
 dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
 dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 Requerimientos.FechaAprobacion as [Fecha libero],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
	Articulos.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo 
				From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
					Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
	Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador 
				From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdImporto=Empleados.IdEmpleado) as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
 dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],
 Requerimientos.DetalleImputacion as [Detalle imputacion],
 Requerimientos.Observaciones as [Observaciones],
 Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE (IdRequerimiento=@IdRequerimiento)