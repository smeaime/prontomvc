--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].FirstWord'))
    DROP FUNCTION [dbo].FirstWord
go

create FUNCTION [dbo].[FirstWord] (@value VARCHAR(50)) --(@value varchar(max))
RETURNS  VARCHAR(50) --varchar(max)
AS
BEGIN
    RETURN CASE CHARINDEX(' ', @value, 1)
        WHEN 0 THEN @value
        ELSE SUBSTRING(@value, 1, CHARINDEX(' ', @value, 1) - 1) END
END
GO


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].convertInt'))
    DROP FUNCTION [dbo].convertInt
go

create FUNCTION [dbo].convertInt (@value VARCHAR(50)) --(@value varchar(max))
RETURNS  int --varchar(max)
AS
BEGIN

    RETURN CASE isnumeric(dbo.FirstWord(@value))
        WHEN 0 THEN cast(dbo.FirstWord(@value) as int)
        ELSE 0		END
END
GO



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--y lo de fulltextsearch? por qué fue que lo abandoné? había una razon, pero ya no recuerdo cual

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wFuncionBusquedaMVC'))
    DROP FUNCTION [dbo].wFuncionBusquedaMVC
go

CREATE FUNCTION wFuncionBusquedaMVC (@q VARCHAR(50))



RETURNS TABLE AS
RETURN (

--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5

--ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)



--union all?

	SELECT 
	top 8
	
	IdCliente as ID,
	
				CAST(   isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'') as varchar(100)) as Numero    
				

				,'Cliente' AS Tipo,  FechaAlta as fecha,
				isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1 


	FROM dbo.Clientes 
	WHERE  	-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			
			(
			isnumeric(@q)=0 -- pinta que no se da cuenta de que no tiene que gastarse si esto no se cumple
			AND
			(
			RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
			OR RazonSocial like  @q + '%'            -- At the beginning of a sentence
			)
			)
		   or 
		   (
			--isnumeric(@q)=1 AND 
			Cuit LIKE @q+'%'  --dbo.FirstWord(@q)+'%' 
			

		   ) 
		   --or 
		   --isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%' 

