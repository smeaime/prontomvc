






CREATE Procedure [dbo].[_TempCuentasCorrientesAcreedores_T]
@IdCtaCte int
AS 
SELECT *
FROM _TempCuentasCorrientesAcreedores
WHERE (IdCtaCte=@IdCtaCte)







