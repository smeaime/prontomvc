





CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasAGenerar]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdVentaEnCuotas INTEGER,
			 Cuota INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  vec.IdVentaEnCuotas,
  (Select Max(Cuota) From DetalleVentasEnCuotas
   Where vec.IdVentaEnCuotas=DetalleVentasEnCuotas.IdVentaEnCuotas)
 FROM VentasEnCuotas vec
 WHERE Estado is null  

UPDATE #Auxiliar1
SET Cuota=0 
WHERE Cuota is null

SET NOCOUNT OFF


Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111633'
Set @vector_T='00904434300'

SELECT 
 vec.IdVentaEnCuotas,
 Clientes.RazonSocial as [Cliente],
 -1 as [DetVta],
 Substring(Articulos.Descripcion,1,80) as [Bien / Producto],
 vec.FechaPrimerVencimiento as [Fec.1er.Vto.],
 vec.CantidadCuotas as [Cant. cuotas],
 vec.CantidadCuotas - #Auxiliar1.Cuota as [Ctas.rest.],
 #Auxiliar1.Cuota+1 as [Cuota a gen.],
 vec.ImporteCuota as [Importe cuota],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM VentasEnCuotas vec
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=vec.IdRealizo
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdVentaEnCuotas=vec.IdVentaEnCuotas
WHERE Estado is null and #Auxiliar1.Cuota<vec.CantidadCuotas
ORDER by Clientes.RazonSocial,vec.FechaOperacion

DROP TABLE #Auxiliar1





