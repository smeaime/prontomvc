




CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_PorIdRM]
@IdRequerimiento int
AS
SELECT distinct
	Req.NumeroRequerimiento,
	CASE
		WHEN DetAut.SectorEmisor1='O' THEN 
			CASE 
				WHEN NOT Obras.TipoObra is null 
					THEN Obras.IdJefe
				ELSE 	
					CASE 
						WHEN DetAut.SectorEmisor2='N' THEN
						     (  Select Top 1 Emp.IdEmpleado
							From Empleados Emp
							Where (DetAut.IdSectorAutoriza2=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo ) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4) )
						WHEN DetAut.SectorEmisor2='S' THEN
						     (  Select Top 1 Emp.IdEmpleado
							From Empleados Emp
							Where (Req.IdSector=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo ) or 
							      (Req.IdSector=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (Req.IdSector=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (Req.IdSector=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (Req.IdSector=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4) )
						ELSE Null 
					END
			END
		WHEN DetAut.SectorEmisor1='N' THEN
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='S' THEN
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where (Req.IdSector=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (Req.IdSector=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (Req.IdSector=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (Req.IdSector=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (Req.IdSector=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		ELSE Null 
	END as [Autoriza],
	CASE
		WHEN DetAut.SectorEmisor1='O' THEN 
			CASE 
				WHEN NOT Obras.TipoObra is null AND Obras.TipoObra<>1
					THEN  ( Select Top 1 Emp.IdSector
						From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe )
				ELSE 	
					CASE 
						WHEN DetAut.SectorEmisor2='N' THEN
						     (  Select Top 1 Emp.IdSector
							From Empleados Emp
							Where (DetAut.IdSectorAutoriza2=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo ) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4) )
						WHEN DetAut.SectorEmisor2='S' THEN Req.IdSector
						ELSE Null 
					END
			END
		WHEN DetAut.SectorEmisor1='N' THEN
		     (  Select Top 1 Emp.IdSector
			From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4) )
		WHEN DetAut.SectorEmisor1='S' THEN Req.IdSector
		ELSE Null 
	END as [Sector]
FROM Requerimientos Req
LEFT OUTER JOIN Obras ON Req.IdObra=Obras.IdObra
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=3
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE Req.Aprobo is not null and @IdRequerimiento=Req.IdRequerimiento and 
	 NOT EXISTS(Select * from AutorizacionesPorComprobante Aut 
			Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion)
ORDER By Req.NumeroRequerimiento




