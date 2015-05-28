





























CREATE Procedure [dbo].[ControlesCalidad_T]
@IdControlCalidad int
AS 
SELECT *
FROM ControlesCalidad
where (IdControlCalidad=@IdControlCalidad)






























