




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_A]
@IdAnticipoAlPersonalSyJ int  output,
@IdEmpleado int,
@Fecha datetime,
@Importe numeric(18,2),
@Detalle varchar(50),
@IdParametroLiquidacion int
AS 
Insert into [AnticiposAlPersonalSyJ]
(
 IdEmpleado,
 Fecha,
 Importe,
 Detalle,
 IdParametroLiquidacion
)
Values
(
 @IdEmpleado,
 @Fecha,
 @Importe,
 @Detalle,
 @IdParametroLiquidacion
)
Select @IdAnticipoAlPersonalSyJ=@@identity
Return(@IdAnticipoAlPersonalSyJ)




