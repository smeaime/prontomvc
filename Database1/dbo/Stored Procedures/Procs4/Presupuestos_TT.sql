


CREATE  Procedure [dbo].[Presupuestos_TT]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 IdPresupuesto INTEGER,
			 IdRequerimiento INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT DISTINCT
  dp.IdPresupuesto,
  dr.IdRequerimiento
 FROM DetallePresupuestos dp
 LEFT OUTER JOIN Presupuestos pr ON dp.IdPresupuesto=pr.IdPresupuesto
 LEFT OUTER JOIN DetalleRequerimientos dr ON dp.IdDetalleRequerimiento=dr.IdDetalleRequerimiento

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111111111133'
Set @vector_T='06003423355555553339500'

SELECT 
	Presupuestos.IdPresupuesto,
	Presupuestos.Numero as [Numero Presupuesto],
	Presupuestos.SubNumero as [Orden],
	Case 	When IsNull((Select Count(*) From #Auxiliar1 
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0)=0
		 Then Null
		When IsNull((Select Count(*) From #Auxiliar1 
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0)=1
		 Then Convert(varchar,
			IsNull((Select Top 1 Requerimientos.NumeroRequerimiento
				From #Auxiliar1
				Left Outer Join Requerimientos On #Auxiliar1.IdRequerimiento=Requerimientos.IdRequerimiento
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0))
		 Else 'Varias'
	End as [RM],
	Proveedores.RazonSocial as [Razon social], 
	Presupuestos.FechaIngreso as [Fecha], 
	Presupuestos.Validez as [Validez],
	Presupuestos.Bonificacion as [Bonificacion],
	Presupuestos.Plazo as [Plazo],
	[Condiciones Compra].Descripcion as [Cond. de compra],
	Presupuestos.Garantia as [Garantia],
	Presupuestos.LugarEntrega as [LugarEntrega],
	Empleados.Nombre as [Comprador],
	Presupuestos.Referencia as [Referencia],
	Presupuestos.Detalle as [Detalle],
	Presupuestos.Contacto as [Contacto],
	Presupuestos.ImporteBonificacion as [Bonificacion],
	Presupuestos.ImporteIva1 as [Iva],
	Presupuestos.ImporteTotal as [Total],
	Presupuestos.IdPresupuesto as [IdAux],
	(Select Count(*) From DetallePresupuestos dp 
	 Where dp.IdPresupuesto=Presupuestos.IdPresupuesto) as [Cant.Items],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Presupuestos
LEFT OUTER JOIN Proveedores ON Presupuestos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN [Condiciones Compra] ON Presupuestos.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
LEFT OUTER JOIN Empleados ON Presupuestos.IdComprador = Empleados.IdEmpleado
ORDER BY Presupuestos.FechaIngreso Desc, 
	Presupuestos.Numero Desc, 
	Presupuestos.SubNumero Desc

DROP TABLE #Auxiliar1


