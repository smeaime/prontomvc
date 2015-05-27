
CREATE  Procedure [dbo].[TiposComprobante_ModificarNumerador]
@IdTipoComprobante int ,
@NumeradorAuxiliar int
AS 
UPDATE TiposComprobante
SET NumeradorAuxiliar=@NumeradorAuxiliar
WHERE (IdTipoComprobante=@IdTipoComprobante)
RETURN(@IdTipoComprobante)
