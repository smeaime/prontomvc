CREATE Procedure [dbo].[DetClientesDirecciones_T]

@IdDetalleClienteDireccion int

AS 

SELECT *
FROM DetalleClientesDirecciones
WHERE (IdDetalleClienteDireccion=@IdDetalleClienteDireccion)