CREATE Procedure [dbo].[CertificacionesObrasDatos_TX_UltimoCertificado]

@NumeroProyecto int

AS 

SELECT Max(IsNull(NumeroCertificado,0)) as [UltimoCertificado]
FROM CertificacionesObrasDatos 
WHERE @NumeroProyecto=-1 or NumeroProyecto=@NumeroProyecto