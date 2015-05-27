




CREATE Procedure [dbo].[ControlesCalidad_TX_PorId]
@IdControlCalidad int
AS 
SELECT *
FROM ControlesCalidad
WHERE (IdControlCalidad=@IdControlCalidad)




