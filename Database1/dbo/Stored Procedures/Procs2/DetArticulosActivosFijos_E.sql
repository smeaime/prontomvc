














CREATE Procedure [dbo].[DetArticulosActivosFijos_E]
@IdDetalleArticuloActivosFijos int  
As 
Delete [DetalleArticulosActivosFijos]
Where (IdDetalleArticuloActivosFijos=@IdDetalleArticuloActivosFijos)















