





























CREATE Procedure [dbo].[DetAcoSchedulers_T]
@IdDetalleAcoScheduler int
AS 
SELECT *
FROM DetalleAcoSchedulers
where (IdDetalleAcoScheduler=@IdDetalleAcoScheduler)






























