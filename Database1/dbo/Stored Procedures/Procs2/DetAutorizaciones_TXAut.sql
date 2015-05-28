
CREATE PROCEDURE [dbo].[DetAutorizaciones_TXAut]

@IdAutorizacion int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111133'
SET @vector_T='002HGGGGG00'

SELECT
 DetAut.IdDetalleAutorizacion,
 DetAut.IdAutorizacion,
 DetAut.OrdenAutorizacion as [Ord.aut.],
 CASE
	WHEN IsNull(ADesignar,'')='SI' THEN 'A Designar'
	WHEN SectorEmisor1='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor1='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza1=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor1='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante1=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza1=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza1=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 1],
 CASE
	WHEN SectorEmisor2='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra2,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra2,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra2,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor2='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza2=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor2='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante2=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza2=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza2=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 2],
 CASE
	WHEN SectorEmisor3='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra3,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra3,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra3,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor3='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza3=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor3='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante3=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza3=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza3=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 3],
 CASE
	WHEN SectorEmisor4='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra4,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra4,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra4,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor4='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza4=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor4='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante4=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza4=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza4=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 4],
 CASE
	WHEN SectorEmisor5='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra5,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra5,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra5,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor5='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza5=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor5='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante5=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza5=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza5=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 5],
 CASE
	WHEN SectorEmisor6='O' THEN
		'Personal obra : [ '+
		CASE WHEN IsNull(DetAut.PersonalObra6,-1)=0 THEN 'Jefe regional'
			WHEN IsNull(DetAut.PersonalObra6,-1)=1 THEN 'Jefe de obra'
			WHEN IsNull(DetAut.PersonalObra6,-1)=2 THEN 'Subjefe de obra'
			ELSE 'Jefe regional'
		END+' ] de '+
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor6='S' THEN
		'Sector emisor : [ ' + 
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza6=Cargos.IdCargo) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	WHEN SectorEmisor6='F' THEN
		'Firmante : [ ' + 
		(Select Top 1 Empleados.Nombre 
		 From Empleados
		 Where DetAut.IdFirmante6=Empleados.IdEmpleado) + ' ] de ' + 
		Convert(varchar,IsNull(ImporteDesde1,0)) + ' a ' + 
		Convert(varchar,IsNull(ImporteHasta1,0))
	ELSE
		(Select Top 1 Sectores.Descripcion 
		 From Sectores 
		 Where DetAut.IdSectorAutoriza6=Sectores.IdSector) + ' : [ ' +
		(Select Top 1 Cargos.Descripcion 
		 From Cargos
		 Where DetAut.IdCargoAutoriza6=Cargos.IdCargo) + ' ]' 
 END as [Autorizacion 6],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAutorizaciones DetAut
WHERE (DetAut.IdAutorizacion = @IdAutorizacion)
ORDER BY DetAut.OrdenAutorizacion
