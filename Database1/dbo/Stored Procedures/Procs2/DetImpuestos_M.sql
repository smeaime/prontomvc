CREATE Procedure [dbo].[DetImpuestos_M]

@IdDetalleImpuesto int,
@IdImpuesto int,
@Año int,
@Cuota int,
@Importe numeric(18,2),
@FechaVencimiento1 datetime,
@FechaVencimiento2 datetime,
@FechaVencimiento3 datetime,
@Intereses1 numeric(18,2),
@Intereses2 numeric(18,2)

AS

UPDATE [DetalleImpuestos]
SET 
 IdImpuesto=@IdImpuesto,
 Año=@Año,
 Cuota=@Cuota,
 Importe=@Importe,
 FechaVencimiento1=@FechaVencimiento1,
 FechaVencimiento2=@FechaVencimiento2,
 FechaVencimiento3=@FechaVencimiento3,
 Intereses1=@Intereses1,
 Intereses2=@Intereses2
WHERE (IdDetalleImpuesto=@IdDetalleImpuesto)

RETURN(@IdDetalleImpuesto)