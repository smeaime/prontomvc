




CREATE  Procedure [dbo].[AnticiposAlPersonalSyJ_M]
@IdAnticipoAlPersonalSyJ int ,
@IdEmpleado int,
@Fecha datetime,
@Importe numeric(18,2),
@Detalle varchar(50),
@IdParametroLiquidacion int
As
Update AnticiposAlPersonalSyJ
Set
 IdEmpleado=@IdEmpleado,
 Fecha=@Fecha,
 Importe=@Importe,
 Detalle=@Detalle,
 IdParametroLiquidacion=@IdParametroLiquidacion
Where (IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ)
Return(@IdAnticipoAlPersonalSyJ)




