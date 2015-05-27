CREATE Procedure [dbo].[CertificacionesObrasDatos_TX_PorNumeroProyecto]

@NumeroProyecto int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111133'
SET @vector_T='04240900'

SELECT 
 C.IdCertificacionObraDatos, 
 C.NumeroCertificado as [Nro.Certificado],
 C.Version as [Version],
 C.Fecha as [Fecha],
 C.Anulado as [Est.],
 Convert(varchar,C.NumeroCertificado)+IsNull(' '+C.Version,'') as [Titulo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CertificacionesObrasDatos C
WHERE C.NumeroProyecto=@NumeroProyecto
ORDER BY C.NumeroCertificado, C.Version