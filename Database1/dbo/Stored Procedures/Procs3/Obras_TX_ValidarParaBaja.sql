CREATE PROCEDURE [dbo].[Obras_TX_ValidarParaBaja]

@IdObra int

AS

SELECT IdObra, 'Cuentas contables' as [Tipo]
FROM Cuentas 
WHERE IsNull(IdObra,0)=@IdObra

UNION ALL

SELECT IdObra, 'Comprobantes proveedores' as [Tipo]
FROM ComprobantesProveedores 
WHERE IsNull(IdObra,0)=@IdObra

UNION ALL

SELECT IdObra, 'Detalle de comprobantes proveedores' as [Tipo]
FROM DetalleComprobantesProveedores 
WHERE IsNull(IdObra,0)=@IdObra