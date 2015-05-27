CREATE Procedure [dbo].[Polizas_E]

@IdPoliza int 

AS 

DELETE DetallePolizas
WHERE (IdPoliza=@IdPoliza)

DELETE Polizas
WHERE (IdPoliza=@IdPoliza)