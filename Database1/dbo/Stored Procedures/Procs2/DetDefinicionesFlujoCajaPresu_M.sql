


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaPresu_M]
@IdDetalleDefinicionFlujoCaja int,
@IdDefinicionFlujoCaja int,
@Mes int,
@Año int,
@Presupuesto numeric(18,2)
As
Update [DetalleDefinicionesFlujoCajaPresupuestos]
Set 
 IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja,
 Mes=@Mes,
 Año=@Año,
 Presupuesto=@Presupuesto
Where (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)
Return(@IdDetalleDefinicionFlujoCaja)


