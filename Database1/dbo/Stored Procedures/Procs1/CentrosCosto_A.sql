





























CREATE Procedure [dbo].[CentrosCosto_A]
@IdCentroCosto int  output,
@Codigo varchar(10),
@Descripcion varchar(50)
AS 
Insert into [CentrosCosto]
(
Codigo,
Descripcion
)
Values(
@Codigo,
@Descripcion
)
Select @IdCentroCosto=@@identity
Return(@IdCentroCosto)






























