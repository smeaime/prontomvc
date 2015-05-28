CREATE Procedure [dbo].[Pesadas_TX_PorEstado]

@Estado varchar(1)= Null,
@TipoMovimiento varchar(1) = Null,
@Desde datetime = Null,
@Hasta datetime = Null

AS 

SET @Estado=IsNull(@Estado,'*')
SET @TipoMovimiento=IsNull(@TipoMovimiento,'*')
SET @Desde=IsNull(@Desde,Convert(datetime,'1/1/1900',103))
SET @Hasta=IsNull(@Hasta,Convert(datetime,'31/12/2100',103))

DECLARE @vector_X varchar(50),@vector_T varchar(50)

SET @vector_X='01111111111111111111111111111111133'
SET @vector_T='0494253E1E10E12233335032EEE43385500'

SELECT 
 Pesadas.idPesada,
 Pesadas.NumeroPesada as [Nro. Pesada],
 Pesadas.idPesada as [IdAux],
 Pesadas.FechaIngreso as [Fecha],
 Pesadas.Tipo as [Tipo],
 Case When IsNull(Pesadas.Tara,0)=0 or IsNull(Pesadas.PesoBruto,0)=0 Then 'Pendiente' Else 'Completa' End as [Estado],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 isnull(Clientes.RazonSocial,Proveedores.RazonSocial) as [Razon Social],
 Case When Len(Pesadas.RemitoMaterial)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoMaterial,0))))+Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) Else Convert(varchar,IsNull(Pesadas.RemitoMaterial,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoMaterial2)))+Convert(varchar,Pesadas.RemitoMaterial2) as [Remito],
 Transportistas.RazonSocial as [Transportista],
 Fletes.Descripcion as [Camion],
 Case When Len(Pesadas.RemitoTransportista)<=4 Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pesadas.RemitoTransportista,0))))+Convert(varchar,IsNull(Pesadas.RemitoTransportista,0)) Else Convert(varchar,IsNull(Pesadas.RemitoTransportista,0)) End+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pesadas.RemitoTransportista2)))+Convert(varchar,Pesadas.RemitoTransportista2) as [Remito Trans.],
 Choferes.Nombre as [Chofer],
 Pesadas.NumeroOrdenCarga as [Nro. Orden Carga],
 Pesadas.CantidadEnOrigen as [Cant.En Origen],
 Pesadas.PesoBruto as [Peso Bruto],
 Pesadas.Tara as [Tara],
 Pesadas.PesoNeto as [Peso Neto],
 Pesadas.NetoEquivalente as [Neto Equiv.],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then Pesadas.CantidadSegunRemitoMasCoefEnKg Else  Pesadas.PesoNeto End as [Valor aceptado Kg],
 Unidades.Abreviatura as [Un.],
 Pesadas.CodigoTarifador as [Codigo tarifa],
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 Pesadas.Observaciones as [Observaciones],
 Pesadas.FechaUltimaPesada as [Fecha ult.pesada],
 Pesadas.Progresiva1 as [Progresiva 1],
 Pesadas.Progresiva2 as [Progresiva 2],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='R' Then 'SI' Else '' End as [Pesada desde remito],
 Case When IsNull(Pesadas.TomarPesadaORemito,'')='D' Then 'SI' Else '' End as [En espera],
 Case When IsNull(Pesadas.TaraIngresadaManualmente,'')='SI' or IsNull(Pesadas.PesoBrutoIngresadoManualmente,'')='SI' Then 'SI' Else '' End as [Ingreso manual],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pesadas 
LEFT OUTER JOIN Clientes ON Pesadas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Pesadas.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Transportistas ON Pesadas.IdTransportista = Transportistas.IdTransportista
LEFT OUTER JOIN Choferes ON Pesadas.IdChofer = Choferes.IdChofer
LEFT OUTER JOIN Fletes ON Pesadas.IdFlete = Fletes.IdFlete
LEFT OUTER JOIN Unidades ON Pesadas.IdUnidad = Unidades.IdUnidadLEFT OUTER JOIN Articulos ON Pesadas.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Obras ON Pesadas.IdObra = Obras.IdObra
LEFT OUTER JOIN Ubicaciones ON Pesadas.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN DetallePedidos ON Pesadas.IdDetallePedido = DetallePedidos.IdDetallePedidoLEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
WHERE (@Estado='*' or 
	 (@Estado='P' and (IsNull(Pesadas.Tara,0)=0 or IsNull(Pesadas.PesoBruto,0)=0) or IsNull(Pesadas.TomarPesadaORemito,'')='D') or 
	 (@Estado='T' and IsNull(Pesadas.Tara,0)<>0 and IsNull(Pesadas.PesoBruto,0)<>0) and IsNull(Pesadas.TomarPesadaORemito,'')<>'D') and 
	(@TipoMovimiento='*' or IsNull(Pesadas.TipoMovimiento,'')=@TipoMovimiento) and 
	Pesadas.FechaIngreso Between @Desde and @hasta
ORDER BY Pesadas.NumeroPesada