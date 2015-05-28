CREATE Procedure [dbo].[DetClientesDirecciones_E]

@IdDetalleClienteDireccion int  

AS

DELETE DetalleClientesDirecciones
WHERE (IdDetalleClienteDireccion=@IdDetalleClienteDireccion)