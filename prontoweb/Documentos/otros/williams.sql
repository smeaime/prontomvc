use wdemowilliams


select idclienteentregador,Entregador,* from cartasdeporte 

select IdFacturaImputada,IdClienteAFacturarle,* from cartasdeporte where idcartadeporte=1021993

select * from empleados

select * from wGrillaPersistencia

select * from wi
go

select * from  WilliamsMailFiltros
delete from WilliamsMailFiltrosCola

select * from cartasdeporte  Where SubnumeroDeFacturacion >= 0 and isnull(IdFacturaImputada,0)=0

exec CtasCtesA_TXPorTrs    2,-1,null,null,null,'N' --'S'

select * from CuentasCorrientesAcreedores

select * from proveedores where Cuit ='30-62845087-7'
sp_helptext 'CtasCtesA_TXPorTrs'

sp_helptext 'ListasPrecios_TT'
ListasPrecios_TT

select * from OrdenesPago
exec OrdenesPago_TX_EnCaja 'CA'
exec OrdenesPago_TX_EnCaja 'EN'
exec OrdenesPago_TX_EnCaja 'FI'
sp_helptext 'OrdenesPago_TX_EnCaja'







sp_helptext 'detfacturas_tx_ConDatos'
go

sp_helptext 'Log_InsertarRegistro'



delete  from  WilliamsMailFiltrosCola

select * from cartasdeporte where netoproc=30820
and (fechaingreso < '20111223' )
and (vendedor=1098 or cuentaorden1=1098 or cuentaorden2=1098 or entregador=1098)
and destino=44



select * from log where FechaRegistro>'20130610'

select observaciones,IdArticulo,* from DetalleFacturas where Idfactura=29189 order by  cast(observaciones as varchar(500)) 


UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=NULL

select TOP 1 * from WilliamsMailFiltrosCola where UltimoResultado='En Cola' order by AgrupadorDeTandaPeriodos DESC 




select * from listaspreciosdetalle


 exec Requerimientos_TX_PendientesDeFirma 
 exec Requerimientos_TX_Pendientes1 'T'
 exec Requerimientos_TX_Pendientes1 'P'


 --sp_helptext Requerimientos_TX_PendientesDeFirma


 exec AutorizacionesPorComprobante_EliminarFirmas 
 exec AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante 4,18317
 
 exec Autorizaciones_TX_CantidadAutorizaciones 4,9.00
 exec Autorizaciones_TX_CantidadAutorizaciones 4,0

 exec autorizaciones_tx_ca

 select * from pedidos


 select * from bdlmaster.dbo.userdatosextendidos

 exec DetPedidos_TX_DetallesParametrizados 18259,1
  exec DetPedidos_TX_DetallesParametrizados  11
  go

declare @p5 int
set @p5=0
exec sp_executesql N'EXEC @RETURN_VALUE = [dbo].[DetPedidos_TX_DetallesParametrizados] @IdPedido = @p0, @NivelParametrizacion = @p1',N'@p0 int,@p1 int,@RETURN_VALUE int output',@p0=18259,@p1=-1,@RETURN_VALUE=@p5 output
select @p5


update cartasdeporte set CuentaOrden2=222 where idcartadeporte=2464
update cartasdeporte set CuentaOrden1=222 where idcartadeporte=2464
select * from CartasDePorte


 use wdemowilliams

 go






[dbo].[wCartasDePorte_TX_FacturacionAutomatica] @PuntoVenta = 1

select * from IBCondiciones
select * from clientes







update detallefacturas 
set observaciones='TRABAJOS REALIZADOS EN MOVIPORT
SAN NICOLAS - 1 JORNAL INHABIL ABRIL 2013
SE ADJUNTA DETALLE'
 where idfactura=45393


 update detallefacturas 
set observaciones='La compañía asegura que el Departamento de Justicia accedió al registro de llamadas de 20 líneas telefónicas durante dos meses para descubrir la fuente de una información sobre la CIA '
 where idfactura=45393

go









CREATE PROCEDURE [dbo].[DetFacturas_TX_ConDatos2]  
  
@IdFactura int,  
@IdDetalleFactura int = Null  
  
AS  
  
SET NOCOUNT ON  
  
SET @IdDetalleFactura=IsNull(@IdDetalleFactura,-1)  
  
DECLARE @IdObraDefault int  
SET @IdObraDefault=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdObraDefault'),0)  
  
CREATE TABLE #Auxiliar1   
   (  
    IdDetalleFactura INTEGER,  
    IdColor INTEGER  
   )  
INSERT INTO #Auxiliar1   
 SELECT DetFac.IdDetalleFactura, Max(IsNull(UnidadesEmpaque.IdColor,0))  
 FROM DetalleFacturasRemitos DetFac  
 LEFT OUTER JOIN DetalleRemitos det ON DetFac.IdDetalleRemito = det.IdDetalleRemito  
 LEFT OUTER JOIN UnidadesEmpaque ON det.NumeroCaja = UnidadesEmpaque.NumeroUnidad  
 WHERE DetFac.IdFactura = @IdFactura  
 GROUP BY DetFac.IdDetalleFactura  
  
CREATE TABLE #Auxiliar2   
   (  
    IdDetalleFactura INTEGER,  
    IdColor INTEGER  
   )  
