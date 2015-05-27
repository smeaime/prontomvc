


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaPresu_E]
@IdDetalleDefinicionFlujoCaja int 
As 
Delete [DetalleDefinicionesFlujoCajaPresupuestos]
Where (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)


