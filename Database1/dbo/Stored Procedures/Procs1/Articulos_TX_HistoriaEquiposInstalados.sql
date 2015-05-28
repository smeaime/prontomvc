



CREATE Procedure [dbo].[Articulos_TX_HistoriaEquiposInstalados]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0001111111111111133'
Set @vector_T='000H2B2200234522200'

SELECT 
 doei.IdArticulo,
 Articulos.NumeroInventario as [IdAux],
 1 as [Orden],
 Grados.Descripcion as [Tipo],
 Articulos.NumeroInventario as [Id],
 Articulos.Descripcion as [ESN],
 Articulos.CodigoLoteo as [NAM1],
 Articulos.Adrema as [NAM2],
 Articulos.ModeloEspecifico as [Propietario],
 Articulos.Autorizacion as [C/A],
 Clientes.RazonSocial as [Empresa],
 Obras.NumeroObra as [Dominio],
 doei.FechaInstalacion as [Fecha inst.],
 doei.FechaDesinstalacion as [Fecha desinst.],
 Articulos.Serie as [CausaReinstalacion],
 doei.Observaciones as [Observaciones inst.],
 Articulos.Observaciones as [Observaciones equipo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasEquiposInstalados doei
LEFT OUTER JOIN Articulos ON doei.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Grados ON Articulos.IdGrado=Grados.IdGrado
LEFT OUTER JOIN Obras ON doei.IdObra=Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente=Clientes.IdCliente

UNION ALL

SELECT 
 doei.IdArticulo,
 Articulos.NumeroInventario as [IdAux],
 5 as [Orden],
 Null as [Tipo],
 Null as [Id],
 Null as [ESN],
 Null as [NAM1],
 Null as [NAM2],
 Null as [Propietario],
 Null as [C/A],
 Null as [Empresa],
 Null as [Dominio],
 Null as [Fecha inst.],
 Null as [Fecha desinst.],
 Null as [CausaReinstalacion],
 Null as [Observaciones inst.],
 Null as [Observaciones equipo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasEquiposInstalados doei
LEFT OUTER JOIN Articulos ON doei.IdArticulo=Articulos.IdArticulo
GROUP BY doei.IdArticulo, Articulos.NumeroInventario

ORDER BY [IdAux], [Orden], [Fecha inst.]



