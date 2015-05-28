


CREATE Procedure [dbo].[Articulos_TX_PorFechaAlta]

@FechaAlta datetime

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111133'
Set @vector_T='0191G00'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.IdArticulo as [IdAux],
 Articulos.NumeroInventario as [Nro.inv.],
 Articulos.Descripcion,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
WHERE (FechaAlta=@FechaAlta)


