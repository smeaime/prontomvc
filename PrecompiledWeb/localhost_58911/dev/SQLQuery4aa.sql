select * from log    where  (IdComprobante=1356273 AND  Detalle='Tabla : CartaPorte' )  

or (detalle like 'Imputacion de IdCartaPorte1356273C%' ) 
 or  (detalle like 'Desimputacion%' and detalle like '%1356273-%' )    ORDER BY FechaRegistro ASC
 
 
 
 select * from Log 
 where (detalle like 'Imputacion de IdCartaPorte13563C%' ) 
 
 detalle like 'Desimputacion%' order by FechaRegistro
 
  select * from Log 
 where (detalle like 'Se desimputa la carta id%de la factura id56662' )  order by FechaRegistro
 
   select * from Log 
 where (detalle like 'Factura por ProntoWeb%' )  order by FechaRegistro



select top 200 * from log  where
detalle like '%idfacturaimputada %'

  where  idcomprobante=56662 AND  ( 

   
 (Tipo='MODIF'  and detalle like '%idfacturaimputada 56662' )       
 or   (Tipo='FA')       
 or  (detalle like 'Factura%')          
 or  (detalle like 'Se desimputa la carta id%de la factura id56662')   )                                                   
 order by FechaRegistro