INSERT INTO #Auxiliar2   
 SELECT DetFac.IdDetalleFactura, Max(IsNull(det.IdColor,0))  
 FROM DetalleFacturasOrdenesCompra DetFac  
 LEFT OUTER JOIN DetalleOrdenesCompra det ON DetFac.IdDetalleOrdenCompra = det.IdDetalleOrdenCompra  
 WHERE DetFac.IdFactura = @IdFactura  
 GROUP BY DetFac.IdDetalleFactura  
  
SET NOCOUNT OFF  
  
SELECT  
 DetFac.*,  
 Round((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100)),2) as [Importe],  
 Articulos.Codigo as [Codigo],  
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],  
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Caracteristicas],  
 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],  
 Articulos.CostoPPP as [CostoPPP],  
 Unidades.Abreviatura as [Unidad],  
 CalidadesClad.Abreviatura as [Calidad],  
 (Select Top 1  OrdenesCompra.IdObra  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [IdObra],  
 (Select Top 1  Obras.NumeroObra  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra  
  Left Outer Join Obras On OrdenesCompra.IdObra = Obras.IdObra  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [Obra],  
 (Select Top 1  dr.NumeroCaja  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [NumeroCaja],  
 IsNull((Select Top 1  Colores.Descripcion  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Left Outer Join UnidadesEmpaque On dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad  
  Left Outer Join DetalleOrdenesCompra doc On dr.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join Colores On IsNull(UnidadesEmpaque.IdColor,doc.IdColor) = Colores.IdColor  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura),   
 (Select Top 1  Colores.Descripcion  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join Colores On doc.IdColor = Colores.IdColor  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura)) as [Color],  
 Colores.Descripcion as [Color1],  
 (Select Top 1  dr.Partida  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [Partida],  
 @IdObraDefault as [IdObraDefault],  
 (Select Top 1 Obras.NumeroObra From Obras Where Obras.IdObra=@IdObraDefault) as [ObraDefault]  
FROM DetalleFacturas DetFac  
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo  
LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad  
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad  
LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura  
LEFT OUTER JOIN #Auxiliar2 ON DetFac.IdDetalleFactura = #Auxiliar2.IdDetalleFactura  
LEFT OUTER JOIN Colores ON IsNull(#Auxiliar1.IdColor,IsNull(#Auxiliar2.IdColor,DetFac.IdColor)) = Colores.IdColor  
WHERE (@IdFactura=-1 or DetFac.IdFactura = @IdFactura) and (@IdDetalleFactura=-1 or DetFac.IdDetalleFactura=@IdDetalleFactura)  
ORDER BY IdDetalleFactura --[Obra]  
  
DROP TABLE #Auxiliar1  
DROP TABLE #Auxiliar2  

















SELECT DISTINCT    0 as ColumnaTilde,IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte, SubNumeroVagon, CDP.SubNumerodeFacturacion   , FechaArribo,        FechaDescarga  , 
'AMAGGI ARGENTINA SA' as FacturarselaA, 6120 as IdFacturarselaA,          isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA,           CLIVEN.CUIT,
           '' as ClienteSeparado,     ISNULL(dbo.wTarifaWilliams( 6120  ,CDP.IdArticulo,CDP.Destino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end ,0  ),0) as TarifaFacturada  ,          
		   Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,  CuentaOrden1 as IdIntermediario, 
		   CuentaOrden2 as IdRComercial, Entregador as IdDestinatario,             CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,        
		   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],        CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc,         LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos,CDP.Exporta,IdClienteAFacturarle,IdClienteEntregador  
		   FROM CartasDePorte CDP
		     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios	AND LPD.idArticulo=CDP.IdArticulo 	AND isnull(LPD.IdDestinoDeCartaDePorte,isnull(CDP.Destino,''))=isnull(CDP.Destino,'')     
			 
			 WHERE 1=1  AND ( 1=1       CDP.IdClienteAFacturarle=6120       OR ( 1=1              AND (CDP.Vendedor = 6120           OR CDP.CuentaOrden1 = 6120           OR CDP.CuentaOrden2 = 6120           OR CDP.idClienteAuxiliar = 6120           OR CDP.IdClienteAFacturarle = 6120             OR CDP.Entregador=6120) AND (1=0            OR CDP.Vendedor = 6120             OR CDP.CuentaOrden1=6120             OR CDP.CuentaOrden2=6120  )   ) )      AND    NetoProc>0 AND ( isnull(FechaDescarga,FechaArribo) Between convert(datetime,'2014/05/01',111)  AND convert(datetime,'2014/05/31',111)  )          AND (isnull(CDP.PuntoVenta,1)=1 OR CDP.PuntoVenta = 0)  AND (ISNULL(IdFacturaImputada,-1)=0 OR ISNULL(IdFacturaImputada,-1)=-1)     AND ISNULL(CDP.Exporta,'NO')='NO'   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI' group by IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte ,SubNumeroVagon ,CDP.SubNumeroDeFacturacion , FechaArribo,  FechaDescarga  ,  Articulos.Descripcion,         NetoFinal   ,  Corredor, Vendedor,  CuentaOrden1 , CuentaOrden2 , Entregador ,           CLIVEN.Razonsocial   ,         CLICO1.Razonsocial  ,        CLICO2.Razonsocial  ,         CLICOR.Nombre ,        CLIENT.Razonsocial  ,           LOCDES.Descripcion  ,         LOCORI.Nombre  , CDP.Exporta,                 CDP.Destino, CDP.AgregaItemDeGastosAdministrativos, TarifaFacturada,IdClienteAFacturarle, IdClienteEntregador,           CLIVEN.Confirmado,           CLIVEN.IdCodigoIVA,             CLIVEN.CUIT   