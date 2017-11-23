  
  IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wFuncionBusqueda'))
    DROP FUNCTION [dbo].wFuncionBusqueda
go

CREATE FUNCTION wFuncionBusqueda (@q VARCHAR(50))


  
RETURNS TABLE AS  
RETURN (  
  
--si sacas los ORDER, parece que no anda en SQL2000/5  
--si sacas los ORDER, parece que no anda en SQL2000/5  
--si sacas los ORDER, parece que no anda en SQL2000/5  
  
--ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)  
  
  
 SELECT top 20 IdCliente as ID,isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'')  as Numero  
    ,'Cliente' AS Tipo,  FechaAlta as fecha,  
    isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1   
 FROM dbo.Clientes   
 WHERE   -- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index  
   RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence  
   OR RazonSocial like  @q + '%'            -- At the beginning of a sentence  
  
  
     or   
     Cuit LIKE @q+'%'    
     or   
     isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%'   
  
 UNION  all
  
 SELECT top 10 IdCartaDePorte as ID,   
    CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,  
   'Carta de porte' AS Tipo, FechaModificacion as fecha  
    , '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1  
  
 FROM dbo.CartasDePorte   
 WHERE    
   isnull(SubNumeroDeFacturacion,0)<=0   
   AND  
   (  
   NumeroCartaDePorte LIKE @q+'%'  
   OR  
     SubNumeroVagon LIKE @q+'%'  
     OR  
     CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%'   
     )  
  
 --UNION  
  
  
 --SELECT TOP 100 IdAsiento as ID,CAST(NumeroAsiento as varchar(100)),'Asiento' AS Tipo, asientos.FechaAsiento as fecha  
 --   , '' as item1  
 --FROM dbo.Asientos   
 --WHERE  asientos.NumeroAsiento LIKE @q+'%'  
 ----ORDER BY fechaasiento desc   --si sacas los ORDER, parece que no anda en SQL2000/5  
  
 --UNION  
  
 --SELECT TOP 100 IdComprobanteProveedor as ID,CAST(NumeroComprobante2 as varchar(100)),'Cmpbte proveedor' AS Tipo, FechaComprobante as fecha  
 --   , '' as item1  
 --FROM dbo.ComprobantesProveedores  
 --WHERE  NumeroComprobante2 LIKE @q+'%'  
 ----ORDER BY IdComprobanteProveedor desc  
  
 --UNION  
  
 --SELECT TOP 100 IdRequerimiento,CAST(NumeroRequerimiento  as varchar(100)),'Requerimiento' AS Tipo, FechaRequerimiento as fecha  
 --   , '' as item1  
 --FROM requerimientos  
 --WHERE NumeroRequerimiento LIKE @q+'%'  
 --ORDER BY IdRequerimiento desc --si sacas los ORDER, parece que no anda en SQL2000/5  
  
 --UNION  
  
 --SELECT TOP 100 IdArticulo,CAST(Descripcion  as varchar(100)),'Articulo' AS Tipo, FechaAlta as fecha  
 --   , '' as item1  
 --FROM Articulos  
 --WHERE codigo LIKE @q+'%'or  
 --   Descripcion LIKE @q+'%' or  
 --   Descripcion like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence  
 --ORDER BY IdArticulo desc --si sacas los ORDER, parece que no anda en SQL2000/5  
  
 --UNION  
  
 --SELECT TOP 100 IdPedido,CAST(NumeroPedido  as varchar(100)),'Pedido' AS Tipo,FechaPedido as fecha  
 --   , '' as item1  
 --FROM pedidos  
 --WHERE NumeroPedido LIKE @q+'%'  
 ----ORDER BY IdPedido desc  
  
 --UNION  all
  
 --SELECT top 10 IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha  
 --   , '' as item1  
 --FROM dbo.Facturas  
 --WHERE NumeroFactura LIKE @q+'%'  
 --ORDER BY IdFactura desc  
  
   
 --UNION  
  
 --SELECT TOP 100 IdRemito,CAST(NumeroRemito as varchar(100)),'Remito' AS Tipo, FechaRemito as fecha  
 --   , '' as item1  
 --FROM remitos  
 --WHERE NumeroRemito LIKE @q+'%'  
 ----ORDER BY IdRemito desc--si sacas los ORDER, parece que no anda en SQL2000/5  
  
  
 --UNION  
  
 --SELECT TOP 100 IdSalidaMateriales,CAST(NumeroSalidaMateriales as varchar(100)),'Salida de materiales' AS Tipo, FechaSalidaMateriales  
 --   , '' as item1  
 --FROM salidasmateriales  
 --WHERE NumeroSalidaMateriales LIKE @q+'%'  
 ----ORDER BY IdSalidaMateriales desc--si sacas los ORDER, parece que no anda en SQL2000/5  
  
 --UNION  
  
 --SELECT TOP 100 IdRecepcion,CAST(NumeroRecepcion2 as varchar(100)),'Recepción' AS Tipo,FechaRecepcion  
 --   , '' as item1  
 --FROM Recepciones  
 --WHERE NumeroRecepcion2 LIKE @q+'%'  
 ----ORDER BY IdRecepcion desc--si sacas los ORDER, parece que no anda en SQL2000/5  
  
 --UNION  
  
 --SELECT TOP 100 IdOrdenPago,  CAST(NumeroOrdenPago as varchar(100)),'Orden de pago' AS Tipo, FechaOrdenPago  
 --   , '' as item1  
 --FROM  dbo.OrdenesPago  
 --WHERE NumeroOrdenPago LIKE @q+'%'  
 ----ORDER BY IdOrdenPago desc--si sacas los ORDER, parece que no anda en SQL2000/5  
  
               )   
