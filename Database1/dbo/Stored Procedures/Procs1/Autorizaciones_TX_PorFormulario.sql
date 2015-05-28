CREATE Procedure [dbo].[Autorizaciones_TX_PorFormulario]

@IdFormulario int,
@IdOrden int,
@IdSectorRM int,
@IdObra int,
@Importe numeric(18,2), 
@IdEmpleadoSolo int = Null

AS 

SET NOCOUNT ON

SET @IdEmpleadoSolo=IsNull(@IdEmpleadoSolo,0)

DECLARE @SectorEmisor1 varchar(1), @SectorEmisor2 varchar(1), @SectorEmisor3 varchar(1), @SectorEmisor4 varchar(1), 
		@SectorEmisor5 varchar(1), @SectorEmisor6 varchar(1), @IdSectorAutoriza1 int, @IdSectorAutoriza2 int, @IdSectorAutoriza3 int,
		@IdSectorAutoriza4 int, @IdSectorAutoriza5 int, @IdSectorAutoriza6 int, @IdCargoAutoriza1 int, @IdCargoAutoriza2 int, 
		@IdCargoAutoriza3 int, @IdCargoAutoriza4 int, @IdCargoAutoriza5 int, @IdCargoAutoriza6 int, @PersonalObra1 int, @PersonalObra2 int, 
		@PersonalObra3 int, @PersonalObra4 int, @PersonalObra5 int, @PersonalObra6 int

