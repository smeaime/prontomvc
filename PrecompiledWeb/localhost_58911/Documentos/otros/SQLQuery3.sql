
declare @q VARCHAR(50)
set @q='55'

--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5
--si sacas los ORDER, parece que no anda en SQL2000/5
--Sometimes you need to have the ORDER BY in each of the sections that need to be combined with UNION.

--In this case

--SELECT * FROM ( SELECT table1.field1 FROM table1 ORDER BY table1.field1 ) DUMMY_ALIAS1

--UNION ALL

--SELECT * FROM ( SELECT table2.field1 FROM table2 ORDER BY table2.field1 ) DUMMY_ALIAS2
--ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)




	SELECT TOP 100 IdCliente as ID,isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'')  as Numero
				,'Cliente' AS Tipo,  FechaAlta as fecha,
				isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1 
	FROM dbo.Clientes 
	WHERE  	-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
			OR RazonSocial like  @q + '%'            -- At the beginning of a sentence


		   or 
		   Cuit LIKE @q+'%'  
		   or 
		   isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%' 
	--order by FechaAlta desc

	UNION 

	SELECT TOP 100 IdCartaDePorte as ID, 
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

	--order by FechaModificacion desc

	UNION 

	--SELECT TOP 100 IdRequerimiento,CAST(NumeroRequerimiento  as varchar(100)),'Requerimiento' AS Tipo, FechaRequerimiento as fecha
	--			, '' as item1
	--FROM requerimientos
	--WHERE NumeroRequerimiento LIKE @q+'%'
	--ORDER BY requerimientos.IdRequerimiento  desc

	--UNION

	SELECT TOP 100 IdArticulo,CAST(Descripcion  as varchar(100)),'Articulo' AS Tipo, FechaAlta as fecha
				, '' as item1
	FROM Articulos
	WHERE codigo LIKE @q+'%'or
		  Descripcion LIKE @q+'%' or
		  Descripcion like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence

	--UNION

	--SELECT TOP 100 IdPedido,CAST(NumeroPedido  as varchar(100)),'Pedido' AS Tipo,FechaPedido as fecha
	--			, '' as item1
	--FROM pedidos
	--WHERE NumeroPedido LIKE @q+'%'
	----ORDER BY IdPedido desc
 
	UNION all

	SELECT TOP 100 IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha
				, '' as item1
	FROM dbo.Facturas
	WHERE NumeroFactura LIKE @q+'%'
	

	