
CREATE Procedure [dbo].[wPresupuestos_E]
@IdPresupuesto int  AS 
Delete Presupuestos
where (IdPresupuesto=@IdPresupuesto)

