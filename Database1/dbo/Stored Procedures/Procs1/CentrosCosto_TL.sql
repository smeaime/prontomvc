﻿





























CREATE Procedure [dbo].[CentrosCosto_TL]
AS 
Select IdCentroCosto,Codigo + ' ' + Descripcion as Titulo
FROM CentrosCosto
order by Descripcion






























