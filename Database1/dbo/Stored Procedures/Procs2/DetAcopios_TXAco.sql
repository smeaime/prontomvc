





























CREATE PROCEDURE [dbo].[DetAcopios_TXAco]
@IdAcopio int
as
declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='0011111111110111100000000000000000011033'
set @vector_T='0001021122030114500000000000000000013000'
SELECT
DetAco.IdDetalleAcopios,
DetAco.IdAcopio,
DetAco.NumeroItem as [Item],
DetAco.Revision as [Rev.],
DetAco.Cantidad as [Cant.],
( SELECT Unidades.Abreviatura
	FROM Unidades
	WHERE Unidades.IdUnidad=DetAco.IdUnidad) as  [Unidad en],
DetAco.Cantidad1 as [Med1],
DetAco.Cantidad2 as [Med2],
DetAco.Precio as [Precio Un.],
CASE 	WHEN DetAco.Cantidad is not null and DetAco.Precio is not null 
	THEN (DetAco.Cantidad * DetAco.Precio)
	ELSE Null
END as [Importe],
ControlesCalidad.Abreviatura as [CC],
DetAco.FechaNecesidad as [Fecha nec.],
DetAco.IdArticulo,
Articulos.Descripcion as [Articulo],
Proveedores.RazonSocial as [Proveedor asignado],
( SELECT Empleados.Iniciales
	FROM Empleados
	WHERE Empleados.IdEmpleado=DetAco.IdLlamadoAProveedor) as  [Llamado por],
DetAco.FechaLlamadoAProveedor as [Fecha llamada],
DetAco.Peso,
( SELECT Unidades.Abreviatura
	FROM Unidades
	WHERE Unidades.IdUnidad=DetAco.IdUnidadPeso) as  [Unidad],
DetAco.IdControlCalidad,
ControlesCalidad.Descripcion as [Control de Calidad],
DetAco.Adjunto,
DetAco.ArchivoAdjunto,
DetAco.Observaciones,
DetAco.IdUnidad,
DetAco.ArchivoAdjunto1,
DetAco.ArchivoAdjunto2,
DetAco.ArchivoAdjunto3,
DetAco.ArchivoAdjunto4,
DetAco.ArchivoAdjunto5,
DetAco.ArchivoAdjunto6,
DetAco.ArchivoAdjunto7,
DetAco.ArchivoAdjunto8,
DetAco.ArchivoAdjunto9,
DetAco.ArchivoAdjunto10,
DetAco.Cumplido as [Cump.],
(SELECT SUM(DetalleReservas.CantidadUnidades) 
	FROM DetalleReservas 
	WHERE DetalleReservas.IdDetalleAcopios=DetAco.IdDetalleAcopios) 
	as [Reservado],
Equipos.Tag as [Equipo],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetAco.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Proveedores ON DetAco.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Equipos ON DetAco.IdEquipo = Equipos.IdEquipo
WHERE (DetAco.IdAcopio = @IdAcopio)
ORDER By DetAco.NumeroItem






























