CREATE Procedure [dbo].[CtasCtesA_TX_Imputacion]

@IdCtaCte int

AS 

SELECT *
FROM CuentasCorrientesAcreedores
WHERE (IdCtaCte=@IdCtaCte)