


CREATE Procedure [dbo].[DetDefinicionAnulaciones_E]
@IdDetalleDefinicionAnulacion int  
As 
Delete [DetalleDefinicionAnulaciones]
Where (IdDetalleDefinicionAnulacion=@IdDetalleDefinicionAnulacion)


