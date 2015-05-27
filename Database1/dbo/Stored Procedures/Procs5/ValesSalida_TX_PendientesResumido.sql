CREATE PROCEDURE [dbo].[ValesSalida_TX_PendientesResumido]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='055792825525500'

SELECT
 ValesSalida.IdValeSalida,
 ValesSalida.NumeroValeSalida as [Vale],
 ValesSalida.FechaValeSalida as [Fecha],
 Obras.NumeroObra as [Obra],
 ValesSalida.IdValeSalida as [IdAux],
 Case When IsNull(ValesSalida.Cumplido,'NO')='SI' Then 'SI'
		When Exists(Select Top 1 Det.IdValeSalida From DetalleValesSalida Det Where Det.IdValeSalida=ValesSalida.IdValeSalida and IsNull(Det.Cumplido,'NO')='SI') Then 'PA'
		Else Null
 End as [Cumplido],
 ValesSalida.Observaciones as [Observaciones],
 e1.Nombre as [Anulo],
 ValesSalida.FechaAnulacion as [Fecha anulacion],
 ValesSalida.MotivoAnulacion as [Motivo anulacion],
 e2.Nombre as [Dio por cumplido],
 ValesSalida.FechaAnulacion as [Fecha dio por cumplido],
 ValesSalida.MotivoAnulacion as [Motivo dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ValesSalida
LEFT OUTER JOIN Obras ON ValesSalida.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados e1 ON e1.IdEmpleado = ValesSalida.IdUsuarioAnulo
LEFT OUTER JOIN Empleados e2 ON e2.IdEmpleado = ValesSalida.IdUsuarioDioPorCumplido
WHERE IsNull(ValesSalida.Cumplido,'')<>'SI' 
