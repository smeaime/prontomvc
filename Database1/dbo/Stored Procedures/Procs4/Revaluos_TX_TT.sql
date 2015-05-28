





CREATE Procedure [dbo].[Revaluos_TX_TT]
@IdRevaluo int
As 
Select 
 IdRevaluo,
 Descripcion as [Revaluo],
 FechaRevaluo as [Fecha rev.]
From Revaluos
Where (IdRevaluo=@IdRevaluo)






