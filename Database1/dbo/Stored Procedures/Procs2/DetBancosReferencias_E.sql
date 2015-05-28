
CREATE Procedure [dbo].[DetBancosReferencias_E]

@IdDetalleBancoReferencias int  

AS

DELETE [DetalleBancosReferencias]
WHERE (IdDetalleBancoReferencias=@IdDetalleBancoReferencias)
