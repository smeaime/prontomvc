






CREATE PROCEDURE [dbo].[Acopios_TX_PendientesPorLA1]

@TiposComprobante varchar(1)

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='024441900'

SELECT 
 DetAco.IdAcopio,
 Acopios.NumeroAcopio as [L.Acopio],
 Acopios.Fecha as [Fecha],
 Empleados.Nombre as [Comprador],
 Obras.NumeroObra as [Obra],
 Acopios.Estado as [Cump.],
 DetAco.IdAcopio,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra=Obras.IdObra
LEFT OUTER JOIN Empleados ON Acopios .IdComprador = Empleados.IdEmpleado
WHERE Acopios.Aprobo is not null AND 
	 (@TiposComprobante='T' or DetAco.Cumplido is null or (DetAco.Cumplido<>'SI' and DetAco.Cumplido<>'AN')) AND 
/*	 (@TiposComprobante='T' or DetAco.IdProveedor is null) AND 	*/
	 (@TiposComprobante='T' or DetAco.IdAproboAlmacen is not null)
GROUP BY DetAco.IdAcopio,Acopios.NumeroAcopio,Acopios.Fecha,Obras.NumeroObra,Empleados.Nombre,Acopios.Estado
ORDER BY Acopios.NumeroAcopio






