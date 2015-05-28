




CREATE Procedure [dbo].[AnticiposAlPersonal_A]
@IdAnticipoAlPersonal int  output,
@IdOrdenPago int,
@IdEmpleado int,
@Importe numeric(18,2),
@IdAsiento int,
@CantidadCuotas int,
@Detalle varchar(50),
@IdRecibo int
AS 
Insert into [AnticiposAlPersonal]
(
 IdOrdenPago,
 IdEmpleado,
 Importe,
 IdAsiento,
 CantidadCuotas,
 Detalle,
 IdRecibo
)
Values
(
 @IdOrdenPago,
 @IdEmpleado,
 @Importe,
 @IdAsiento,
 @CantidadCuotas,
 @Detalle,
 @IdRecibo
)
Select @IdAnticipoAlPersonal=@@identity
Return(@IdAnticipoAlPersonal)




