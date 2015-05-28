































CREATE Procedure [dbo].[AlimentacionesElectricas_TX_TT]
@IdAlimentacionElectrica int
AS 
Select IdAlimentacionElectrica,Descripcion
FROM AlimentacionesElectricas
where (IdAlimentacionElectrica=@IdAlimentacionElectrica)
order by Descripcion
































