
CREATE Procedure [dbo].[DetBancosReferencias_TX_PorBancoCodigoOperacion]

@IdBanco int,
@CodigoOperacion varchar(50)

AS 

SELECT *
FROM [DetalleBancosReferencias]
WHERE IdBanco=@IdBanco and CodigoOperacion=@CodigoOperacion
