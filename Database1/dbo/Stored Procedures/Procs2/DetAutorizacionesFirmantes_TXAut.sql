CREATE PROCEDURE [dbo].[DetAutorizacionesFirmantes_TXAut]

@IdDetalleAutorizacion int

AS

SET NOCOUNT ON

DECLARE @FirmantesPorRubroPE varchar(2), @vector_X varchar(30), @vector_T varchar(30)

SET @FirmantesPorRubroPE=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Modelo de firmas de documentos por firmante entre importes por rubro' and IsNull(ProntoIni.Valor,'')='SI'),'')

SET @vector_X='011111133'
IF @FirmantesPorRubroPE='SI'
	SET @vector_T='023994400'
ELSE
	SET @vector_T='011129900'

SET NOCOUNT OFF

SELECT
 Det.IdDetalleAutorizacionFirmantes,
 Empleados.Nombre as [Frimante],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Det.ParaTaller as [Para taller],
 Det.ImporteDesde as [Imp.Desde],
 Det.ImporteHasta as [Imp.Hasta],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAutorizacionesFirmantes Det
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=Det.IdFirmante
LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Det.IdRubro
LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro=Det.IdSubrubro
WHERE (Det.IdDetalleAutorizacion = @IdDetalleAutorizacion)
ORDER BY [Frimante], [Rubro], [Subrubro]