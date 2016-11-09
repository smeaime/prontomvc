
USE [wDemoWilliams]
GO



--select CLIVEN.razonsocial as FacturarselaA
SELECT DISTINCT 0 as ColumnaTilde
,IdCartaDePorte, CDP.IdArticulo

,      
NumeroCartaDePorte, SubNumeroVagon   , FechaArribo,        FechaDescarga  ,  
CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA

		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA
		  ,CLIVEN.CUIT,           '' as ClienteSeparado ,
		
		 
		 isnull(LPD.PrecioRepetidoPeroConPrecision,TarifaFacturada) as TarifaFacturada           
 

        ,Articulos.Descripcion as  Producto,
         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,        
		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,        
		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],        
		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc
		 
		 ,         
		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino
		
		 
from CartasDePorte CDP
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente 
LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios

LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente 
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente 
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor 
LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre) 
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente 
LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo 
LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista 
LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer 
LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad 
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino 
        AND LPD.idArticulo=CDP.IdArticulo 
        AND isnull(LPD.IdDestinoDeCartaDePorte,isnull(CDP.Destino,''))=isnull(CDP.Destino,'') 

where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI'


union

SELECT DISTINCT 0 as ColumnaTilde
,IdCartaDePorte, CDP.IdArticulo

,      
NumeroCartaDePorte, SubNumeroVagon   , FechaArribo,        FechaDescarga  ,  
CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA
	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA
		  ,CLICO1.CUIT,           '' as ClienteSeparado ,
		 
		 isnull(LPD.PrecioRepetidoPeroConPrecision,TarifaFacturada) as TarifaFacturada           


        ,Articulos.Descripcion as  Producto,
         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,        
		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,        
		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],        
		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc
		 
		 ,         
		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino
		
		
		 
from CartasDePorte CDP
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente 
LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios

LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente 
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente 
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor 
LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre) 
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente 
LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo 
LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista 
LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer 
LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad 
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino 
        AND LPD.idArticulo=CDP.IdArticulo 
        AND isnull(LPD.IdDestinoDeCartaDePorte,isnull(CDP.Destino,''))=isnull(CDP.Destino,'') 

where CLICO1.SeLeFacturaCartaPorteComoRemcomercial






/*
select corredor
from CartasDePorte CDP
LEFT join clientes CLICOR on CDP.corredor=CLICOR.idcliente
where CLICOR.SeLeFacturaCartaPorteComoCorredor='SI'

*/
