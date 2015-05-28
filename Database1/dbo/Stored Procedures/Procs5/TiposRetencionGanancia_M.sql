
CREATE  Procedure [dbo].[TiposRetencionGanancia_M]

@IdTipoRetencionGanancia int ,
@Descripcion varchar(50),
@CodigoImpuestoAFIP int,
@CodigoRegimenAFIP int,
@InformacionAuxiliar varchar(50),
@ProximoNumeroCertificadoRetencionGanancias int,
@BienesOServicios varchar(1)

AS

UPDATE TiposRetencionGanancia
SET 
 Descripcion=@Descripcion,
 CodigoImpuestoAFIP=@CodigoImpuestoAFIP,
 CodigoRegimenAFIP=@CodigoRegimenAFIP,
 InformacionAuxiliar=@InformacionAuxiliar,
 ProximoNumeroCertificadoRetencionGanancias=@ProximoNumeroCertificadoRetencionGanancias,
 BienesOServicios=@BienesOServicios
WHERE (IdTipoRetencionGanancia=@IdTipoRetencionGanancia)

RETURN(@IdTipoRetencionGanancia)
