



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_FacturacionAutomatica]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica]

@PuntoVenta int

AS

select distinct  

--ColumnaTilde ,
--IdCartaDePorte,
-- IdArticulo,
-- NumeroCartaDePorte, 
-- SubNumeroVagon,
-- SubnumeroDeFacturacion,  FechaArribo,  FechaDescarga,   FacturarselaA,  
-- IdFacturarselaA              		  ,Confirmado,           
-- IdCodigoIVA 		  , CUIT,            ClienteSeparado ,  		 
--  TarifaFacturada            ,
--  Producto,          KgNetos,  IdCorredor, 
--  IdTitular ,      IdIntermediario ,   IdRComercial, 
--  IdDestinatario,             		 
-- Titular  ,        
--   Intermediario  ,  [R. Comercial]  ,        
-- Corredor    ,  		  Destinatario,          
-- DestinoDesc  		 ,        
--   		[Procedcia.] ,            
-- IdDestino   

ColumnaTilde ,
cast (ISNULL(IdCartaDePorte,0) as int)  as IdCartaDePorte, 
cast (ISNULL( IdArticulo,0) as int) as IdArticulo,
ISNULL( NumeroCartaDePorte,0) as NumeroCartaDePorte,
cast (ISNULL( SubNumeroVagon,0) as int) as SubNumeroVagon,
cast (ISNULL( SubnumeroDeFacturacion,0) as int) as SubnumeroDeFacturacion, 
ISNULL( FechaArribo,0) as FechaArribo, 
ISNULL( FechaDescarga,0) as FechaDescarga,  
ISNULL( FacturarselaA,'') as FacturarselaA,  
cast (ISNULL( IdFacturarselaA ,0) as int) as   IdFacturarselaA          		  ,
Confirmado,           
 cast (ISNULL(IdCodigoIVA ,0) as int) as	IdCodigoIVA	  , 
 ISNULL(CUIT,'') as CUIT,            
 ClienteSeparado ,  		 
ISNULL(dbo.wTarifaWilliams( CDP.IdFacturarselaA ,CDP.IdArticulo,CDP.IdDestino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end ,0   ) ,0) as TarifaFacturada  ,
  ISNULL(Producto,'') as Producto ,        
  ISNULL(  KgNetos,0.0) as KgNetos, 
  cast (ISNULL( IdCorredor,0) as int) as IdCorredor, 
 cast (ISNULL( IdTitular,0) as int) as IdTitular ,    
 cast (ISNULL(  IdIntermediario,0) as int) as IdIntermediario ,  
 cast (ISNULL( IdRComercial,0) as int) as IdRComercial, 
 cast (ISNULL( IdDestinatario,0) as int) as IdDestinatario,             		 
 ISNULL(Titular,'') as Titular ,        
  ISNULL( Intermediario,'')  as Intermediario,  
  ISNULL([R. Comercial],'') as [R. Comercial] ,        
 ISNULL(Corredor,'')  as  Corredor,  		 
 ISNULL( Destinatario,'') as Destinatario,          
 ISNULL(DestinoDesc ,'')  as	DestinoDesc	 ,        
ISNULL(  		[Procedcia.],'')  as [Procedcia.],            
cast (ISNULL( IdDestino,0) as int) as  IdDestino ,
cast (ISNULL( IdCartaOriginal,0) as int) as IdCartaOriginal,
 ISNULL( AgregaItemDeGastosAdministrativos,'') as AgregaItemDeGastosAdministrativos

 
from (          

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--tit
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde ,IdCartaDePorte, CDP.IdArticulo,               NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga,  CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA              		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA  		  ,CLIVEN.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada            ,Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,     		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc  		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
 where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI'    and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta

union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co1 intermediario
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA    	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA    		  ,CLICO1.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,     CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,              CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
 from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
 where CLICO1.SeLeFacturaCartaPorteComoIntermediario='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co2 rem comercial
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLICO2.razonsocial as FacturarselaA,  CLICO2.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLICO2.SeLeFacturaCartaPorteComoRemComercial='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente auxiliar
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLIAUX.razonsocial as FacturarselaA,  CLIAUX.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor,
 Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario, 
               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,     
			      CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,   
				        		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    
  LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar = CLIAUX.IdCliente     
  LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     
  LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    
  LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
  LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     
  LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     
  LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
  LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     
  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista    
   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     
   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     
   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLIAUX.SeLeFacturaCartaPorteComoClienteAuxiliar='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario local
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////

SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos    ,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatario='SI' and isnull(CDP.Exporta,'NO')='NO'
 and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario exportador
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
    from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatarioExportador='SI' and CDP.Exporta='SI'
	and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--corredor
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICORCLI.razonsocial as FacturarselaA,  CLICORCLI.idcliente as IdFacturarselaA    	  ,isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA    		  ,CLICORCLI.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, 
Vendedor as IdTitular,  CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino     , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLICORCLI.SeLeFacturaCartaPorteComoCorredor='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL


--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (originales)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,
CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,      CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             CLIVEN.Razonsocial as   Titular  ,
        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      
		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
		 from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.IdClienteAFacturarle = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (duplicados)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,CDPduplicadas.IdCartaDePorte, CDP.IdArticulo,    CDP.NumeroCartaDePorte, 
	CDP.SubNumeroVagon ,CDPduplicadas.SubnumeroDeFacturacion  , CDP.FechaArribo,        CDP.FechaDescarga  ,      
	CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    
		  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,
    CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
	0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    CDP.NetoFinal  as  KgNetos , 
	CDP.Corredor as IdCorredor, CDP.Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, 
	CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,          CLIVEN.Razonsocial as   Titular  ,        
	CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],
    CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
	LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    ,
	CDP.IdCartaDePorte as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta

from CartasDePorte CDP    
LEFT OUTER JOIN CartasDePorte CDPduplicadas ON CDP.NumeroCartaDePorte = CDPduplicadas.NumeroCartaDePorte and  CDP.SubNumeroVagon = CDPduplicadas.SubNumeroVagon and CDPduplicadas.SubnumeroDeFacturacion>0    
LEFT OUTER JOIN Clientes CLIENT ON CDPduplicadas.IdClienteAFacturarle = CLIENT.IdCliente     
LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0     
 and cdp.puntoVenta=@PuntoVenta


)  as CDP 


GO


--wCartasDePorte_TX_FacturacionAutomatica 2