SET @SectorEmisor1=(Select Top 1 DetAut.SectorEmisor1 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
/*
				(@IdFormulario<>4 or (IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or 
				 (@IdFormulario=4 and IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
*/
SET @SectorEmisor2=(Select Top 1 DetAut.SectorEmisor2 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @SectorEmisor3=(Select Top 1 DetAut.SectorEmisor3 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @SectorEmisor4=(Select Top 1 DetAut.SectorEmisor4 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @SectorEmisor5=(Select Top 1 DetAut.SectorEmisor5 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @SectorEmisor6=(Select Top 1 DetAut.SectorEmisor6 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza1=(Select Top 1 DetAut.IdSectorAutoriza1
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza2=(Select Top 1 DetAut.IdSectorAutoriza2
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza3=(Select Top 1 DetAut.IdSectorAutoriza3
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza4=(Select Top 1 DetAut.IdSectorAutoriza4
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza5=(Select Top 1 DetAut.IdSectorAutoriza5
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdSectorAutoriza6=(Select Top 1 DetAut.IdSectorAutoriza6
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza1=(Select Top 1 DetAut.IdCargoAutoriza1
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza2=(Select Top 1 DetAut.IdCargoAutoriza2
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza3=(Select Top 1 DetAut.IdCargoAutoriza3
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza4=(Select Top 1 DetAut.IdCargoAutoriza4
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza5=(Select Top 1 DetAut.IdCargoAutoriza5
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @IdCargoAutoriza6=(Select Top 1 DetAut.IdCargoAutoriza6
						From DetalleAutorizaciones DetAut
						Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
						Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
							((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra1=(Select Top 1 DetAut.PersonalObra1 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra2=(Select Top 1 DetAut.PersonalObra2 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra3=(Select Top 1 DetAut.PersonalObra3 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra4=(Select Top 1 DetAut.PersonalObra4 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra5=(Select Top 1 DetAut.PersonalObra5 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))
SET @PersonalObra6=(Select Top 1 DetAut.PersonalObra6 From DetalleAutorizaciones DetAut
					Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
					Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
						((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe)))

CREATE TABLE #Auxiliar0 (IdEmpleado INTEGER)
INSERT INTO #Auxiliar0 
 SELECT Emp.IdEmpleado
 FROM Empleados Emp
 LEFT OUTER JOIN Obras ON Obras.IdObra=@IdObra
 WHERE 
	(@SectorEmisor1='N' and ((@IdSectorAutoriza1=Emp.IdSector and @IdCargoAutoriza1=Emp.IdCargo) or
							 (@IdSectorAutoriza1=Emp.IdSector1 and @IdCargoAutoriza1=Emp.IdCargo1) or
							 (@IdSectorAutoriza1=Emp.IdSector2 and @IdCargoAutoriza1=Emp.IdCargo2) or
							 (@IdSectorAutoriza1=Emp.IdSector3 and @IdCargoAutoriza1=Emp.IdCargo3) or
							 (@IdSectorAutoriza1=Emp.IdSector4 and @IdCargoAutoriza1=Emp.IdCargo4)))
	OR
	(@SectorEmisor2='N' and ((@IdSectorAutoriza2=Emp.IdSector and @IdCargoAutoriza2=Emp.IdCargo) or
							 (@IdSectorAutoriza2=Emp.IdSector1 and @IdCargoAutoriza2=Emp.IdCargo1) or
							 (@IdSectorAutoriza2=Emp.IdSector2 and @IdCargoAutoriza2=Emp.IdCargo2) or
							 (@IdSectorAutoriza2=Emp.IdSector3 and @IdCargoAutoriza2=Emp.IdCargo3) or
							 (@IdSectorAutoriza2=Emp.IdSector4 and @IdCargoAutoriza2=Emp.IdCargo4)))
	OR
	(@SectorEmisor3='N' and ((@IdSectorAutoriza3=Emp.IdSector and @IdCargoAutoriza3=Emp.IdCargo) or
							 (@IdSectorAutoriza3=Emp.IdSector1 and @IdCargoAutoriza3=Emp.IdCargo1) or
							 (@IdSectorAutoriza3=Emp.IdSector2 and @IdCargoAutoriza3=Emp.IdCargo2) or
							 (@IdSectorAutoriza3=Emp.IdSector3 and @IdCargoAutoriza3=Emp.IdCargo3) or
							 (@IdSectorAutoriza3=Emp.IdSector4 and @IdCargoAutoriza3=Emp.IdCargo4)))
	OR
	(@SectorEmisor4='N' and ((@IdSectorAutoriza4=Emp.IdSector and @IdCargoAutoriza4=Emp.IdCargo) or
							 (@IdSectorAutoriza4=Emp.IdSector1 and @IdCargoAutoriza4=Emp.IdCargo1) or
							 (@IdSectorAutoriza4=Emp.IdSector2 and @IdCargoAutoriza4=Emp.IdCargo2) or
							 (@IdSectorAutoriza4=Emp.IdSector3 and @IdCargoAutoriza4=Emp.IdCargo3) or
							 (@IdSectorAutoriza4=Emp.IdSector4 and @IdCargoAutoriza4=Emp.IdCargo4)))
	OR
	(@SectorEmisor5='N' and ((@IdSectorAutoriza5=Emp.IdSector and @IdCargoAutoriza5=Emp.IdCargo) or
							 (@IdSectorAutoriza5=Emp.IdSector1 and @IdCargoAutoriza5=Emp.IdCargo1) or
							 (@IdSectorAutoriza5=Emp.IdSector2 and @IdCargoAutoriza5=Emp.IdCargo2) or
							 (@IdSectorAutoriza5=Emp.IdSector3 and @IdCargoAutoriza5=Emp.IdCargo3) or
							 (@IdSectorAutoriza5=Emp.IdSector4 and @IdCargoAutoriza5=Emp.IdCargo4)))
	OR
	(@SectorEmisor6='N' and ((@IdSectorAutoriza6=Emp.IdSector and @IdCargoAutoriza6=Emp.IdCargo) or
							 (@IdSectorAutoriza6=Emp.IdSector1 and @IdCargoAutoriza6=Emp.IdCargo1) or
							 (@IdSectorAutoriza6=Emp.IdSector2 and @IdCargoAutoriza6=Emp.IdCargo2) or
							 (@IdSectorAutoriza6=Emp.IdSector3 and @IdCargoAutoriza6=Emp.IdCargo3) or
							 (@IdSectorAutoriza6=Emp.IdSector4 and @IdCargoAutoriza6=Emp.IdCargo4)))
	OR
	(@SectorEmisor1='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza1=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza1=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza1=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza1=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza1=Emp.IdCargo4)))
	OR
	(@SectorEmisor2='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza2=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza2=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza2=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza2=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza2=Emp.IdCargo4)))
	OR
	(@SectorEmisor3='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza3=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza3=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza3=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza3=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza3=Emp.IdCargo4)))
	OR
	(@SectorEmisor4='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza4=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza4=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza4=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza4=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza4=Emp.IdCargo4)))
	OR
	(@SectorEmisor5='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza5=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza5=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza5=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza5=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza5=Emp.IdCargo4)))
	OR
	(@SectorEmisor6='S' and ((@IdSectorRM=Emp.IdSector and @IdCargoAutoriza6=Emp.IdCargo) or
							 (@IdSectorRM=Emp.IdSector1 and @IdCargoAutoriza6=Emp.IdCargo1) or
							 (@IdSectorRM=Emp.IdSector2 and @IdCargoAutoriza6=Emp.IdCargo2) or
							 (@IdSectorRM=Emp.IdSector3 and @IdCargoAutoriza6=Emp.IdCargo3) or
							 (@IdSectorRM=Emp.IdSector4 and @IdCargoAutoriza6=Emp.IdCargo4)))
	OR
	(@SectorEmisor1='O' and ((IsNull(@PersonalObra1,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra1,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra1,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
	OR
	(@SectorEmisor2='O' and ((IsNull(@PersonalObra2,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra2,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra2,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
	OR
	(@SectorEmisor3='O' and ((IsNull(@PersonalObra3,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra3,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra3,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
	OR
	(@SectorEmisor4='O' and ((IsNull(@PersonalObra4,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra4,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra4,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
	OR
	(@SectorEmisor5='O' and ((IsNull(@PersonalObra5,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra5,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra5,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
	OR
	(@SectorEmisor6='O' and ((IsNull(@PersonalObra6,-1)=0 and Emp.IdEmpleado=Obras.IdJefeRegional) or 
							 (IsNull(@PersonalObra6,-1)=1 and Emp.IdEmpleado=Obras.IdJefe) or 
							 (IsNull(@PersonalObra6,-1)=2 and Emp.IdEmpleado=Obras.IdSubJefe)))
UNION ALL
 SELECT DetAut.IdFirmante1 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante1 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe
UNION ALL
 SELECT DetAut.IdFirmante2 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante2 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe
UNION ALL
 SELECT DetAut.IdFirmante3 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante3 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe
UNION ALL
 SELECT DetAut.IdFirmante4 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante4 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe
UNION ALL
 SELECT DetAut.IdFirmante5 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante5 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe
UNION ALL
 SELECT DetAut.IdFirmante6 
 FROM DetalleAutorizaciones DetAut 
 LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
 WHERE DetAut.IdFirmante6 is not null and Autorizaciones.IdFormulario=@IdFormulario and 
		DetAut.OrdenAutorizacion=@IdOrden and 
		IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe

IF @IdEmpleadoSolo>0
	INSERT INTO #Auxiliar0 (IdEmpleado) VALUES (@IdEmpleadoSolo)

SET NOCOUNT OFF

/*
Select * From DetalleAutorizaciones DetAut
Inner Join Autorizaciones On DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion 
Where Autorizaciones.IdFormulario=@IdFormulario and DetAut.OrdenAutorizacion=@IdOrden and 
	((IsNull(DetAut.ImporteDesde1,0)=0 and IsNull(DetAut.ImporteHasta1,0)=0) or (IsNull(DetAut.ImporteDesde1,0)<=@Importe and IsNull(DetAut.ImporteHasta1,0)>=@Importe))

select @SectorEmisor1,@SectorEmisor2,@SectorEmisor3,@SectorEmisor4,@SectorEmisor5,@SectorEmisor6
select @IdSectorAutoriza1,@IdSectorAutoriza2,@IdSectorAutoriza3,@IdSectorAutoriza4,@IdSectorAutoriza5,@IdSectorAutoriza6
select @IdCargoAutoriza1,@IdCargoAutoriza2,@IdCargoAutoriza3,@IdCargoAutoriza4,@IdCargoAutoriza5,@IdCargoAutoriza6
select @PersonalObra1,@PersonalObra2,@PersonalObra3,@PersonalObra4,@PersonalObra5,@PersonalObra6
*/

SELECT DISTINCT 
 #Auxiliar0.IdEmpleado,
 Empleados.Nombre
FROM #Auxiliar0 
LEFT OUTER JOIN Empleados ON #Auxiliar0.IdEmpleado=Empleados.IdEmpleado

DROP TABLE #Auxiliar0