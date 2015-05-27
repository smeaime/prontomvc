
CREATE PROCEDURE [ProduccionFichas_TX_BOMArbolPorArticulo]
@IdArticuloParametro int
AS 
SET NOCOUNT ON

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='1111111133'
SET @vector_T='9999991100'


declare @IdProduccionFicha int
declare @IdArticuloN0 int
declare @IdArticuloN1 int
declare @IdArticuloN2 int
declare @IdArticuloN3 int
declare @IdColor int

declare @dummy varchar(100)

DECLARE @hoy DATETIME
SET @hoy=GETDATE()


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
			Hoy NUMERIC(18,2),
			
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
			Hoy NUMERIC(18,2),

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
			Hoy NUMERIC(18,2),

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
			Hoy NUMERIC(18,2),
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
			Hoy NUMERIC(18,2),
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
			isnull( articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull( articulos.Descripcion,'') COLLATE DATABASE_DEFAULT ,
			'',
			DET.Cantidad
			from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
	where (CAB.IdArticuloAsociado=@IdArticuloParametro)


DECLARE nv0 CURSOR FOR 
	select 
			IdArticuloN0,
		    IdColor
	from #Auxiliar1


--print 'fin nivel 0'

-------------------------------------
-------------------------------------

OPEN nv0

FETCH NEXT FROM nv0
INTO @IdArticuloN0, @IdColor


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
				'     +----' +isnull(Articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Articulos.Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				DET.Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		where (CAB.IdArticuloAsociado=@IdArticuloN0)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)


	FETCH NEXT FROM nv0 INTO @IdArticuloN0, @IdColor


				 
end


DECLARE nv1 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
		    IdColor
	from #Auxiliar2

--print 'fin nivel 1'
-------------------------------------
-------------------------------------

OPEN nv1

FETCH NEXT FROM nv1
INTO @IdArticuloN0,@IdArticuloN1,@IdColor


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
				'             +----' +isnull(Articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Articulos.Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				DET.Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN1)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)



	FETCH NEXT FROM nv1 INTO @IdArticuloN0,@IdArticuloN1,@IdColor

				 
end


DECLARE nv2 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
			IdArticuloN2,
		    IdColor
	from #Auxiliar3

--print 'fin nivel 2'
-------------------------------------
-------------------------------------

-------------------------------------
-------------------------------------

OPEN nv2

FETCH NEXT FROM nv2
INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdColor


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
				'                 +----'  +isnull(Articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Articulos.Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				DET.Cantidad
		from DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN2)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)




	FETCH NEXT FROM nv2
	INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdColor


				 
end


DECLARE nv3 CURSOR FOR 
	select 
			IdArticuloN0,
			IdArticuloN1,
			IdArticuloN2,
			IdArticuloN3,
		    IdColor
	from #Auxiliar4

--print 'fin nivel 3'
-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------

OPEN nv3

FETCH NEXT FROM nv3
INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdArticuloN3,@IdColor


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
				'                     +----'  +isnull(Articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Articulos.Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				DET.Cantidad
		From DetalleProduccionFichas DET
		 inner join Articulos on DET.idArticulo=Articulos.IdArticulo
		 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
		 WHERE (CAB.IdArticuloAsociado=@IdArticuloN3)
			   and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)




	FETCH NEXT FROM nv3
	INTO @IdArticuloN0, @IdArticuloN1,@IdArticuloN2,@IdArticuloN3,@IdColor
 

				 
end

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


SELECT '',IdArticuloN0,IdArticuloN1,IdArticuloN2,IdArticuloN3,IdArticuloN4
			,Codigo 
			--,Descripcion
			,Hoy as Cantidad
		 ,@Vector_T as Vector_T
		 ,@Vector_X as Vector_X			
FROM #Auxiliar1
order by IdArticuloN0,IdArticuloN1,IdArticuloN2,IdArticuloN3,IdArticuloN4

--hace drop
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5


