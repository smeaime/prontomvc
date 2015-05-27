
CREATE Procedure [dbo].[TiposRetencionGanancia_TX_TT]

@IdTipoRetencionGanancia int

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
WHERE (IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
