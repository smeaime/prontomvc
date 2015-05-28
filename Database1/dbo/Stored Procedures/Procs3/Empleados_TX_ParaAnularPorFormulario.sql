
CREATE Procedure [dbo].[Empleados_TX_ParaAnularPorFormulario]

@Formulario int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdEmpleado INTEGER)

CREATE TABLE #Auxiliar2 
			(
			 IdDetalleDefinicionAnulacion INTEGER,
			 IdEmpleado INTEGER,
			 IdCargo INTEGER,
			 IdSector INTEGER,
			 Administradores VARCHAR(2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetalleDefinicionAnulacion) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT Det.IdDetalleDefinicionAnulacion, Det.IdEmpleado, Det.IdCargo, Det.IdSector, Det.Administradores
 FROM DetalleDefinicionAnulaciones Det
 LEFT OUTER JOIN DefinicionAnulaciones ON Det.IdDefinicionAnulacion = DefinicionAnulaciones.IdDefinicionAnulacion
 WHERE DefinicionAnulaciones.IdFormulario=@Formulario

/*  CURSOR  */
DECLARE @IdEmpleado int, @IdCargo int, @IdSector int, @Administradores varchar(2)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEmpleado, IdCargo, IdSector, Administradores FROM #Auxiliar2 ORDER BY IdDetalleDefinicionAnulacion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdEmpleado, @IdCargo, @IdSector, @Administradores
WHILE @@FETCH_STATUS = 0
 BEGIN
	IF IsNull(@IdEmpleado,0)<>0
		INSERT INTO #Auxiliar1 VALUES (@IdEmpleado)

	IF IsNull(@IdCargo,0)<>0
		INSERT INTO #Auxiliar1 
		SELECT Empleados.IdEmpleado
		FROM Empleados
		WHERE IsNull(Empleados.IdCargo,0)=@IdCargo or 
			IsNull(Empleados.IdCargo1,0)=@IdCargo or 
			IsNull(Empleados.IdCargo2,0)=@IdCargo or 
			IsNull(Empleados.IdCargo3,0)=@IdCargo or 
			IsNull(Empleados.IdCargo4,0)=@IdCargo

	IF IsNull(@IdSector,0)<>0
		INSERT INTO #Auxiliar1 
		SELECT Empleados.IdEmpleado
		FROM Empleados
		WHERE IsNull(Empleados.IdSector,0)=@IdSector or 
			IsNull(Empleados.IdSector1,0)=@IdSector or 
			IsNull(Empleados.IdSector2,0)=@IdSector or 
			IsNull(Empleados.IdSector3,0)=@IdSector or 
			IsNull(Empleados.IdSector4,0)=@IdSector

	IF IsNull(@Administradores,'NO')<>'NO'
		INSERT INTO #Auxiliar1 
		SELECT Empleados.IdEmpleado
		FROM Empleados
		WHERE IsNull(Administrador,'NO')='SI'

	FETCH NEXT FROM Cur INTO @IdEmpleado, @IdCargo, @IdSector, @Administradores
 END
CLOSE Cur
DEALLOCATE Cur

SELECT DISTINCT #Auxiliar1.IdEmpleado,Empleados.Nombre
FROM #Auxiliar1
LEFT OUTER JOIN Empleados ON #Auxiliar1.IdEmpleado=Empleados.IdEmpleado
WHERE IsNull(Empleados.Activo,'')<>'NO'
ORDER BY Empleados.Nombre

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
