﻿
































CREATE Procedure [dbo].[CtasCtesD_T]
@IdCtaCte int
AS 
SELECT *
FROM CuentasCorrientesDeudores
where (IdCtaCte=@IdCtaCte)

































