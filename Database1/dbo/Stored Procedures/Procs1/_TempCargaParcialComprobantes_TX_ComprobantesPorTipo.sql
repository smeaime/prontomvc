CREATE Procedure [dbo].[_TempCargaParcialComprobantes_TX_ComprobantesPorTipo]

@IdTipoComprobante int

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111133'
SET @vector_T='08999999E1H00CF00100'

SELECT 
 tcpc.IdEntidad as [IdAux], 
 tcpc.Fecha as [Fecha], 
 tcpc.IdEntidad as [IdEntidad], 
 tcpc.IdPuntoVenta as [IdPuntoVenta], 
 tcpc.NumeroComprobante as [NumeroComprobante], 
 tcpc.IdArticulo as [IdArticulo], 
 tcpc.IdColor as [IdColor], 
 tcpc.IdUsuario as [IdColor], 
 Case When PuntosVenta.PuntoVenta is not null Then Substring('0000',1,4-Len(Convert(varchar,PuntosVenta.PuntoVenta)))+Convert(varchar,PuntosVenta.PuntoVenta)+'-' Else '' End + 
	Substring('00000000',1,8-Len(Convert(varchar,tcpc.NumeroComprobante)))+Convert(varchar,tcpc.NumeroComprobante) as [Numero], 
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial as [Cliente], 
 tcpc.Orden as [Item],
 Articulos.Codigo as [Codigo], 
 Articulos.Descripcion as [Articulo], 
 Colores.Descripcion as [Color], 
 tcpc.Talle as [Talle], 
 tcpc.Cantidad as [Cant.], 
 Empleados.Nombre as [Usuario],
 @Vector_T as [Vector_T],
 @Vector_X as [Vector_X]
FROM _TempCargaParcialComprobantes tcpc 
LEFT OUTER JOIN Clientes ON Clientes.IdCliente = tcpc.IdEntidad
LEFT OUTER JOIN PuntosVenta ON PuntosVenta.IdPuntoVenta = tcpc.IdPuntoVenta
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = tcpc.IdArticulo
LEFT OUTER JOIN Colores ON Colores.IdColor = tcpc.IdColor
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = tcpc.IdUsuario
WHERE tcpc.IdTipoComprobante=@IdTipoComprobante
ORDER BY tcpc.Fecha, Clientes.RazonSocial, PuntosVenta.PuntoVenta, tcpc.NumeroComprobante, tcpc.Orden