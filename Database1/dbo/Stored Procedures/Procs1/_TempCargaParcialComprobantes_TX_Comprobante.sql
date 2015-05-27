CREATE Procedure [dbo].[_TempCargaParcialComprobantes_TX_Comprobante]

@IdEntidad int,
@IdTipoComprobante int,
@IdPuntoVenta int,
@NumeroComprobante int,
@IdUsuario int

AS 

SELECT 
 tcpc.*, 
 Case When PuntosVenta.PuntoVenta is not null Then Substring('0000',1,4-Len(Convert(varchar,PuntosVenta.PuntoVenta)))+Convert(varchar,PuntosVenta.PuntoVenta)+'-' Else '' End + 
	Substring('00000000',1,8-Len(Convert(varchar,tcpc.NumeroComprobante)))+Convert(varchar,tcpc.NumeroComprobante) as [Numero], 
 Clientes.CodigoCliente as [CodigoCliente], 
 Clientes.RazonSocial as [Cliente], 
 Articulos.Codigo as [CodigoArticulo], 
 Articulos.Descripcion as [Articulo], 
 Colores.Descripcion as [Color], 
 Empleados.Nombre as [Usuario],
 Articulos.IdUnidad as [IdUnidad],
 Unidades.Abreviatura as [Unidad]
FROM _TempCargaParcialComprobantes tcpc 
LEFT OUTER JOIN Clientes ON Clientes.IdCliente = tcpc.IdEntidad
LEFT OUTER JOIN PuntosVenta ON PuntosVenta.IdPuntoVenta = tcpc.IdPuntoVenta
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = tcpc.IdArticulo
LEFT OUTER JOIN Colores ON Colores.IdColor = tcpc.IdColor
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = tcpc.IdUsuario
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Articulos.IdUnidad
WHERE tcpc.IdEntidad=@IdEntidad and tcpc.IdTipoComprobante=@IdTipoComprobante and tcpc.IdPuntoVenta=@IdPuntoVenta and tcpc.NumeroComprobante=@NumeroComprobante and tcpc.IdUsuario=@IdUsuario
ORDER BY tcpc.Orden