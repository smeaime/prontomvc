
CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_SuplenteDelTitular]

@IdTitular int,
@IdSuplente int

AS

SET NOCOUNT ON

DECLARE @IdDetalleAutorizacion int, @IdFormulario int, @OrdenAutorizacion int, @IdAutoriza int, 
	@IdSuplente1 int, @SectorEmisor2 varchar(1), @SectorEmisor3 varchar(1), @SectorEmisor4 varchar(1), 
	@SectorEmisor5 varchar(1), @SectorEmisor6 varchar(1), @IdSectorAutoriza2 int, 
	@IdSectorAutoriza3 int, @IdSectorAutoriza4 int, @IdSectorAutoriza5 int, @IdSectorAutoriza6 int,	
	@IdCargoAutoriza2 int, @IdCargoAutoriza3 int, @IdCargoAutoriza4 int, @IdCargoAutoriza5 int, 
	@IdCargoAutoriza6 int, @IdObra int, @IdSector int

CREATE TABLE #Auxiliar0 (IdTitular INTEGER)
CREATE TABLE #Auxiliar1 (IdSuplente INTEGER)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleAutorizacion, IdFormulario, OrdenAutorizacion, IdAutoriza, IdSector
		FROM _TempAutorizaciones
		ORDER BY IdFormulario, OrdenAutorizacion, IdDetalleAutorizacion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleAutorizacion, @IdFormulario, @OrdenAutorizacion, 
			 @IdAutoriza, @IdSector
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SectorEmisor2=(Select Top 1 DetAut.SectorEmisor2 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @SectorEmisor3=(Select Top 1 DetAut.SectorEmisor3 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @SectorEmisor4=(Select Top 1 DetAut.SectorEmisor4 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @SectorEmisor5=(Select Top 1 DetAut.SectorEmisor5 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @SectorEmisor6=(Select Top 1 DetAut.SectorEmisor6 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdSectorAutoriza2=(Select Top 1 DetAut.IdSectorAutoriza2 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdSectorAutoriza3=(Select Top 1 DetAut.IdSectorAutoriza3 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdSectorAutoriza4=(Select Top 1 DetAut.IdSectorAutoriza4 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdSectorAutoriza5=(Select Top 1 DetAut.IdSectorAutoriza5 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdSectorAutoriza6=(Select Top 1 DetAut.IdSectorAutoriza6 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdCargoAutoriza2=(Select Top 1 DetAut.IdCargoAutoriza2 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdCargoAutoriza3=(Select Top 1 DetAut.IdCargoAutoriza3 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdCargoAutoriza4=(Select Top 1 DetAut.IdCargoAutoriza4 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdCargoAutoriza5=(Select Top 1 DetAut.IdCargoAutoriza5 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)
	SET @IdCargoAutoriza6=(Select Top 1 DetAut.IdCargoAutoriza6 From DetalleAutorizaciones DetAut
				Where DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion)

	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT Emp.IdEmpleado
	 FROM Empleados Emp
	 --LEFT OUTER JOIN Obras ON Obras.IdObra=@IdObra
	 WHERE 
		(@SectorEmisor2='N' and ((@IdSectorAutoriza2=Emp.IdSector  and @IdCargoAutoriza2=Emp.IdCargo ) or
					 (@IdSectorAutoriza2=Emp.IdSector1 and @IdCargoAutoriza2=Emp.IdCargo1) or
					 (@IdSectorAutoriza2=Emp.IdSector2 and @IdCargoAutoriza2=Emp.IdCargo2) or
					 (@IdSectorAutoriza2=Emp.IdSector3 and @IdCargoAutoriza2=Emp.IdCargo3) or
					 (@IdSectorAutoriza2=Emp.IdSector4 and @IdCargoAutoriza2=Emp.IdCargo4)	))
		OR
		(@SectorEmisor3='N' and ((@IdSectorAutoriza3=Emp.IdSector  and @IdCargoAutoriza3=Emp.IdCargo ) or
					 (@IdSectorAutoriza3=Emp.IdSector1 and @IdCargoAutoriza3=Emp.IdCargo1) or
					 (@IdSectorAutoriza3=Emp.IdSector2 and @IdCargoAutoriza3=Emp.IdCargo2) or
					 (@IdSectorAutoriza3=Emp.IdSector3 and @IdCargoAutoriza3=Emp.IdCargo3) or
					 (@IdSectorAutoriza3=Emp.IdSector4 and @IdCargoAutoriza3=Emp.IdCargo4)	))
		OR
		(@SectorEmisor4='N' and ((@IdSectorAutoriza4=Emp.IdSector  and @IdCargoAutoriza4=Emp.IdCargo ) or
					 (@IdSectorAutoriza4=Emp.IdSector1 and @IdCargoAutoriza4=Emp.IdCargo1) or
					 (@IdSectorAutoriza4=Emp.IdSector2 and @IdCargoAutoriza4=Emp.IdCargo2) or
					 (@IdSectorAutoriza4=Emp.IdSector3 and @IdCargoAutoriza4=Emp.IdCargo3) or
					 (@IdSectorAutoriza4=Emp.IdSector4 and @IdCargoAutoriza4=Emp.IdCargo4)	))
		OR
		(@SectorEmisor5='N' and ((@IdSectorAutoriza5=Emp.IdSector  and @IdCargoAutoriza5=Emp.IdCargo ) or
					 (@IdSectorAutoriza5=Emp.IdSector1 and @IdCargoAutoriza5=Emp.IdCargo1) or
					 (@IdSectorAutoriza5=Emp.IdSector2 and @IdCargoAutoriza5=Emp.IdCargo2) or
					 (@IdSectorAutoriza5=Emp.IdSector3 and @IdCargoAutoriza5=Emp.IdCargo3) or
					 (@IdSectorAutoriza5=Emp.IdSector4 and @IdCargoAutoriza5=Emp.IdCargo4)	))
		OR
		(@SectorEmisor6='N' and ((@IdSectorAutoriza6=Emp.IdSector  and @IdCargoAutoriza6=Emp.IdCargo ) or
					 (@IdSectorAutoriza6=Emp.IdSector1 and @IdCargoAutoriza6=Emp.IdCargo1) or
					 (@IdSectorAutoriza6=Emp.IdSector2 and @IdCargoAutoriza6=Emp.IdCargo2) or
					 (@IdSectorAutoriza6=Emp.IdSector3 and @IdCargoAutoriza6=Emp.IdCargo3) or
					 (@IdSectorAutoriza6=Emp.IdSector4 and @IdCargoAutoriza6=Emp.IdCargo4)	))
		OR
		(@SectorEmisor2='S' and ((@IdSector=Emp.IdSector  and @IdCargoAutoriza2=Emp.IdCargo ) or
					 (@IdSector=Emp.IdSector1 and @IdCargoAutoriza2=Emp.IdCargo1) or
					 (@IdSector=Emp.IdSector2 and @IdCargoAutoriza2=Emp.IdCargo2) or
					 (@IdSector=Emp.IdSector3 and @IdCargoAutoriza2=Emp.IdCargo3) or
					 (@IdSector=Emp.IdSector4 and @IdCargoAutoriza2=Emp.IdCargo4)	))
		OR
		(@SectorEmisor3='S' and ((@IdSector=Emp.IdSector  and @IdCargoAutoriza3=Emp.IdCargo ) or
					 (@IdSector=Emp.IdSector1 and @IdCargoAutoriza3=Emp.IdCargo1) or
					 (@IdSector=Emp.IdSector2 and @IdCargoAutoriza3=Emp.IdCargo2) or
					 (@IdSector=Emp.IdSector3 and @IdCargoAutoriza3=Emp.IdCargo3) or
					 (@IdSector=Emp.IdSector4 and @IdCargoAutoriza3=Emp.IdCargo4)	))
		OR
		(@SectorEmisor4='S' and ((@IdSector=Emp.IdSector  and @IdCargoAutoriza4=Emp.IdCargo ) or
					 (@IdSector=Emp.IdSector1 and @IdCargoAutoriza4=Emp.IdCargo1) or
					 (@IdSector=Emp.IdSector2 and @IdCargoAutoriza4=Emp.IdCargo2) or
					 (@IdSector=Emp.IdSector3 and @IdCargoAutoriza4=Emp.IdCargo3) or
					 (@IdSector=Emp.IdSector4 and @IdCargoAutoriza4=Emp.IdCargo4)	))
		OR
		(@SectorEmisor5='S' and ((@IdSector=Emp.IdSector  and @IdCargoAutoriza5=Emp.IdCargo ) or
					 (@IdSector=Emp.IdSector1 and @IdCargoAutoriza5=Emp.IdCargo1) or
					 (@IdSector=Emp.IdSector2 and @IdCargoAutoriza5=Emp.IdCargo2) or
					 (@IdSector=Emp.IdSector3 and @IdCargoAutoriza5=Emp.IdCargo3) or
					 (@IdSector=Emp.IdSector4 and @IdCargoAutoriza5=Emp.IdCargo4)	))
		OR
		(@SectorEmisor6='S' and ((@IdSector=Emp.IdSector  and @IdCargoAutoriza6=Emp.IdCargo ) or
					 (@IdSector=Emp.IdSector1 and @IdCargoAutoriza6=Emp.IdCargo1) or
					 (@IdSector=Emp.IdSector2 and @IdCargoAutoriza6=Emp.IdCargo2) or
					 (@IdSector=Emp.IdSector3 and @IdCargoAutoriza6=Emp.IdCargo3) or
					 (@IdSector=Emp.IdSector4 and @IdCargoAutoriza6=Emp.IdCargo4)	))
		/*
		OR
		(@SectorEmisor2='O' and (Emp.IdEmpleado=Obras.IdJefe or Emp.IdEmpleado=IsNull(Obras.IdSubjefe,0)))
		OR
		(@SectorEmisor3='O' and (Emp.IdEmpleado=Obras.IdJefe or Emp.IdEmpleado=IsNull(Obras.IdSubjefe,0)))
		OR
		(@SectorEmisor4='O' and (Emp.IdEmpleado=Obras.IdJefe or Emp.IdEmpleado=IsNull(Obras.IdSubjefe,0)))
		OR
		(@SectorEmisor5='O' and (Emp.IdEmpleado=Obras.IdJefe or Emp.IdEmpleado=IsNull(Obras.IdSubjefe,0)))
		OR
		(@SectorEmisor6='O' and (Emp.IdEmpleado=Obras.IdJefe or Emp.IdEmpleado=IsNull(Obras.IdSubjefe,0)))
		*/
	UNION ALL
	 SELECT DetAut.IdFirmante2 FROM DetalleAutorizaciones DetAut 
	 WHERE DetAut.IdFirmante2 is not null and DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion
	UNION ALL	 SELECT DetAut.IdFirmante3 FROM DetalleAutorizaciones DetAut 
	 WHERE DetAut.IdFirmante3 is not null and DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion
	UNION ALL
	 SELECT DetAut.IdFirmante4 FROM DetalleAutorizaciones DetAut 
	 WHERE DetAut.IdFirmante4 is not null and DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion
	UNION ALL
	 SELECT DetAut.IdFirmante5 FROM DetalleAutorizaciones DetAut 
	 WHERE DetAut.IdFirmante5 is not null and DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion
	UNION ALL
	 SELECT DetAut.IdFirmante6 FROM DetalleAutorizaciones DetAut 
	 WHERE DetAut.IdFirmante6 is not null and DetAut.IdDetalleAutorizacion=@IdDetalleAutorizacion
	
	IF EXISTS(Select Top 1 IdSuplente From #Auxiliar1 Where IdSuplente=@IdSuplente)
		INSERT INTO #Auxiliar0 (IdTitular) VALUES (@IdAutoriza)

	FETCH NEXT FROM Cur INTO @IdDetalleAutorizacion, @IdFormulario, @OrdenAutorizacion, 
				 @IdAutoriza, @IdSector
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT TOP 1 IdTitular
FROM #Auxiliar0
WHERE @IdTitular=IdTitular

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1

