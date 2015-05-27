




CREATE PROCEDURE [dbo].[Obras_TX_PolizasPorIdObraConDatos]

@IdObra int

AS

SELECT
 DetPol.*,
 Proveedores.RazonSocial as [Aseguradora],
 TiposPoliza.Descripcion as [Tipo poliza]
FROM DetalleObrasPolizas DetPol
LEFT OUTER JOIN Proveedores ON DetPol.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposPoliza ON DetPol.IdTipoPoliza = TiposPoliza.IdTipoPoliza
WHERE (DetPol.IdObra = @IdObra)
ORDER by DetPol.NumeroPoliza




