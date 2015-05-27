
CREATE Procedure [dbo].[DetBancosReferencias_T]

@IdDetalleBancoReferencias int

AS 

SELECT *
FROM [DetalleBancosReferencias]
WHERE (IdDetalleBancoReferencias=@IdDetalleBancoReferencias)
