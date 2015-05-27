

CREATE Procedure [dbo].[DetControlesCalidad_T]
@IdDetalleControlCalidad int
AS 
SELECT *
FROM [DetalleControlesCalidad]
WHERE (IdDetalleControlCalidad=@IdDetalleControlCalidad)

