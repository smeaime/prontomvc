


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaPresu_A]
@IdDetalleDefinicionFlujoCaja int  output,
@IdDefinicionFlujoCaja int,
@Mes int,
@Año int,
@Presupuesto numeric(18,2)
As 
Insert into [DetalleDefinicionesFlujoCajaPresupuestos]
(
 IdDefinicionFlujoCaja,
 Mes,
 Año,
 Presupuesto
)
Values
(
 @IdDefinicionFlujoCaja,
 @Mes,
 @Año,
 @Presupuesto
)
Select @IdDetalleDefinicionFlujoCaja=@@identity
Return(@IdDetalleDefinicionFlujoCaja)


