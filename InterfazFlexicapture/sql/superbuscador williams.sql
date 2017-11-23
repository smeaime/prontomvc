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



--union all?



	SELECT 
	top 10
	
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
				)
			)
		   OR
			 RazonSocial like  @q + '%'            -- At the beginning of a sentence

		   or 
		   (
			--isnumeric(@q)=1 AND 
			Cuit LIKE @q+'%'  --dbo.FirstWord(@q)+'%' 
			

		   ) 
		   --or 
		   --isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%' 
		

	UNION all


	SELECT  
	top 10 
			IdCartaDePorte as ID,	
			NumeroCartaEnTextoParaBusqueda as Numero,
			-- CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,
			'Carta de porte' AS Tipo, FechaModificacion as fecha
			, '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1

	FROM dbo.CartasDePorte 
	WHERE  
			isnull(SubNumeroDeFacturacion,0)<=0 
			and
			--(SubNumeroDeFacturacion=0 or SubNumeroDeFacturacion=-1 or SubnumeroDeFacturacion IS NULL) AND --sirve hacer este filtro? es contraproducente?
				isnumeric( dbo.FirstWord(@q))=1  
			and
			(
			-- http://stackoverflow.com/questions/2640048/sql-how-to-get-the-left-3-numbers-from-an-int
		--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
		--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
		--In general the CAST will kill performance because it invalidates any use of index seeks as 
		--Martin Smith's last example shows. CASTing to nvarchar(max) or to a different length means a 
		--different data type: the fact it's all nvarchar is irrelevant.

			--NumeroCartaEnTextoParaBusqueda like dbo.FirstWord(@q)+'%'
			NumeroCartaEnTextoParaBusqueda like @q+'%'
			
			-- or SubNumeroVagon = dbo.convertInt(@q)   --pueden llegar a buscar el vagon por la mitad? porque si no le meto un "igual"
			or SubNumeroVagonEnTextoParaBusqueda LIKE @q+'%'

			--OR		(SubNumeroVagon>0 and	SubNumeroVagon  =  dbo.convertInt(@q ) )
			-- as varchar(6))  like dbo.FirstWord(@q)+'%'
		   --OR
		   --CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%' 
		   )

		   --para test: SELECT * FROM dbo.wFuncionBusqueda('534489')	


	--UNION all


	--SELECT  
	--top 10 
	--IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha
	--			, '' as item1
	--FROM dbo.Facturas
	--WHERE 
	--	NumeroFactura  LIKE dbo.FirstWord(@q)+'%'
	-- ORDER BY IdFactura desc


               ) 

               
 GO
              
--SELECT * FROM dbo.wFuncionBusqueda('534489')	
--SELECT * FROM dbo.wFuncionBusqueda('5')	
-- wUltimosComprobantesCreados ''


SELECT dbo.FirstWord('3333333')
go
--DBCC CHECKDB


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--y lo de fulltextsearch? por qué fue que lo abandoné? había una razon, pero ya no recuerdo cual

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wFuncionBusqueda'))
    DROP FUNCTION [dbo].wFuncionBusquedaNumerico
go

CREATE FUNCTION wFuncionBusquedaNumerico (@q VARCHAR(50))



RETURNS TABLE AS
RETURN (

--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5

--ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)



--union all?



	SELECT 
	top 10
	
	IdCliente as ID,
	
				CAST(   isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'') as varchar(100)) as Numero    
				

				,'Cliente' AS Tipo,  FechaAlta as fecha,
				isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1 


	FROM dbo.Clientes 
	WHERE  	-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			
			 RazonSocial like  @q + '%'            -- At the beginning of a sentence

		   or 
		   (
			--isnumeric(@q)=1 AND 
			Cuit LIKE @q+'%'  --dbo.FirstWord(@q)+'%' 
			

		   ) 
		   --or 
		   --isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%' 
		

	UNION all


	SELECT  
	top 10 
			IdCartaDePorte as ID,	
			NumeroCartaEnTextoParaBusqueda as Numero,
			-- CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,
			'Carta de porte' AS Tipo, FechaModificacion as fecha
			, '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1

	FROM dbo.CartasDePorte 
	WHERE  
			isnull(SubNumeroDeFacturacion,0)<=0 
			and
			--(SubNumeroDeFacturacion=0 or SubNumeroDeFacturacion=-1 or SubnumeroDeFacturacion IS NULL) AND --sirve hacer este filtro? es contraproducente?
				isnumeric( dbo.FirstWord(@q))=1  
			and
			(
			-- http://stackoverflow.com/questions/2640048/sql-how-to-get-the-left-3-numbers-from-an-int
		--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
		--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx
		--In general the CAST will kill performance because it invalidates any use of index seeks as 
		--Martin Smith's last example shows. CASTing to nvarchar(max) or to a different length means a 
		--different data type: the fact it's all nvarchar is irrelevant.

			--NumeroCartaEnTextoParaBusqueda like dbo.FirstWord(@q)+'%'
			NumeroCartaEnTextoParaBusqueda like @q+'%'
			
			-- or SubNumeroVagon = dbo.convertInt(@q)   --pueden llegar a buscar el vagon por la mitad? porque si no le meto un "igual"
			or SubNumeroVagonEnTextoParaBusqueda LIKE @q+'%'

			--OR		(SubNumeroVagon>0 and	SubNumeroVagon  =  dbo.convertInt(@q ) )
			-- as varchar(6))  like dbo.FirstWord(@q)+'%'
		   --OR
		   --CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%' 
		   )

		   --para test: SELECT * FROM dbo.wFuncionBusqueda('534489')	


	--UNION all


	--SELECT  
	--top 10 
	--IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha
	--			, '' as item1
	--FROM dbo.Facturas
	--WHERE 
	--	NumeroFactura  LIKE dbo.FirstWord(@q)+'%'
	-- ORDER BY IdFactura desc


               ) 

               
 GO
              
