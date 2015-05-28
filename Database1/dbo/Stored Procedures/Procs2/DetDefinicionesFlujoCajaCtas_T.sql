


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaCtas_T]
@IdDetalleDefinicionFlujoCaja int
AS 
SELECT *
FROM [DetalleDefinicionesFlujoCajaCuentas]
WHERE (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)


