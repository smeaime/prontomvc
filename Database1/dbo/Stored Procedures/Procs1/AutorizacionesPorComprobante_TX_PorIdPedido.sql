
CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_PorIdPedido]

@IdPedido int,
@OrdenAutorizacion int

AS

DECLARE @SectorEmisorEnPedidos varchar(3)
SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From Parametros2 P2 
					Where P2.Campo='SectorEmisorEnPedidos'),'RM')

SELECT DISTINCT 
	Case 	When Ped.SubNumero is not null 
		Then str(Ped.NumeroPedido,8)+' / '+str(Ped.SubNumero,2)
		Else str(Ped.NumeroPedido,8)
	End as [Numero],
	CASE
		WHEN DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) THEN
			CASE 	
				WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN Obras.IdJefeRegional
				WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN Obras.IdJefe
				WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN Obras.IdSubJefe
				ELSE Obras.IdJefe
			END
		WHEN DetAut.SectorEmisor1='N' THEN
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='LIB' THEN
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where ( Select Top 1 Emp1.IdSector 
				From Empleados Emp1
				Where Emp1.IdEmpleado=Ped.Aprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo  or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='RM' THEN
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where (Select Top 1 R.IdSector
				From Requerimientos R 
				Where R.IdRequerimiento=
					(Select Top 1 DR.IdRequerimiento 
					 From DetalleRequerimientos DR 
					 Where DR.IdDetalleRequerimiento=
						(Select Top 1 DP.IdDetalleRequerimiento
						 From DetallePedidos DP 
						 Where DP.IdPedido=Ped.IdPedido and 
							DP.IdDetalleRequerimiento is not null)))=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo  or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) THEN
		     DetAut.IdFirmante1
		ELSE Null 
	END as [Autoriza],
	CASE
		WHEN DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) THEN
			CASE 	
				WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefeRegional)
				WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
				WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdSubJefe)
				ELSE (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
			END
		WHEN DetAut.SectorEmisor1='N' THEN
		     (  Select Top 1 Emp.IdSector
			From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='LIB' THEN
		     (  Select Top 1 Emp.IdSector
			From Empleados Emp
			Where Emp.IdEmpleado=Ped.Aprobo )
		WHEN DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='RM' THEN
		     (Select Top 1 R.IdSector
			From Requerimientos R 
			Where R.IdRequerimiento=
				(Select Top 1 DR.IdRequerimiento 
				 From DetalleRequerimientos DR 
				 Where DR.IdDetalleRequerimiento=
					(Select Top 1 DP.IdDetalleRequerimiento
					 From DetallePedidos DP 
					 Where DP.IdPedido=Ped.IdPedido and 
						DP.IdDetalleRequerimiento is not null)))
		WHEN DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) THEN
		     (  Select Top 1 Emp.IdSector
			From Empleados Emp
			Where Emp.IdEmpleado=DetAut.IdFirmante1 )
		ELSE Null 
	END as [Sector]
FROM Pedidos Ped
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=4
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
LEFT OUTER JOIN Obras ON Obras.IdObra=(Select Top 1 R.IdObra
					From Requerimientos R 
					Where R.IdRequerimiento=
						(Select Top 1 DR.IdRequerimiento 
						 From DetalleRequerimientos DR 
						 Where DR.IdDetalleRequerimiento=
							(Select Top 1 DP.IdDetalleRequerimiento
							 From DetallePedidos DP 
							 Where DP.IdPedido=Ped.IdPedido and 
								DP.IdDetalleRequerimiento is not null)))
WHERE Ped.Aprobo is not null and @IdPedido=Ped.IdPedido and 
	 NOT EXISTS(Select * from AutorizacionesPorComprobante Aut 
			Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and 
				Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
	(@OrdenAutorizacion=-1 or @OrdenAutorizacion=DetAut.OrdenAutorizacion)
