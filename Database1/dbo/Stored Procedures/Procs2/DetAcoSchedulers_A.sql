





























CREATE Procedure [dbo].[DetAcoSchedulers_A]
@IdDetalleAcoScheduler int  output,
@IdAcoScheduler int,
@IdScheduler int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoSchedulers]
(
IdAcoScheduler,
IdScheduler
)
Values
(
@IdAcoScheduler,
@IdScheduler
)
Select @IdDetalleAcoScheduler=@@identity
Return(@IdDetalleAcoScheduler)






























