





























CREATE Procedure [dbo].[Formas_A]
@IdForma smallint  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Formas]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdForma=@@identity
Return(@IdForma)






























