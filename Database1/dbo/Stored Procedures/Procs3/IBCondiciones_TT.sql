CREATE Procedure [dbo].[IBCondiciones_TT]

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111133'
SET @vector_T='03364656757777500'

SELECT
 IBCondiciones.IdIBCondicion,
 IBCondiciones.Descripcion as [Jurisdiccion],
 Provincias.Nombre as [Provincia],
 IBCondiciones.ImporteTopeMinimo as [Imp. tope min.(Ret.)],
 IBCondiciones.Alicuota as [% Alicuota (Ret.)],
 IBCondiciones.ImporteTopeMinimoPercepcion as [Imp. tope min.(Perc.)],
 IBCondiciones.AlicuotaPercepcion as [% Alicuota (Perc.)],
 IBCondiciones.AlicuotaPercepcionConvenio as [% Alic.Conv.(Perc.)],
 IBCondiciones.FechaVigencia as [Fecha de vigencia],
 IBCondiciones.AcumulaMensualmente as [Acum. mensual],
 IBCondiciones.BaseCalculo as [Aplicar sobre],
 IBCondiciones.PorcentajeATomarSobreBase as [% a tomar de la base],
 IBCondiciones.PorcentajeAdicional as [% adicional s/impuesto],
 IBCondiciones.LeyendaPorcentajeAdicional as [Leyenda del % adicional],
 IBCondiciones.CodigoArticuloInciso as [Codigo Articulo/Inciso],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM IBCondiciones
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
ORDER BY IBCondiciones.Descripcion