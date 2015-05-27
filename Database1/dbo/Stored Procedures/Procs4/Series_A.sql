





























CREATE Procedure [dbo].[Series_A]
@IdSerie smallint  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Series]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdSerie=@@identity
Return(@IdSerie)






























