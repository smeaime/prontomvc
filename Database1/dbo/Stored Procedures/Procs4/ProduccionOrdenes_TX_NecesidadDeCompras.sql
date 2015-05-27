
CREATE PROCEDURE [ProduccionOrdenes_TX_NecesidadDeCompras]

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='1111111111133'
SET @vector_T='EE11111111100'


DECLARE @hoy DATETIME
SET @hoy=GETDATE()


select 
		Codigo,
		Descripcion,
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,@hoy,@hoy) as Hoy,
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,1,@hoy),@hoy) as [Semana 1],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,2,@hoy),@hoy) as [Semana 2],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,3,@hoy),@hoy) as [Semana 3],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,4,@hoy),@hoy) as [Semana 4],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,5,@hoy),@hoy) as [Semana 5],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,6,@hoy),@hoy) as [Semana 6],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,7,@hoy),@hoy) as [Semana 7],
		dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy),@hoy) as [Semana 8],
				 @Vector_T as Vector_T,
				 @Vector_X as Vector_X				
from articulos --estoy usando como fecha final dos meses despues de hoy
where 	dbo.fProduccion_StockPrevistoPorDia(idArticulo,dateadd(ww,8,@hoy) ,@hoy) < 0
		and idarticulo not in (select idarticuloasociado from ProduccionFichas)




