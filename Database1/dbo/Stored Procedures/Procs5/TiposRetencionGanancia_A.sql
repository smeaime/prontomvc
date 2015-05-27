
CREATE Procedure [dbo].[TiposRetencionGanancia_A]

@IdTipoRetencionGanancia int  output,
@Descripcion varchar(50),
@CodigoImpuestoAFIP int,
@CodigoRegimenAFIP int,
@InformacionAuxiliar varchar(50),
@ProximoNumeroCertificadoRetencionGanancias int,
@BienesOServicios varchar(1)

AS

INSERT INTO [TiposRetencionGanancia]
(
 Descripcion,
 CodigoImpuestoAFIP,
 CodigoRegimenAFIP,
 InformacionAuxiliar,
 ProximoNumeroCertificadoRetencionGanancias,
 BienesOServicios
)
VALUES
(
 @Descripcion,
 @CodigoImpuestoAFIP,
 @CodigoRegimenAFIP,
 @InformacionAuxiliar,
 @ProximoNumeroCertificadoRetencionGanancias,
 @BienesOServicios
)

SELECT @IdTipoRetencionGanancia=@@identity
RETURN(@IdTipoRetencionGanancia)
