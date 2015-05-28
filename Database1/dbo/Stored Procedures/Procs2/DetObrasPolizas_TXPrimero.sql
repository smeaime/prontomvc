
CREATE PROCEDURE [dbo].[DetObrasPolizas_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111611111133'
SET @vector_T='031356344411100'

SELECT TOP 1 
 DetPol.IdDetalleObraPoliza,
 Proveedores.RazonSocial as [Aseguradora],
 TiposPoliza.Descripcion as [Tipo poliza],
 DetPol.NumeroPoliza as [Nro. poliza],
 DetPol.FechaVigencia as [Fecha vig.],
 DetPol.FechaVencimientoCuota as [Fecha vto.cuota],
 DetPol.Importe as [Importe],
 DetPol.FechaEstimadaRecupero as [Fec.Est.Rec.],
 DetPol.FechaRecupero as [Fecha Rec.],
 DetPol.FechaFinalizacionCobertura as [Fec.Fin.Cob.],
 DetPol.CondicionRecupero as [Condicion recupero],
 DetPol.MotivoDeContratacionSeguro as [Motivo de contratacion],
 DetPol.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasPolizas DetPol
LEFT OUTER JOIN Proveedores ON DetPol.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposPoliza ON DetPol.IdTipoPoliza = TiposPoliza.IdTipoPoliza