--SELECT * FROM dbo.wFuncionBusqueda('534489')	
--SELECT * FROM dbo.wFuncionBusqueda('5')	
-- wUltimosComprobantesCreados ''


SELECT dbo.FirstWord('3333333')
go
--DBCC CHECKDB


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wBusqueda')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wBusqueda
go

CREATE PROCEDURE wBusqueda
    @q VARCHAR(50)
WITH RECOMPILE
AS


-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
--PARAMETER SNIFFING - The query plan that is cached is not Optimal for the particular Parameters 
--you are passing in, even though the query itself has not changed. For example, if you pass 
--in a Parameter which only retrieves 10 out of 1,000,000 rows, then the 
--Query Plan created may use a Hash Join, however if the Parameter you pass 
--in will use 750,000 of the 1,000,000 rows, the Plan created may be an Index Scan or Table Scan. 
--In such a situation you can tell the SQL statement to use the option OPTION (RECOMPILE) or an 
--SP to use WITH RECOMPILE. To tell the Engine this is a "Single Use Plan" and not to use a 
--Cached Plan which likely does not apply. There is no rule on how to make this decision, it 
--depends on knowing they way the Query will be used by users.

--if				isnumeric(@q)>0 -- pinta que no se da cuenta de que no tiene que gastarse si esto no se cumple
--begin

--	SELECT top 20 * 
--	FROM dbo.wFuncionBusquedaNumerico(@q) 
----	group by Numero
--	order by Fecha desc
--	end
--	else
--	begin
	SELECT top 20 * 
	FROM dbo.wFuncionBusqueda(@q) 
--	group by Numero
	order by Fecha desc
--	end

GO


--EXEC wBusqueda '102354235235'
--EXEC wBusqueda '10'

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

exec wBusqueda '20306762'
exec wBusqueda '20306762 0-0'
SELECT * FROM dbo.wFuncionBusqueda('20306762 0-0')	
SELECT * FROM dbo.wFuncionBusqueda('3333333')	
SELECT * FROM dbo.wFuncionBusqueda('caso')	
SELECT * FROM dbo.wFuncionBusqueda('da')	
SELECT * FROM dbo.wFuncionBusqueda('300')	
SELECT * FROM dbo.wFuncionBusqueda('1111')	
SELECT * FROM dbo.wFuncionBusqueda('1311111')	
SELECT * FROM dbo.wFuncionBusqueda('523469')	

SELECT * FROM dbo.wFuncionBusqueda('528790550')
SELECT * FROM dbo.wFuncionBusqueda('528790550 0-0')

exec wClientes_TX_BusquedaConCUIT '528790550 0-0'



EXEC wBusqueda 'caso'
EXEC wBusqueda '333333'


SELECT * FROM dbo.wFuncionBusqueda('30-68296681-1')	
SELECT * FROM dbo.wFuncionBusqueda('30682966811')


print dbo.FirstWord ('30-68296681-1')
	
exec wBusqueda '30'
exec wBusqueda '528790550 0-0'
SET STATISTICS TIME ON;
GO
SET STATISTICS TIME OFF;
GO



--cómo conseguir un INDEX SEEK en lugar de un INDEX SCAN ?????? http://myitforum.com/cs2/blogs/jnelson/archive/2007/11/16/108354.aspx

SELECT * FROM dbo.wFuncionBusqueda('528790550 0-0')






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


