
CREATE PROCEDURE [dbo].[DetSubcontratosDatos_TX_ParaComboPorNumeroSubcontrato]

@NumeroSubcontrato int

AS

SELECT
 Det.IdDetalleSubcontratoDatos,
 Convert(varchar,Det.NumeroCertificado)+' del '+Convert(varchar,Det.FechaCertificado,103) as [Titulo]
FROM DetalleSubcontratosDatos Det
LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.IdSubcontratoDatos=Det.IdSubcontratoDatos
WHERE SubcontratosDatos.NumeroSubcontrato = @NumeroSubcontrato
ORDER BY Det.NumeroCertificado
