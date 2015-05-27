





























CREATE Procedure [dbo].[DetEquipos_M]
@IdDetalleEquipo int,
@IdEquipo int,
@IdPlano int,
@EnviarEmail tinyint
as
Update [DetalleEquipos]
SET 
IdEquipo=@IdEquipo,
IdPlano=@IdPlano,
EnviarEmail=@EnviarEmail
where (IdDetalleEquipo=@IdDetalleEquipo)
Return(@IdDetalleEquipo)






























