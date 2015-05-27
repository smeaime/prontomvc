
CREATE Procedure [dbo].[DetBancosReferencias_A]

@IdDetalleBancoReferencias int  output,
@IdBanco int,
@IdTipoComprobante int,
@Referencia varchar(50),
@CodigoOperacion varchar(50)

AS

INSERT INTO [DetalleBancosReferencias]
(
 IdBanco,
 IdTipoComprobante,
 Referencia,
 CodigoOperacion
)
VALUES
(
 @IdBanco,
 @IdTipoComprobante,
 @Referencia,
 @CodigoOperacion
)

SELECT @IdDetalleBancoReferencias=@@identity
RETURN(@IdDetalleBancoReferencias)
