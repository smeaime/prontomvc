





























CREATE Procedure [dbo].[TTermicos_A]
@IdTratamiento int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [TratamientosTermicos]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdTratamiento=@@identity
Return(@IdTratamiento)






























