CREATE Procedure [dbo].[Polizas_T]

@IdPoliza int

AS 

SELECT *
FROM Polizas
WHERE (IdPoliza=@IdPoliza)