

CREATE Procedure [dbo].[DetControlesCalidad_GrabarRemitoRechazo]

@IdDetalleControlCalidad int,
@NumeroRemitoRechazo int,
@FechaRemitoRechazo datetime,
@IdProveedorRechazo int

AS 

UPDATE [DetalleControlesCalidad]
SET 
 NumeroRemitoRechazo=@NumeroRemitoRechazo,
 FechaRemitoRechazo=@FechaRemitoRechazo,
 IdProveedorRechazo=@IdProveedorRechazo
WHERE (IdDetalleControlCalidad=@IdDetalleControlCalidad)

