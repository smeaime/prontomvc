﻿





























CREATE Procedure [dbo].[MotivosRechazo_TL]
AS 
Select IdMotivoRechazo,Descripcion as Titulo
FROM MotivosRechazo
order by Descripcion






























