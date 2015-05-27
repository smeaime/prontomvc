





















CREATE  Procedure [dbo].[Conjuntos_TX_PorIdConDatos]

@IdConjunto int

AS 

SELECT 
 Conjuntos.IdConjunto,
 Articulos.Codigo [Codigo],
 Articulos.Descripcion as [Articulo conjunto],
 Conjuntos.CodigoConjunto as [Codigo conjunto],
 Conjuntos.FechaRegistro as [Fecha creacion],
 (Select Top 1 Empleados.Nombre from Empleados 
  Where Conjuntos.IdRealizo=Empleados.IdEmpleado) as [Realizada por],
 (Select Count(*) From  DetalleConjuntos 
  Where DetalleConjuntos.IdConjunto=Conjuntos.IdConjunto) as [Cant.Items],
 Conjuntos.Observaciones
FROM Conjuntos
LEFT OUTER JOIN Articulos ON Conjuntos.IdArticulo = Articulos.IdArticulo
WHERE (IdConjunto=@IdConjunto)






