go
  
  
  
  /*
                 
SELECT * FROM dbo.wFuncionBusqueda('20306762 0-0')	
SELECT * FROM dbo.wFuncionBusqueda('3333333')	
SELECT * FROM dbo.wFuncionBusqueda('caso')	
SELECT * FROM dbo.wFuncionBusqueda('300')	
SELECT * FROM dbo.wFuncionBusqueda('1111')	
SELECT * FROM dbo.wFuncionBusqueda('1311111')	
SELECT * FROM dbo.wFuncionBusqueda('523469')	

SELECT * FROM dbo.wFuncionBusqueda('528790550')
SELECT * FROM dbo.wFuncionBusqueda('528790550 0-0')

*/



--en wwilliams

  CREATE FUNCTION wFuncionBusqueda (@q VARCHAR(50))  
  
  
    
RETURNS TABLE AS    
RETURN (    
    
--si sacas los ORDER, parece que no anda en SQL2000/5    
--si sacas los ORDER, parece que no anda en SQL2000/5    
--si sacas los ORDER, parece que no anda en SQL2000/5    
    
--ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)    
    
    
 SELECT top 20 IdCliente as ID,isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'')  as Numero    
    ,'Cliente' AS Tipo,  FechaAlta as fecha,    
    isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1     
 FROM dbo.Clientes     
 WHERE   -- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index    
   RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence    
   OR RazonSocial like  @q + '%'            -- At the beginning of a sentence    
    
    
     or     
     Cuit LIKE @q+'%'      
     or     
     isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%'     
    
 UNION  all  
    
 SELECT top 10 IdCartaDePorte as ID,     
    CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,    
   'Carta de porte' AS Tipo, FechaModificacion as fecha    
    , '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1    
    
 FROM dbo.CartasDePorte     
 WHERE      
   isnull(SubNumeroDeFacturacion,0)<=0     
   AND    
   (    
   NumeroCartaDePorte LIKE @q+'%'    
   OR    
     SubNumeroVagon LIKE @q+'%'    
     OR    
     CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%'     
     )    
    
 --UNION    
    
    
 --SELECT TOP 100 IdAsiento as ID,CAST(NumeroAsiento as varchar(100)),'Asiento' AS Tipo, asientos.FechaAsiento as fecha    
 --   , '' as item1    
 --FROM dbo.Asientos     
 --WHERE  asientos.NumeroAsiento LIKE @q+'%'    
 ----ORDER BY fechaasiento desc   --si sacas los ORDER, parece que no anda en SQL2000/5    
    
 --UNION    
    
 --SELECT TOP 100 IdComprobanteProveedor as ID,CAST(NumeroComprobante2 as varchar(100)),'Cmpbte proveedor' AS Tipo, FechaComprobante as fecha    
 --   , '' as item1    
 --FROM dbo.ComprobantesProveedores    
 --WHERE  NumeroComprobante2 LIKE @q+'%'    
 ----ORDER BY IdComprobanteProveedor desc    
    
 --UNION    
    
 --SELECT TOP 100 IdRequerimiento,CAST(NumeroRequerimiento  as varchar(100)),'Requerimiento' AS Tipo, FechaRequerimiento as fecha    
 --   , '' as item1    
 --FROM requerimientos    
 --WHERE NumeroRequerimiento LIKE @q+'%'    
 --ORDER BY IdRequerimiento desc --si sacas los ORDER, parece que no anda en SQL2000/5    
    
 --UNION    
    
 --SELECT TOP 100 IdArticulo,CAST(Descripcion  as varchar(100)),'Articulo' AS Tipo, FechaAlta as fecha    
 --   , '' as item1    
 --FROM Articulos    
 --WHERE codigo LIKE @q+'%'or    
 --   Descripcion LIKE @q+'%' or    
 --   Descripcion like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence    
 --ORDER BY IdArticulo desc --si sacas los ORDER, parece que no anda en SQL2000/5    
    
 --UNION    
    
 --SELECT TOP 100 IdPedido,CAST(NumeroPedido  as varchar(100)),'Pedido' AS Tipo,FechaPedido as fecha    
 --   , '' as item1    
 --FROM pedidos    
 --WHERE NumeroPedido LIKE @q+'%'    
 ----ORDER BY IdPedido desc    
    
 --UNION  all  
    
 --SELECT top 10 IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha    
 --   , '' as item1    
 --FROM dbo.Facturas    
 --WHERE NumeroFactura LIKE @q+'%'    
 --ORDER BY IdFactura desc    
    
     
 --UNION    
    
 --SELECT TOP 100 IdRemito,CAST(NumeroRemito as varchar(100)),'Remito' AS Tipo, FechaRemito as fecha    
 --   , '' as item1    
 --FROM remitos    
 --WHERE NumeroRemito LIKE @q+'%'    
 ----ORDER BY IdRemito desc--si sacas los ORDER, parece que no anda en SQL2000/5    
    
    
 --UNION    
    
 --SELECT TOP 100 IdSalidaMateriales,CAST(NumeroSalidaMateriales as varchar(100)),'Salida de materiales' AS Tipo, FechaSalidaMateriales    
 --   , '' as item1    
 --FROM salidasmateriales    
 --WHERE NumeroSalidaMateriales LIKE @q+'%'    
 ----ORDER BY IdSalidaMateriales desc--si sacas los ORDER, parece que no anda en SQL2000/5    
    
 --UNION    
    
 --SELECT TOP 100 IdRecepcion,CAST(NumeroRecepcion2 as varchar(100)),'Recepción' AS Tipo,FechaRecepcion    
 --   , '' as item1    
 --FROM Recepciones    
 --WHERE NumeroRecepcion2 LIKE @q+'%'    
 ----ORDER BY IdRecepcion desc--si sacas los ORDER, parece que no anda en SQL2000/5    
    
 --UNION    
    
 --SELECT TOP 100 IdOrdenPago,  CAST(NumeroOrdenPago as varchar(100)),'Orden de pago' AS Tipo, FechaOrdenPago    
 --   , '' as item1    
 --FROM  dbo.OrdenesPago    
 --WHERE NumeroOrdenPago LIKE @q+'%'    
 ----ORDER BY IdOrdenPago desc--si sacas los ORDER, parece que no anda en SQL2000/5    
    
               )     
  
