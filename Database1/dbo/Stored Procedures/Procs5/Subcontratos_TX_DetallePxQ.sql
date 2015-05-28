CREATE Procedure [dbo].[Subcontratos_TX_DetallePxQ]

@IdSubcontrato int

AS 

SET NOCOUNT ON

DECLARE @NumeroSubcontrato int, @IdSubcontratoDatos int

SET @NumeroSubcontrato=IsNull((Select Top 1 NumeroSubcontrato From Subcontratos Where IdSubcontrato=@IdSubcontrato),0)
SET @IdSubcontratoDatos=IsNull((Select Top 1 IdSubcontratoDatos From SubcontratosDatos Where NumeroSubcontrato=@NumeroSubcontrato),0)

CREATE TABLE #Auxiliar 
			(
			 IdAux INTEGER IDENTITY (1, 1),
			 NumeroCertificado INTEGER
			)
INSERT INTO #Auxiliar 
 SELECT NumeroCertificado
 FROM DetalleSubcontratosDatos
 WHERE IdSubcontratoDatos=@IdSubcontratoDatos
 ORDER By NumeroCertificado

SET NOCOUNT OFF

SELECT PxQ.*, IsNull((Select Top 1 #Auxiliar.IdAux From #Auxiliar Where #Auxiliar.NumeroCertificado=PxQ.NumeroCertificado),0) as [Columna]
FROM SubcontratosPxQ PxQ
WHERE PxQ.IdSubcontrato=@IdSubcontrato
ORDER BY PxQ.Año, PxQ.Mes

DROP TABLE #Auxiliar