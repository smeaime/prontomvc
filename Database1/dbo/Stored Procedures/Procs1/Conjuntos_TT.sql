CREATE  Procedure [dbo].[Conjuntos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='05F75213500'

SELECT 
 Conjuntos.IdConjunto,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo conjunto],
 Conjuntos.CodigoConjunto as [Codigo conjunto],
 Conjuntos.FechaRegistro as [Fecha creacion],
 Conjuntos.Version as [Version],
 (Select Top 1 Empleados.Nombre from Empleados Where Conjuntos.IdRealizo=Empleados.IdEmpleado) as [Realizada por],
 (Select Top 1 Count(*) from DetalleConjuntos Where DetalleConjuntos.IdConjunto=Conjuntos.IdConjunto) as [Cant.Items],
 Conjuntos.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Conjuntos
LEFT OUTER JOIN Articulos ON Conjuntos.IdArticulo = Articulos.IdArticulo
ORDER BY Articulos.Descripcion,Articulos.Codigo