﻿


































CREATE Procedure [dbo].[CtasCtesA_T]
@IdCtaCte int
AS 
SELECT *
FROM CuentasCorrientesAcreedores
where (IdCtaCte=@IdCtaCte)



































