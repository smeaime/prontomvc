
CREATE Procedure [dbo].[TiposRetencionGanancia_TT]

AS

SELECT
 IdTipoRetencionGanancia,
 Descripcion,
 CodigoImpuestoAFIP as [Codigo Impuesto],
 CodigoRegimenAFIP as [Codigo Regimen],
 InformacionAuxiliar as [Informacion Auxiliar],
 ProximoNumeroCertificadoRetencionGanancias as [Prox.Cert.Ret.],
 BienesOServicios as [Bienes o Servicios]
FROM TiposRetencionGanancia
ORDER BY Descripcion
