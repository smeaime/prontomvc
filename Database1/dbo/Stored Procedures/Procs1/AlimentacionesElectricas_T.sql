﻿































CREATE Procedure [dbo].[AlimentacionesElectricas_T]
@IdAlimentacionElectrica int
AS 
SELECT IdAlimentacionElectrica, Descripcion
FROM AlimentacionesElectricas
where (IdAlimentacionElectrica=@IdAlimentacionElectrica)
































