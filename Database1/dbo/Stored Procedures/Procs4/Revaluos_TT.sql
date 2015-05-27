





CREATE Procedure [dbo].[Revaluos_TT]
As 
Select 
 IdRevaluo,
 Descripcion as [Revaluo],
 FechaRevaluo as [Fecha rev.]
From Revaluos
order by Descripcion






