
CREATE PROCEDURE [ProduccionFichas_TX_BOMSumarizadoPorArticulo]
@IdArticuloParametro int
as

SET NOCOUNT ON

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='111133'
SET @vector_T='111100'


declare @IdProduccionFicha int
declare @IdArticuloN0 int
declare @IdArticuloN1 int
declare @IdArticuloN2 int
declare @IdArticuloN3 int
declare @Cantidad numeric(18,2)
declare @IdColor int

declare @dummy varchar(100)


CREATE TABLE #Auxiliar1
			(
			IdArticuloN0 int,
			IdArticuloN1 int,
			IdArticuloN2 int,
			IdArticuloN3 int,
			IdArticuloN4 int,
		    IdColor int,
			Codigo varchar(100),
			Descripcion varchar(100),
			Cantidad NUMERIC(18,2),
			
			)

CREATE TABLE #Auxiliar2
			(
			IdArticuloN0 int,
			IdArticuloN1 int,
			IdArticuloN2 int,
			IdArticuloN3 int,
			IdArticuloN4 int,
		    IdColor int,
			Codigo varchar(100),
			Descripcion varchar(100),
			Cantidad NUMERIC(18,2),

			)

CREATE TABLE #Auxiliar3
			(
			IdArticuloN0 int,
			IdArticuloN1 int,
			IdArticuloN2 int,
			IdArticuloN3 int,
			IdArticuloN4 int,
		    IdColor int,
			Codigo varchar(100),
			Descripcion varchar(100),
			Cantidad NUMERIC(18,2),

			)

CREATE TABLE #Auxiliar4
			(
			IdArticuloN0 int,
			IdArticuloN1 int,
			IdArticuloN2 int,
			IdArticuloN3 int,
			IdArticuloN4 int,
		    IdColor int,
			Codigo varchar(100),
			Descripcion varchar(100),
			Cantidad NUMERIC(18,2),
			)

CREATE TABLE #Auxiliar5
			(
			IdArticuloN0 int,
			IdArticuloN1 int,
			IdArticuloN2 int,
			IdArticuloN3 int,
			IdArticuloN4 int,
		    IdColor int,
			Codigo varchar(100),
			Descripcion varchar(100),
			Cantidad NUMERIC(18,2),
			)

-------------------------------------
-------------------------------------
insert into #Auxiliar1

	select 
			DET.IdArticulo,
			'',
			'',
			'',
			'',
		    DET.IdColor,
			isnull(Articulos.Codigo,''), 
			isnull(Articulos.Descripcion,''),
			DET.Cantidad
			from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
	where (CAB.IdArticuloAsociado=@IdArticuloParametro)


DECLARE nv0 CURSOR FOR 
	select 
			IdArticuloN0,
		    IdColor
			,Cantidad
	from #Auxiliar1


--print 'fin nivel 0'

-------------------------------------
-------------------------------------

OPEN nv0

FETCH NEXT FROM nv0
INTO @IdArticuloN0, @IdColor,@Cantidad


WHILE @@FETCH_STATUS = 0
BEGIN
	
--print @IdArticuloN0 + ' ' + @IdColor

	insert into #Auxiliar2
		select 
				@IdArticuloN0,
				DET.IdArticulo,
				'',
				'',
				'',
			    DET.IdColor,
				isnull(Articulos.Codigo,''), 
				isnull(Articulos.Descripcion,''),
				DET.Cantidad/CAB.Cantidad*@Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		where (CAB.IdArticuloAsociado=@IdArticuloN0)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)



	FETCH NEXT FROM nv0 INTO @IdArticuloN0, @IdColor,@Cantidad

end


