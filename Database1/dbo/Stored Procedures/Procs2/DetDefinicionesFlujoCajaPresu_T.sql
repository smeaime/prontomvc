


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaPresu_T]
@IdDetalleDefinicionFlujoCaja int
AS 
SELECT *
FROM [DetalleDefinicionesFlujoCajaPresupuestos]
WHERE (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)


