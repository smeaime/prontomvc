
CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_DocumentosPorAutorizaSuplentes]

@IdAutoriza int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdAutorizacionPorComprobante INTEGER,
			 IdFormulario INTEGER,
			 OrdenAutorizacion INTEGER,
			 IdComprobante INTEGER,
			 Fecha DATETIME,
			 Numero VARCHAR(15),
			 IdTitular INTEGER,
			 IdFirmo INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  AutCom.IdAutorizacionPorComprobante,
  AutCom.IdFormulario,
  AutCom.OrdenAutorizacion,
  AutCom.IdComprobante,
  Case 	When AutCom.IdFormulario=1 Then Aco.Fecha
	When AutCom.IdFormulario=2 Then LMat.Fecha
	When AutCom.IdFormulario=3 Then Req.FechaRequerimiento
	When AutCom.IdFormulario=4 Then Ped.FechaPedido
	When AutCom.IdFormulario=5 Then Comp.Fecha
	When AutCom.IdFormulario=6 Then Aju.FechaAjuste
	Else Null
  End,
  Case 	When AutCom.IdFormulario=1 Then str(Aco.NumeroAcopio,8)
	When AutCom.IdFormulario=2 Then str(LMat.NumeroLMateriales,8)
	When AutCom.IdFormulario=3 Then str(Req.NumeroRequerimiento,8)
	When AutCom.IdFormulario=4 Then str(Ped.NumeroPedido,8)+' / '+str(Ped.SubNumero,2)
	When AutCom.IdFormulario=5 Then str(Comp.Numero,8)
	When AutCom.IdFormulario=6 Then str(Aju.NumeroAjusteStock,8)
	Else Null
  End,
  Case 	When DetAut.SectorEmisor1='O' 
	 Then 	Case When AutCom.IdFormulario=4 
			Then 	(Select Top 1 O.IdJefe
				 From Obras O 
				 Where O.IdObra=
					(Select Top 1 R.IdObra
					 From Requerimientos R 
					 Where R.IdRequerimiento=
						(Select Top 1 DR.IdRequerimiento 
						 From DetalleRequerimientos DR 
						 Where DR.IdDetalleRequerimiento=
							(Select Top 1 DP.IdDetalleRequerimiento
							 From DetallePedidos DP 
							 Where DP.IdPedido=AutCom.IdComprobante and 
								DP.IdDetalleRequerimiento is not null))))
			Else Obras.IdJefe
		End
	When DetAut.SectorEmisor1='N' 
	 Then (Select Top 1 Emp.IdEmpleado
		From Empleados Emp
		Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
		      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
		      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
		      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
		      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
	When DetAut.SectorEmisor1='S' 
	 Then 	Case 	When AutCom.IdFormulario=3
			 Then (Select Top 1 Emp.IdEmpleado
				From Empleados Emp
				Where 	(Req.IdSector=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
					(Req.IdSector=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
				 	(Req.IdSector=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
					(Req.IdSector=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
					(Req.IdSector=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
			 Else (Select Top 1 Emp.IdEmpleado
				From Empleados Emp
				Where (Select Top 1 Emp1.IdSector 
					From Empleados Emp1
					Where Emp1.IdEmpleado=Case When AutCom.IdFormulario=1 Then Aco.Aprobo
								   When AutCom.IdFormulario=2 Then LMat.Aprobo
								   When AutCom.IdFormulario=4 Then Ped.Aprobo
								   When AutCom.IdFormulario=5 Then Comp.IdAprobo
								   When AutCom.IdFormulario=6 Then Aju.IdAprobo
								   Else Null
							      End)=Emp.IdSector and 
					(DetAut.IdCargoAutoriza1=Emp.IdCargo  or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
					 DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
					 DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		End
	When DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1)
	 Then DetAut.IdFirmante1
	Else Null
  End,
  AutCom.IdAutorizo
 FROM AutorizacionesPorComprobante AutCom 
 LEFT OUTER JOIN Autorizaciones ON AutCom.IdFormulario=Autorizaciones.IdFormulario
 LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion and 
						 AutCom.OrdenAutorizacion=DetAut.OrdenAutorizacion
 LEFT OUTER JOIN Acopios Aco ON AutCom.IdComprobante=Aco.IdAcopio and AutCom.IdFormulario=1
 LEFT OUTER JOIN LMateriales LMat ON AutCom.IdComprobante=LMat.IdLMateriales and AutCom.IdFormulario=2
 LEFT OUTER JOIN Requerimientos Req ON AutCom.IdComprobante=Req.IdRequerimiento and AutCom.IdFormulario=3
 LEFT OUTER JOIN Pedidos Ped ON AutCom.IdComprobante=Ped.IdPedido and AutCom.IdFormulario=4
 LEFT OUTER JOIN Comparativas Comp ON AutCom.IdComprobante=Comp.IdComparativa and AutCom.IdFormulario=5
 LEFT OUTER JOIN AjustesStock Aju ON AutCom.IdComprobante=Aju.IdAjusteStock and AutCom.IdFormulario=6
 LEFT OUTER JOIN Obras ON (Aco.IdObra=Obras.IdObra and AutCom.IdFormulario=1) or 
			  (Req.IdObra=Obras.IdObra and AutCom.IdFormulario=3)
 WHERE IsNull(AutCom.Visto,'NO')='NO'

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111111133'
Set @vector_T='03999043222222222200'

SELECT 
 #Auxiliar1.IdAutorizacionPorComprobante,
 Case 	When #Auxiliar1.IdFormulario=1 Then 'Acopio'
	When #Auxiliar1.IdFormulario=2 Then 'L.Materiales'
	When #Auxiliar1.IdFormulario=3 Then 'R.M.'
	When #Auxiliar1.IdFormulario=4 Then 'Pedido'
	When #Auxiliar1.IdFormulario=5 Then 'Comparativa'
	When #Auxiliar1.IdFormulario=6 Then 'Ajuste Stock'
	Else Null
 End as [Tipo doc.],
 #Auxiliar1.IdAutorizacionPorComprobante as [IdAux1],
 #Auxiliar1.IdFormulario as [IdAux2],
 #Auxiliar1.IdComprobante as [IdAux3],
 #Auxiliar1.OrdenAutorizacion as [Orden],
 #Auxiliar1.Fecha as [Fecha],
 #Auxiliar1.Numero as [Numero],
 Case	When #Auxiliar1.IdFormulario=4 Then (Select Top 1 Proveedores.RazonSocial 
						From Proveedores
						Where (	Select Pedidos.IdProveedor
							From Pedidos
							Where #Auxiliar1.IdComprobante=Pedidos.IdPedido )=Proveedores.IdProveedor )
	Else Null
 End as [Proveedor],
 Case	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoParaCompra
						From Requerimientos
						Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )
	When #Auxiliar1.IdFormulario=4 Then (Select Top 1 Pedidos.TotalPedido
						From Pedidos
						Where #Auxiliar1.IdComprobante=Pedidos.IdPedido )
	Else Null
 End as [Monto p/compra],
 Case	When #Auxiliar1.IdFormulario=1 Then (Select Top 1 Acopios.MontoPrevisto 
						From Acopios
						Where #Auxiliar1.IdComprobante=Acopios.IdAcopio )
	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoPrevisto 
						From Requerimientos
						Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )
	Else Null
 End as [Monto previsto],
 Case	When #Auxiliar1.IdFormulario=4 Then (Select Top 1 Monedas.Abreviatura 
						From Monedas
						Where (	Select Pedidos.IdMoneda
							From Pedidos
							Where #Auxiliar1.IdComprobante=Pedidos.IdPedido )=Monedas.IdMoneda )
	Else Null
 End as [Mon.],
 Case	When #Auxiliar1.IdFormulario=1 Then (Select Top 1 Obras.NumeroObra 
						From Obras
						Where (	Select Acopios.IdObra
							From Acopios
							Where #Auxiliar1.IdComprobante=Acopios.IdAcopio )=Obras.IdObra )
	When #Auxiliar1.IdFormulario=2 Then (Select Top 1 Obras.NumeroObra 
						From Obras
						Where (	Select LMateriales.IdObra
							From LMateriales
							Where #Auxiliar1.IdComprobante=LMateriales.IdLMateriales )=Obras.IdObra )
	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 Obras.NumeroObra 
						From Obras
						Where (	Select Requerimientos.IdObra
							From Requerimientos
							Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )=Obras.IdObra )
	Else Null
 End as [Obra],
 Case	When #Auxiliar1.IdFormulario=3 Then ( Select Top 1 Sectores.Descripcion 
						   From Sectores 
						   Where Sectores.IdSector=
							( Select Top 1 Requerimientos.IdSector 
							  From Requerimientos
							  Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento ) )
	Else Null
 End as [Sector],
 Case	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 CentrosCosto.Descripcion
						From CentrosCosto
						Where (	Select Requerimientos.IdCentroCosto
							From Requerimientos
							Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )=CentrosCosto.IdCentroCosto )
	Else Null
 End as [Centro de costo],
 Case	When #Auxiliar1.IdFormulario=1 Then (Select Top 1 Clientes.RazonSocial 
						From Clientes
						Where (	Select Acopios.IdCliente
							From Acopios
							Where #Auxiliar1.IdComprobante=Acopios.IdAcopio )=Clientes.IdCliente )
	When #Auxiliar1.IdFormulario=2 Then (Select Top 1 Clientes.RazonSocial 
						From Clientes
						Where (	Select LMateriales.IdCliente
							From LMateriales
							Where #Auxiliar1.IdComprobante=LMateriales.IdLMateriales )=Clientes.IdCliente )
	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 Clientes.RazonSocial 
						From Clientes
						Where (	Select TOP 1 Obras.IdCliente
							From Obras
							Where ( Select Top 1 Requerimientos.IdObra 
								From Requerimientos
								Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )=Obras.IdObra ) = Clientes.IdCliente )
	Else Null
 End as [Cliente],
 Case	When #Auxiliar1.IdFormulario=3 Then (Select Top 1 Requerimientos.IdSector 
						From Requerimientos
						Where #Auxiliar1.IdComprobante=Requerimientos.IdRequerimiento )
	Else 0
 End as [SectorEmisor],
 (Select Top 1 Empleados.Nombre
  From Empleados Where Empleados.IdEmpleado=#Auxiliar1.IdFirmo) as [Firmo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
WHERE IsNull(IdTitular,0)<>IsNull(IdFirmo,0) and IsNull(IdTitular,0)=@IdAutoriza
ORDER BY #Auxiliar1.Fecha, [Tipo doc.], #Auxiliar1.Numero

DROP TABLE #Auxiliar1
