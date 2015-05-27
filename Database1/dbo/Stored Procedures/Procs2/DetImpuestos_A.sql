CREATE Procedure [dbo].[DetImpuestos_A]

@IdDetalleImpuesto int output,
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

INSERT INTO [DetalleImpuestos]
(
 IdImpuesto,
 Año,
 Cuota,
 Importe,
 FechaVencimiento1,
 FechaVencimiento2,
 FechaVencimiento3,
 Intereses1,
 Intereses2
)
VALUES
(
 @IdImpuesto,
 @Año,
 @Cuota,
 @Importe,
 @FechaVencimiento1,
 @FechaVencimiento2,
 @FechaVencimiento3,
 @Intereses1,
 @Intereses2
)

SELECT @IdDetalleImpuesto=@@identity

RETURN(@IdDetalleImpuesto)