UNION all  
 
    
 SELECT   
 top 8  
   
 IdProveedor as ID,  
   
    CAST(   isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'') as varchar(100)) as Numero      
      
  
    ,'Proveedor' AS Tipo,  FechaAlta as fecha,  
    '' + CHAR(13)+CHAR(10) + isnull(Email,'') as item1   
  
  
 FROM dbo.Proveedores   
 WHERE   -- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index  
     
   (  
   isnumeric(@q)=0 -- pinta que no se da cuenta de que no tiene que gastarse si esto no se cumple  
   AND  
   (  
   RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence  
   OR RazonSocial like  @q + '%'            -- At the beginning of a sentence  
   )  
   )  
     or   
     (  
   --isnumeric(@q)=1 AND   
   Cuit LIKE @q+'%'  --dbo.FirstWord(@q)+'%'   
     
  
     )   
     --or   
     --isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%'   
  
  
  
 
 


	--UNION all --no podes hacer top con union all?

	--SELECT  
	--top 5 
	--		IdCartaDePorte as ID,	
	--		NumeroCartaEnTextoParaBusqueda as Numero,
	--		-- CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,
	--		'Carta de porte' AS Tipo, FechaModificacion as fecha
	--		, '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1

	--FROM dbo.CartasDePorte 
	--WHERE  
	--		--isnull(SubNumeroDeFacturacion,0)<=0 
	--		--(SubNumeroDeFacturacion=0 or SubNumeroDeFacturacion=-1 or SubnumeroDeFacturacion IS NULL) AND --sirve hacer este filtro? es contraproducente?
	--			isnumeric( dbo.FirstWord(@q))=1  
	--		and
	--		(
	--		-- http://stackoverflow.com/questions/2640048/sql-how-to-get-the-left-3-numbers-from-an-int
	--	--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
	--	--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
	--	--In general the CAST will kill performance because it invalidates any use of index seeks as Martin Smith's last example shows. CASTing to nvarchar(max) or to a different length means a different data type: the fact it's all nvarchar is irrelevant.

	--		NumeroCartaEnTextoParaBusqueda like dbo.FirstWord(@q)+'%'

			
	--		 or SubNumeroVagon = dbo.convertInt(@q)   --pueden llegar a buscar el vagon por la mitad? porque si no le meto un "igual"
	--		--or SubNumeroVagon = LIKE @q+'%'
	--		--OR		(SubNumeroVagon>0 and	SubNumeroVagon  =  dbo.convertInt(@q ) )
	--		-- as varchar(6))  like dbo.FirstWord(@q)+'%'
	--	   --OR
	--	   --CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%' 
	--	   )

	--UNION


	--SELECT TOP 100 IdAsiento as ID,CAST(NumeroAsiento as varchar(100)),'Asiento' AS Tipo, asientos.FechaAsiento as fecha
	--			, '' as item1
	--FROM dbo.Asientos 
	--WHERE  asientos.NumeroAsiento LIKE @q+'%'
	----ORDER BY fechaasiento desc   --si sacas los ORDER, parece que no anda en SQL2000/5

	--UNION

	--SELECT TOP 100 IdComprobanteProveedor as ID,CAST(NumeroComprobante2 as varchar(100)),'Cmpbte proveedor' AS Tipo, FechaComprobante as fecha
	--			, '' as item1
	--FROM dbo.ComprobantesProveedores
	--WHERE  NumeroComprobante2 LIKE @q+'%'
	----ORDER BY IdComprobanteProveedor desc

	--UNION

	UNION all
	SELECT TOP 100 IdEmpleado,CAST(nombre  as varchar(100)),'Usuario' AS Tipo, FechaNacimiento as fecha
				, '' as item1
	FROM empleados
	WHERE nombre LIKE @q+'%'
	ORDER BY nombre desc --si sacas los ORDER, parece que no anda en SQL2000/5


	UNION all
	SELECT TOP 100 IdRequerimiento,CAST(NumeroRequerimiento  as varchar(100)),'Requerimiento' AS Tipo, FechaRequerimiento as fecha
				, '' as item1
	FROM requerimientos
	WHERE NumeroRequerimiento LIKE @q+'%'
	ORDER BY IdRequerimiento desc --si sacas los ORDER, parece que no anda en SQL2000/5
		
		
	UNION all

	SELECT TOP 100 IdArticulo,CAST(Descripcion  as varchar(100)),'Articulo' AS Tipo, FechaAlta as fecha
				, '' as item1
	FROM Articulos
	WHERE codigo LIKE @q+'%'or
		  Descripcion LIKE @q+'%' or
		  Descripcion like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
	ORDER BY IdArticulo desc --si sacas los ORDER, parece que no anda en SQL2000/5

	UNION all

	SELECT TOP 100 IdPedido,CAST(NumeroPedido  as varchar(100)),'Pedido' AS Tipo,FechaPedido as fecha
				, '' as item1
	FROM pedidos
	WHERE NumeroPedido LIKE @q+'%'
	ORDER BY IdPedido desc

	UNION all

	SELECT  
	top 10 
	IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha
				, '' as item1
	FROM dbo.Facturas
	WHERE 
		NumeroFactura  LIKE dbo.FirstWord(@q)+'%'
	 ORDER BY IdFactura desc

	UNION all

	SELECT  
	top 10 
	IdComparativa,CAST( comparativas.Numero  as varchar(100)),'Comparativa' AS Tipo, comparativas.fecha as fecha
				, '' as item1
	FROM dbo.Comparativas
	WHERE 
		Numero  LIKE dbo.FirstWord(@q)+'%'
	 ORDER BY IdComparativa desc

	
	
	--UNION

	--SELECT TOP 100 IdRemito,CAST(NumeroRemito as varchar(100)),'Remito' AS Tipo, FechaRemito as fecha
	--			, '' as item1
	--FROM remitos
	--WHERE NumeroRemito LIKE @q+'%'
	----ORDER BY IdRemito desc--si sacas los ORDER, parece que no anda en SQL2000/5


	--UNION

	--SELECT TOP 100 IdSalidaMateriales,CAST(NumeroSalidaMateriales as varchar(100)),'Salida de materiales' AS Tipo, FechaSalidaMateriales
	--			, '' as item1
	--FROM salidasmateriales
	--WHERE NumeroSalidaMateriales LIKE @q+'%'
	----ORDER BY IdSalidaMateriales desc--si sacas los ORDER, parece que no anda en SQL2000/5

	--UNION

	--SELECT TOP 100 IdRecepcion,CAST(NumeroRecepcion2 as varchar(100)),'Recepción' AS Tipo,FechaRecepcion
	--			, '' as item1
	--FROM Recepciones
	--WHERE NumeroRecepcion2 LIKE @q+'%'
	----ORDER BY IdRecepcion desc--si sacas los ORDER, parece que no anda en SQL2000/5

	--UNION

	--SELECT TOP 100 IdOrdenPago,  CAST(NumeroOrdenPago as varchar(100)),'Orden de pago' AS Tipo, FechaOrdenPago
	--			, '' as item1
	--FROM  dbo.OrdenesPago
	--WHERE NumeroOrdenPago LIKE @q+'%'
	----ORDER BY IdOrdenPago desc--si sacas los ORDER, parece que no anda en SQL2000/5

               ) 

               
 GO
              
