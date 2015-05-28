





























CREATE Procedure [dbo].[CodigosUniversales_A]
@IdCodigoUniversal smallint  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [CodigosUniversales]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdCodigoUniversal=@@identity
Return(@IdCodigoUniversal)






























