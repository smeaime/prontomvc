﻿





























CREATE Procedure [dbo].[Planos_TL]
AS 
Select IdPlano,NumeroPlano + " - " +Descripcion as Titulo
FROM Planos
order by NumeroPlano






























