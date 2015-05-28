

CREATE Procedure [dbo].[DetControlesCalidad_E]
@IdDetalleControlCalidad int  
AS 
DELETE [DetalleControlesCalidad]
WHERE (IdDetalleControlCalidad=@IdDetalleControlCalidad)

