
CREATE Procedure ProduccionPartes_TX_ProcesoAnteriorCerrado
@IdProduccionOrden int,
@IdProduccionProceso int
AS 

--return select * from produccionprocesos

declare @idDet int

--este SP solo debiera llamarse si el proceso en cuestion valida final del anterior

if not exists (SELECT *
					FROM ProduccionProcesos
					WHERE idproduccionproceso=@idproduccionproceso and validaFinal='SI') 
	begin
		--print 'El proceso no valida el anterior'
		set @iddet=-1 --para no poner un return vacio y que el MTS se vuelva loco
	end
else
	begin

		--acá lo que tengo que hacer es buscar el idDetalleProduccionOrden mayor con idproduccionproceso menor a @IdProduccionProceso
		

		/*
		SELECT @idDet=max( idproduccionproceso )
		FROM DetalleProduccionOrdenes DET
		WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
		and idproduccionproceso<@idproduccionproceso
		*/

		SELECT @idDet=max( idproduccionproceso )
		FROM DetalleProduccionOrdenProcesos DET
		WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
		and idproduccionproceso<@idproduccionproceso
	end




SELECT distinct PP.idProduccionParte,Produccionprocesos.descripcion as Proceso,PP.idArticulo,
	PP.IdProduccionOrden,
	

	idDetalleProduccionOrden,
	DET.Cantidad, --si pongo esta, se repiten renglones, pues puede haber articulos 
					-- repetidos en la OP con distintas cantidades... -No es buen argumento! pues si se repiten los articulos,
					-- el avance tambien tiene que ser diferenciado. Y de todos modos, tambien vas a tener que sacar	
					-- el idDetalleProduccionOrden
	DET.Tolerancia,
	dbo.fProduccionAvanzadoMaterial (@IdProduccionOrden,PP.idArticulo,EMPAQUES.idcolor) as avanzado, 
	DET.Cantidad-dbo.fProduccionAvanzadoMaterial (PP.IdProduccionOrden,PP.idArticulo,EMPAQUES.idcolor) as restante,
	(DET.Cantidad/100*(100- DET.Tolerancia)) as minimo,
	FechaFinal 
FROM ProduccionPartes PP
join Produccionprocesos on PP.idProduccionProceso=Produccionprocesos.idProduccionProceso
LEFT OUTER JOIN Stock ON Stock.Idstock= PP.Idstock
LEFT OUTER JOIN UnidadesEmpaque EMPAQUES ON Stock.NumeroCaja= EMPAQUES.NumeroUnidad
left outer join DetalleProduccionOrdenes DET on PP.idProduccionProceso=DET.idProduccionProceso and DET.IdProduccionOrden=PP.IdProduccionOrden and DET.idarticulo=PP.idArticulo
WHERE (PP.IdProduccionOrden=@IdProduccionOrden)
	and
		(DET.IdProduccionOrden=@IdProduccionOrden  or DET.IdProduccionOrden is null)
	and
		PP.idproduccionproceso=@iddet
	and
				
		(
			FechaFinal is null

			OR
			
			dbo.fProduccionAvanzadoMaterial (PP.IdProduccionOrden,PP.idArticulo,EMPAQUES.IdColor) < 
				(DET.Cantidad/100*(100- DET.Tolerancia))
		)






