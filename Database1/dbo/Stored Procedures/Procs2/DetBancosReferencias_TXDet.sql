
CREATE PROCEDURE [dbo].[DetBancosReferencias_TXDet]

@IdBanco int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='012100'

SELECT
 Det.IdDetalleBancoReferencias,
 TiposComprobante.Descripcion as [Tipo comprobante],
 Det.Referencia as [Referencia],
 Det.CodigoOperacion as [Codigo de operacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleBancosReferencias Det
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Det.IdTipoComprobante
WHERE (Det.IdBanco = @IdBanco)