--SELECT * FROM dbo.wFuncionBusquedaMVC('102354235235')	
--SELECT * FROM dbo.wFuncionBusquedaMVC('pedi')	
-- wUltimosComprobantesCreados ''


SELECT dbo.FirstWord('3333333')
go
--DBCC CHECKDB


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wBusquedaMVC')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wBusquedaMVC
go

CREATE PROCEDURE wBusquedaMVC
    @q VARCHAR(50)
    with recompile 
AS

	SELECT top 20 * 
	FROM dbo.wFuncionBusquedaMVC(@q) 
--	group by Numero
	order by Fecha desc

GO


--EXEC wBusquedaMVC '102354235235'
--

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

exec wBusquedaMVC '30'
exec wBusquedaMVC 'pedi'
SELECT * FROM dbo.wFuncionBusquedaMVC('pedi')	
exec wBusquedaMVC '20306762'
exec wBusquedaMVC '20306762 0-0'
SELECT * FROM dbo.wFuncionBusquedaMVC('20306762 0-0')	
SELECT * FROM dbo.wFuncionBusquedaMVC('3333333')	
SELECT * FROM dbo.wFuncionBusquedaMVC('caso')	
SELECT * FROM dbo.wFuncionBusquedaMVC('300')	
SELECT * FROM dbo.wFuncionBusquedaMVC('1111')	
SELECT * FROM dbo.wFuncionBusquedaMVC('1311111')	
SELECT * FROM dbo.wFuncionBusquedaMVC('523469')	

SELECT * FROM dbo.wFuncionBusquedaMVC('528790550')
SELECT * FROM dbo.wFuncionBusquedaMVC('528790550 0-0')

exec wClientes_TX_BusquedaConCUIT '528790550 0-0'



EXEC wBusquedaMVC 'caso'
EXEC wBusquedaMVC '333333'


SELECT * FROM dbo.wFuncionBusquedaMVC('30-68296681-1')	
SELECT * FROM dbo.wFuncionBusquedaMVC('30682966811')


print dbo.FirstWord ('30-68296681-1')
	
exec wBusquedaMVC '30'
exec wBusquedaMVC '528790550 0-0'
SET STATISTICS TIME ON;
GO
SET STATISTICS TIME OFF;
GO



--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx

SELECT * FROM dbo.wFuncionBusquedaMVC('528790550 0-0')






exec wClientes_TX_BusquedaConCUIT '528790550 0-0'
--exec wCartasPorte_TX_Busqueda '528790550 0-0'





select NumeroCartaEnTextoParaBusqueda from CartasDePorte
where	NumeroCartaEnTextoParaBusqueda like '33333'+'%'
			 or SubNumeroVagon like 10 





CREATE NONCLUSTERED INDEX IDX_SubNumeroVagon2
ON CartasDePorte (SubNumeroVagon)




SELECT  
top 5 
	IdCartaDePorte as ID, 
				CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,
			'Carta de porte' AS Tipo, FechaModificacion as fecha
				, '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1
				from CartasDePorte
where	NumeroCartaEnTextoParaBusqueda like '33333'+'%'
or SubNumeroVagon = 33333



--para crear un indice donde el vagon sea el primer campo del índice
CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador6
ON CartasDePorte (SubNumeroVagon,NumeroCartaEnTextoParaBusqueda,FechaArribo,FechaIngreso,FechaModificacion)
go

CREATE NONCLUSTERED INDEX IDX_Clientes_Superbuscador6
ON Clientes (CUIT,RazonSocial,Telefono,Email,FechaAlta)
GO




select SubNumeroVagon from CartasDePorte
where	
SubNumeroVagon = 10
  or 
 CAST(SubNumeroVagon as varchar(100))  like '33333'+'%'

sp_help 'CartasDePorte'



print isnumeric('33333')


declare @q VARCHAR(50)
set @q='33333'

	SELECT 
	top 8
	Cuit
	--IdCliente as ID,
	
	--			CAST(   isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'') as varchar(100)) as Numero    
				

	--			,'Cliente' AS Tipo,  FechaAlta as fecha,
	--			isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1 


	FROM dbo.Clientes 
	WHERE  	-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			
			--(
			--isnumeric(@q)=0 AND
			--(
			--RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
			--OR RazonSocial like  @q + '%'            -- At the beginning of a sentence
			--)
			--)
		 --  or 
		   (
			--isnumeric(@q)=1 AND 
			Cuit LIKE @q+'%'  --dbo.FirstWord(@q)+'%' 
			

		   ) 


