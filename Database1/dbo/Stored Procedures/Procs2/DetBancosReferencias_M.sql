
CREATE Procedure [dbo].[DetBancosReferencias_M]

@IdDetalleBancoReferencias int,
@IdBanco int,
@IdTipoComprobante int,
@Referencia varchar(50),
@CodigoOperacion varchar(50)

AS

UPDATE [DetalleBancosReferencias]
SET 
 IdBanco=@IdBanco,
 IdTipoComprobante=@IdTipoComprobante,
 Referencia=@Referencia,
 CodigoOperacion=@CodigoOperacion
WHERE (IdDetalleBancoReferencias=@IdDetalleBancoReferencias)

RETURN(@IdDetalleBancoReferencias)
