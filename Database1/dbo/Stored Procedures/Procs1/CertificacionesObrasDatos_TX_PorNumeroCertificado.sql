CREATE Procedure [dbo].[CertificacionesObrasDatos_TX_PorNumeroCertificado]

@NumeroProyecto int,
@NumeroCertificado int,
@Version varchar(10) = Null,
@IdCertificacionObraDatos int = Null

AS 

SET @Version=IsNull(@Version,'')
SET @IdCertificacionObraDatos=IsNull(@IdCertificacionObraDatos,-1)

SELECT *
FROM CertificacionesObrasDatos 
WHERE NumeroProyecto=@NumeroProyecto and NumeroCertificado=@NumeroCertificado and IsNull(Version,'')=@Version and 
	(@IdCertificacionObraDatos<=0 or IdCertificacionObraDatos<>@IdCertificacionObraDatos)