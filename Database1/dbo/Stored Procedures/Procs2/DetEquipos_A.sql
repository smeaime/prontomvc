





























CREATE Procedure [dbo].[DetEquipos_A]
@IdDetalleEquipo int  output,
@IdEquipo int,
@IdPlano int,
@EnviarEmail tinyint
AS 
Insert into [DetalleEquipos]
(
 IdEquipo,
 IdPlano,
 EnviarEmail
)
Values
(
 @IdEquipo,
 @IdPlano,
 @EnviarEmail
)
Select @IdDetalleEquipo=@@identity
Return(@IdDetalleEquipo)






























