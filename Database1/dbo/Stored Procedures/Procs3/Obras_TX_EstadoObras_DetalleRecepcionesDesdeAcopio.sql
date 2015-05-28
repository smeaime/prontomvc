




CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_DetalleRecepcionesDesdeAcopio]

@IdDetalleAcopios as int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111110133'
set @vector_T='0424344240900'

SELECT
 DetalleRecepciones.IdDetalleRecepcion,
 str(Recepciones.NumeroRecepcion1,4)+' - '+str(Recepciones.NumeroRecepcion2,8) as [Recepcion],
 DetalleRecepciones.Partida as [Partida],
 Recepciones.FechaRecepcion as [Fecha],
 DetalleRecepciones.Controlado as [Controlado],
 Proveedores.RazonSocial as [Proveedor],
 DetalleRecepciones.Trasabilidad as [Trasabilidad],
 DetalleRecepciones.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unid.],
 Recepciones.NumeroRecepcionAlmacen,
 DetalleRecepciones.IdRecepcion,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones
LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Unidades ON DetalleRecepciones.IdUnidad = Unidades.IdUnidad
WHERE DetalleRecepciones.IdDetalleAcopios=@IdDetalleAcopios and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')
ORDER BY Recepciones.NumeroRecepcion1,Recepciones.NumeroRecepcion2