delete #auxiliar1
where idArticuloN0 in (select idArticuloN0 from #Auxiliar2)  --quito de la tabla anterior los que tienen ficha



DECLARE nv1 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
		    IdColor
			,Cantidad
	from #Auxiliar2

--print 'fin nivel 1'
-------------------------------------
-------------------------------------

OPEN nv1

FETCH NEXT FROM nv1
INTO @IdArticuloN0,@IdArticuloN1,@IdColor,@Cantidad


WHILE @@FETCH_STATUS = 0
BEGIN

	insert into #Auxiliar3
		select 
				@IdArticuloN0,
				@IdArticuloN1,
				DET.IdArticulo,
				'',
				'',
			    DET.IdColor,
				isnull(Articulos.Codigo,''), 
				isnull(Articulos.Descripcion,''),
				DET.Cantidad/CAB.Cantidad*@Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN1)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)



	FETCH NEXT FROM nv1 INTO @IdArticuloN0,@IdArticuloN1,@IdColor,@Cantidad

				 
end

delete #auxiliar2
where idArticuloN1 in (select idArticuloN1 from #Auxiliar3)  --quito de la tabla anterior los que tienen ficha



DECLARE nv2 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
			IdArticuloN2,
		    IdColor
			,Cantidad
	from #Auxiliar3

--print 'fin nivel 2'
-------------------------------------
-------------------------------------

-------------------------------------
-------------------------------------

OPEN nv2

FETCH NEXT FROM nv2
INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdColor,@Cantidad


WHILE @@FETCH_STATUS = 0
BEGIN
	
--print @IdArticuloN0 + ' ' + @IdColor

	insert into #Auxiliar4
		select 
				@IdArticuloN0,
				@IdArticuloN1,
				@IdArticuloN2,
				DET.IdArticulo,
				'',
			    DET.IdColor,
				isnull(Articulos.Codigo,''), 
				isnull(Articulos.Descripcion,''),
				DET.Cantidad/CAB.Cantidad*@Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN2)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)




	FETCH NEXT FROM nv2
	INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdColor,@Cantidad


				 
end

delete #auxiliar3
where idArticuloN2 in (select idArticuloN2 from #Auxiliar4)  --quito de la tabla anterior los que tienen ficha


DECLARE nv3 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
			IdArticuloN2,
			IdArticuloN3,
		    IdColor
			,Cantidad
	from #Auxiliar4

--print 'fin nivel 3'
-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------

OPEN nv3

FETCH NEXT FROM nv3
INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdArticuloN3,@IdColor,@Cantidad


WHILE @@FETCH_STATUS = 0
BEGIN
	
--print @IdArticuloN0 + ' ' + @IdColor

	insert into #Auxiliar5
		select 
				@IdArticuloN0,
				@IdArticuloN1,
				@IdArticuloN2,
				@IdArticuloN3,
				DET.IdArticulo,
			    DET.IdColor,
				isnull(Articulos.Codigo,''), 
				isnull(Articulos.Descripcion,''),
				DET.Cantidad/CAB.Cantidad*@Cantidad
		From DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN3)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)




	FETCH NEXT FROM nv3
	INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdArticuloN3,@IdColor,@Cantidad
 

				 
end

delete #auxiliar4
where idArticuloN3 in (select idArticuloN3 from #Auxiliar5)  --quito de la tabla anterior los que tienen ficha

--print 'fin nivel 4'

-------------------------------------
-------------------------------------


--print 'asdasd'

CLOSE nv0
DEALLOCATE nv0
CLOSE nv1
DEALLOCATE nv1
CLOSE nv2
DEALLOCATE nv2
CLOSE nv3
DEALLOCATE nv3


insert into #Auxiliar1
select * from #Auxiliar2

insert into #Auxiliar1
select * from #Auxiliar3

insert into #Auxiliar1
select * from #Auxiliar4

insert into #Auxiliar1
select * from #Auxiliar5


SELECT '',
	Codigo,Descripcion, sum(Cantidad) as Cantidad 
		 ,@Vector_T as Vector_T
		 ,@Vector_X as Vector_X
FROM #Auxiliar1
group by Codigo,Descripcion
order by codigo
--order by IdArticuloN0,IdArticuloN1,IdArticuloN2,IdArticuloN3,IdArticuloN4

--hace drop
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5



