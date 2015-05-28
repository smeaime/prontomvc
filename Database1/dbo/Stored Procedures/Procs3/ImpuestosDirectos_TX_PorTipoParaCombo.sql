CREATE Procedure [dbo].[ImpuestosDirectos_TX_PorTipoParaCombo]

@Tipo varchar(50),
@ParaInscriptosEnRegistroFiscalOperadoresGranos varchar(2) = Null

AS

SET @ParaInscriptosEnRegistroFiscalOperadoresGranos=IsNull(@ParaInscriptosEnRegistroFiscalOperadoresGranos,'')

SELECT 
 ImpuestosDirectos.IdImpuestoDirecto,
 ImpuestosDirectos.Descripcion as [Titulo]
FROM ImpuestosDirectos
LEFT OUTER JOIN TiposImpuesto ON ImpuestosDirectos.IdTipoImpuesto=TiposImpuesto.IdTipoImpuesto
WHERE TiposImpuesto.Descripcion=@Tipo and 
	(@ParaInscriptosEnRegistroFiscalOperadoresGranos='' or IsNull(ParaInscriptosEnRegistroFiscalOperadoresGranos,'NO')=@ParaInscriptosEnRegistroFiscalOperadoresGranos)
ORDER BY ImpuestosDirectos.Descripcion