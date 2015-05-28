
CREATE PROCEDURE [ProduccionOrdenes_TX_NecesidadDePlanificacionDeProduccion]

AS 
SET NOCOUNT ON

Declare @vector_X varchar(50),@vector_T varchar(50)


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
			Semana1 NUMERIC(18,2),
			Semana2 NUMERIC(18,2),
			Semana3 NUMERIC(18,2),
			
			Semana4 NUMERIC(18,2),
			Semana5 NUMERIC(18,2),
			Semana6 NUMERIC(18,2),
			Semana7 NUMERIC(18,2),
			Semana8 NUMERIC(18,2),
			
			vector_X varchar(50),
			vector_T varchar(50)
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
			Semana1 NUMERIC(18,2),
			Semana2 NUMERIC(18,2),
			Semana3 NUMERIC(18,2),
			Semana4 NUMERIC(18,2),
			Semana5 NUMERIC(18,2),
			Semana6 NUMERIC(18,2),
			Semana7 NUMERIC(18,2),
			Semana8 NUMERIC(18,2),

			vector_X varchar(50),
			vector_T varchar(50)
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
			Semana1 NUMERIC(18,2),
			Semana2 NUMERIC(18,2),
			Semana3 NUMERIC(18,2),
			Semana4 NUMERIC(18,2),
			Semana5 NUMERIC(18,2),
			Semana6 NUMERIC(18,2),
			Semana7 NUMERIC(18,2),
			Semana8 NUMERIC(18,2),

			vector_X varchar(50),
			vector_T varchar(50)
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
			Semana1 NUMERIC(18,2),
			Semana2 NUMERIC(18,2),
			Semana3 NUMERIC(18,2),
			Semana4 NUMERIC(18,2),
			Semana5 NUMERIC(18,2),
			Semana6 NUMERIC(18,2),
			Semana7 NUMERIC(18,2),
			Semana8 NUMERIC(18,2),

			vector_X varchar(50),
			vector_T varchar(50)
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
			Semana1 NUMERIC(18,2),
			Semana2 NUMERIC(18,2),
			Semana3 NUMERIC(18,2),
			Semana4 NUMERIC(18,2),
			Semana5 NUMERIC(18,2),
			Semana6 NUMERIC(18,2),
			Semana7 NUMERIC(18,2),
			Semana8 NUMERIC(18,2),

			vector_X varchar(50),
			vector_T varchar(50)
			)

-------------------------------------
-------------------------------------
insert into #Auxiliar1

	select 
			IdArticulo,
			'',
			'',
			'',
			'',
		    IdColor,
			isnull( articulos.Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull( articulos.Descripcion,'') COLLATE DATABASE_DEFAULT ,
			'',
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as Semana1,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as Semana2,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as Semana3,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as Semana4,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as Semana5,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as Semana6,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as Semana7,
			dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as Semana8,
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
	from articulos --estoy usando como fecha final dos meses despues de hoy
	left outer join tipos on tipos.idtipo=articulos.idtipo
	where 	dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy) ,@hoy) < 0
			and (tipos.Descripcion='Semielaborado' or tipos.Descripcion='Terminado' )


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
				IdArticulo,
				'',
				'',
				'',
			    IdColor,
				'     +----' +isnull(Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as Semana1,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as Semana2,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as Semana3,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as Semana4,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as Semana5,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as Semana6,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as Semana7,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as Semana8,
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
		from articulos --estoy usando como fecha final dos meses despues de hoy
		where IdArticulo in 
				(
				 select IdArticulo
				 from DetalleProduccionFichas DET
				 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
				 WHERE (CAB.IdArticuloAsociado=@IdArticuloN0)
				 and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)
				 )



	FETCH NEXT FROM nv0 INTO @IdArticuloN0, @IdColor


				 
end

/*


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
				IdArticulo,
				'',
				'',
			    IdColor,
				'             +----' +isnull(Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Descripcion,'') COLLATE DATABASE_DEFAULT,
				Descripcion,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as Semana1,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as Semana2,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as Semana3,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as Semana4,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as Semana5,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as Semana6,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as Semana7,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as Semana8,
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
		from articulos --estoy usando como fecha final dos meses despues de hoy
		where IdArticulo in 
				(
				 select IdArticulo
				 from DetalleProduccionFichas DET
				 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
				 WHERE (CAB.IdArticuloAsociado=@IdArticuloN1)
				 and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)
				 )



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
				IdArticulo,
				'',
			    IdColor,
				'                 +----' +isnull(Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as Semana1,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as Semana2,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as Semana3,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as Semana4,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as Semana5,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as Semana6,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as Semana7,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as Semana8,
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
		from articulos --estoy usando como fecha final dos meses despues de hoy
		where IdArticulo in 
				(
				 select IdArticulo
				 from DetalleProduccionFichas DET
				 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
				 WHERE (CAB.IdArticuloAsociado=@IdArticuloN2)
				 and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)
				 )



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
				IdArticulo,
			    IdColor,
				'                     +----' +isnull(Codigo,'') COLLATE DATABASE_DEFAULT + ' :: ' +isnull(Descripcion,'') COLLATE DATABASE_DEFAULT,
				'',
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as Semana1,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as Semana2,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as Semana3,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as Semana4,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as Semana5,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as Semana6,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as Semana7,
				dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as Semana8,
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
		from articulos --estoy usando como fecha final dos meses despues de hoy
		where IdArticulo in 
				(
				 select IdArticulo
				 from DetalleProduccionFichas DET
				 inner join ProduccionFichas CAB on CAB.IdProduccionFicha=DET.IdProduccionFicha
				 WHERE (CAB.IdArticuloAsociado=@IdArticuloN3)
				 and (CAB.IdColor=@IdColor or @Idcolor=0 or @Idcolor is null)
				 )



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



*/


---------------123456789012345678901234567890	
Set @vector_X='0111111111133'
SET @vector_T='0155555555500'


SELECT		''
			,Codigo 
			--,Descripcion
			,Hoy
			
			,Semana1 as [Semana 1]
			,Semana2 as [Semana 2]
			,Semana3 as [Semana 3]
			,Semana4 as [Semana 4]
			,Semana5 as [Semana 5]
			
			,Semana6 as [Semana 6]
			,Semana7 as [Semana 7]
			,Semana8 as [Semana 8]
			,@Vector_T as Vector_T,
			@Vector_X as Vector_X

FROM #Auxiliar1
order by IdArticuloN0,IdArticuloN1,IdArticuloN2,IdArticuloN3,IdArticuloN4

--hace drop
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5


