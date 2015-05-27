CREATE Procedure [dbo].[TiposComprobante_TT]

AS 

SELECT
 IdTipoComprobante,
 Descripcion as [Comprobante],
 Coeficiente as [Coef],
 DescripcionAb as [Abreviatura],
 VaAlLibro as [Va al libro],
 VaAlCiti as [Va al Citi],
  VaAlRegistroComprasAFIP as [Va a 1361],
 ExigirCAI as [Exigir CAI],
 CodigoDgi as [Codigo DGI],
 NumeradorAuxiliar as [Numerador],
 CodigoAFIP_Letra_A as [Cod.AFIP A],
 CodigoAFIP_Letra_B as [Cod.AFIP B],
 CodigoAFIP_Letra_C as [Cod.AFIP C],
 CodigoAFIP_Letra_E as [Cod.AFIP E],
 CodigoAFIP2_Letra_A as [Cod.AFIP 2 A],
 CodigoAFIP2_Letra_B as [Cod.AFIP 2 B],
 CodigoAFIP2_Letra_C as [Cod.AFIP 2 C],
 CodigoAFIP2_Letra_E as [Cod.AFIP 2 E],
 CodigoAFIP3_Letra_A as [Cod.AFIP 3 A],
 CodigoAFIP3_Letra_B as [Cod.AFIP 3 B],
 CodigoAFIP3_Letra_C as [Cod.AFIP 3 C],
 CodigoAFIP3_Letra_E as [Cod.AFIP 3 E]
FROM TiposComprobante 
ORDER BY Descripcion