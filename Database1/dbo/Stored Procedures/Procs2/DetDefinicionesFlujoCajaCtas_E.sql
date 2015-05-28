


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaCtas_E]
@IdDetalleDefinicionFlujoCaja int 
As 
Delete [DetalleDefinicionesFlujoCajaCuentas]
Where (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)


