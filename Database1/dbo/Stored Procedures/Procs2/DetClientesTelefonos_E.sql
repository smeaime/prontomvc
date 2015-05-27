CREATE Procedure [dbo].[DetClientesTelefonos_E]

@IdDetalleClienteTelefono int  

AS

DELETE DetalleClientesTelefonos
WHERE (IdDetalleClienteTelefono=@IdDetalleClienteTelefono)