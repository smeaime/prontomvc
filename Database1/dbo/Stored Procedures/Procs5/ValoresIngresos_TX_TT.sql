































CREATE Procedure [dbo].[ValoresIngresos_TX_TT]
@IdValorIngreso int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111533'
set @vector_T='0555500'
Select 
 IdValorIngreso,
 FechaIngreso as [Fecha],
 Importe,
 Bancos.Nombre as [Banco],
 Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ValoresIngresos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=ValoresIngresos.IdBanco
WHERE (IdValorIngreso=@IdValorIngreso)
































