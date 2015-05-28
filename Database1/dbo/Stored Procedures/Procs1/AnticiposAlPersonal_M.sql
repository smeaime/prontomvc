




CREATE  Procedure [dbo].[AnticiposAlPersonal_M]
@IdAnticipoAlPersonal int ,
@IdOrdenPago int,
@IdEmpleado int,
@Importe numeric(18,2),
@IdAsiento int,
@CantidadCuotas int,
@Detalle varchar(50),
@IdRecibo int
As
Update AnticiposAlPersonal
Set
 IdOrdenPago=@IdOrdenPago,
 IdEmpleado=@IdEmpleado,
 Importe=@Importe,
 IdAsiento=@IdAsiento,
 CantidadCuotas=@CantidadCuotas,
 Detalle=@Detalle,
 IdRecibo=@IdRecibo
Where (IdAnticipoAlPersonal=@IdAnticipoAlPersonal)
Return(@IdAnticipoAlPersonal)




