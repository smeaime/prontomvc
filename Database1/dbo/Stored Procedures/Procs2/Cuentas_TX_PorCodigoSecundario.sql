CREATE Procedure [dbo].[Cuentas_TX_PorCodigoSecundario]

@Codigo varchar(30)

AS 

SELECT *
FROM Cuentas
WHERE (CodigoSecundario=@Codigo)