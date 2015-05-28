


CREATE PROCEDURE [dbo].sp_TX_wBusquedaProduccion
    @q VARCHAR(50)
AS

/*
--cuales son las tablas mas usadas?


http://sqlserver2000.databases.aspfaq.com/how-do-i-get-a-list-of-sql-server-tables-and-their-row-counts.html

select count(*) from requerimientos 
select count(*) from ComprobantesProveedores 
select count(*) from Facturas 
select count(*) from pedidos
select count(*) from remitos 
select count(*) from requerimientos 


select count(*) from salidasmateriales
select count(*) from recepciones
select count(*) from ordenespago




SELECT 
    [TableName] = so.name, 
    [RowCount] = MAX(si.rows) 
FROM 
    sysobjects so, 
    sysindexes si 
WHERE 
    so.xtype = 'U' 
    AND 
    si.id = OBJECT_ID(so.name) 
GROUP BY 
    so.name 
ORDER BY 
    2 DESC
    
    

EXEC sp_spaceused
*/

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011133'
SET @vector_T='0902D10310123100'

SELECT TOP 100 IdProduccionOrden,IdProduccionOrden,'OP' AS Tipo
,@vector_X,@vector_t
FROM ProduccionOrdenes
WHERE  IdProduccionOrden LIKE @q+'%'

UNION

SELECT TOP 100 idproduccionparte,idproduccionparte,'PARTE' AS Tipo
,@vector_X,@vector_t
FROM produccionpartes
WHERE idproduccionparte LIKE @q+'%'

UNION

SELECT TOP 100 idproduccionficha,idproduccionficha,'FICHA' AS Tipo
,@vector_X,@vector_t
FROM produccionfichas
WHERE idproduccionficha LIKE @q+'%'


--UNION

--SELECT TOP 100 IdPedido,NumeroPedido,'PED' AS Tipo
--,@vector_X,@vector_t
--FROM pedidos
--WHERE NumeroPedido LIKE @q+'%'

--UNION

--SELECT TOP 100 IdFactura,NumeroFactura,'FAC' AS Tipo
--,@vector_X,@vector_t
--FROM dbo.Facturas
--WHERE NumeroFactura LIKE @q+'%'

--UNION

--SELECT TOP 100 IdRemito,NumeroRemito,'REM' AS Tipo
--,@vector_X,@vector_t
--FROM remitos
--WHERE NumeroRemito LIKE @q+'%'


--UNION

--SELECT TOP 100 IdSalidaMateriales,NumeroSalidaMateriales,'SM' AS Tipo
--,@vector_X,@vector_t
--FROM salidasmateriales
--WHERE NumeroSalidaMateriales LIKE @q+'%'

--UNION

--SELECT TOP 100 IdRecepcion,NumeroRecepcion2,'RCP' AS Tipo
--,@vector_X,@vector_t
--FROM Recepciones
--WHERE NumeroRecepcion2 LIKE @q+'%'

--UNION

--SELECT TOP 100 IdOrdenPago,NumeroOrdenPago,'OP' AS Tipo
--,@vector_X,@vector_t
--FROM ordenespago
--WHERE NumeroOrdenPago LIKE @q+'%'





