CREATE  Procedure [dbo].[Conjuntos_TX_Finales]

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111133'
set @vector_T='05F7513500'

SELECT 
 Conjuntos.IdConjunto,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo conjunto],
 Conjuntos.CodigoConjunto as [Codigo conjunto],
 Conjuntos.FechaRegistro as [Fecha creacion],
 (Select Top 1 Empleados.Nombre from Empleados Where Conjuntos.IdRealizo=Empleados.IdEmpleado) as [Realizada por],
 (Select Top 1 Count(*) from DetalleConjuntos Where DetalleConjuntos.IdConjunto=Conjuntos.IdConjunto) as [Cant.Items],
 Conjuntos.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Conjuntos
LEFT OUTER JOIN Articulos ON Conjuntos.IdArticulo = Articulos.IdArticulo
WHERE not Exists(Select Top 1 dc.IdDetalleConjunto From DetalleConjuntos dc Where dc.IdArticulo=Conjuntos.IdArticulo)
ORDER BY Articulos.Descripcion,Articulos.Codigo