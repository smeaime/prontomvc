CREATE Procedure [dbo].[DetClientesTelefonos_T]

@IdDetalleClienteTelefono int

AS 

SELECT *
FROM DetalleClientesTelefonos
WHERE (IdDetalleClienteTelefono=@IdDetalleClienteTelefono)