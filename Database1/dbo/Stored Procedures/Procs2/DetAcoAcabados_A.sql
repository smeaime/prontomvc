





























CREATE Procedure [dbo].[DetAcoAcabados_A]
@IdDetalleAcoAcabado int  output,
@IdAcoAcabado int,
@IdAcabado int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoAcabados]
(
IdAcoAcabado,
IdAcabado
)
Values
(
@IdAcoAcabado,
@IdAcabado
)
Select @IdDetalleAcoAcabado=@@identity
Return(@IdDetalleAcoAcabado)






























