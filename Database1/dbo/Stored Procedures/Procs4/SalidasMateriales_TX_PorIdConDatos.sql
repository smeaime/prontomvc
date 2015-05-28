CREATE  Procedure [dbo].[SalidasMateriales_TX_PorIdConDatos]

@IdSalidaMateriales int

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases WHERE name = N'+''''+@BasePRONTOMANT+''''
CREATE TABLE #Auxiliar10 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1

CREATE TABLE #Auxiliar0 
			(
			 IdSalidaMateriales INTEGER,
			 Equipos VARCHAR(300)
			)
CREATE TABLE #Auxiliar1 
			(
			 IdSalidaMateriales INTEGER,
			 Equipo VARCHAR(20)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdSalidaMateriales,Equipo) ON [PRIMARY]
IF (SELECT COUNT(*) FROM #Auxiliar10)>0
   BEGIN
	SET @sql1='SELECT DetSal.IdSalidaMateriales, A.NumeroInventario
			FROM DetalleSalidasMateriales DetSal
			LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Articulos A ON DetSal.IdEquipoDestino = A.IdArticulo
			WHERE A.NumeroInventario is not null'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
    END
ELSE
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DetSal.IdSalidaMateriales, Articulos.NumeroInventario
	 FROM DetalleSalidasMateriales DetSal
	 LEFT OUTER JOIN Articulos ON DetSal.IdEquipoDestino = Articulos.IdArticulo
	 WHERE DetSal.IdSalidaMateriales=@IdSalidaMateriales and Articulos.NumeroInventario is not null
    END

INSERT INTO #Auxiliar0 
 SELECT IdSalidaMateriales, ''
 FROM #Auxiliar1
 GROUP BY IdSalidaMateriales

/*  CURSOR  */
DECLARE @IdSalidaMateriales1 int, @Equipo varchar(20), @P varchar(200), @Corte int
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdSalidaMateriales, Equipo FROM #Auxiliar1 ORDER BY IdSalidaMateriales
OPEN Cur
FETCH NEXT FROM Cur INTO @IdSalidaMateriales1, @Equipo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdSalidaMateriales1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Equipos = SUBSTRING(@P,1,200)
			WHERE #Auxiliar0.IdSalidaMateriales=@Corte
		   END
		SET @P=''
		SET @Corte=@IdSalidaMateriales1
	   END
	IF NOT @Equipo IS NULL
		IF PATINDEX('%'+@Equipo+' '+'%', @P)=0
			SET @P=@P+@Equipo+' '
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales1, @Equipo
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Equipos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar0.IdSalidaMateriales=@Corte
    END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar2 
			(
			 IdSalidaMateriales INTEGER,
			 Requerimientos VARCHAR(100)
			)

CREATE TABLE #Auxiliar3 
			(
			 IdSalidaMateriales INTEGER,
			 NumeroRequerimiento INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdSalidaMateriales,NumeroRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar3 
 SELECT 
  DetSal.IdSalidaMateriales,
  Requerimientos.NumeroRequerimiento
 FROM DetalleSalidasMateriales DetSal
 LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
 LEFT OUTER JOIN DetalleRequerimientos ON DetalleValesSalida.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetSal.IdSalidaMateriales=@IdSalidaMateriales

INSERT INTO #Auxiliar2 
 SELECT IdSalidaMateriales, ''
 FROM #Auxiliar3
 GROUP BY IdSalidaMateriales

/*  CURSOR  */
DECLARE @NumeroRequerimiento int, @RMs varchar(100)
SET @Corte=0
SET @RMs=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdSalidaMateriales, NumeroRequerimiento FROM #Auxiliar3 ORDER BY IdSalidaMateriales
OPEN Cur
FETCH NEXT FROM Cur INTO @IdSalidaMateriales1, @NumeroRequerimiento
WHILE @@FETCH_STATUS = 0
 BEGIN
	IF @Corte<>@IdSalidaMateriales1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar2
			SET Requerimientos = SUBSTRING(@RMs,1,100)
			WHERE #Auxiliar2.IdSalidaMateriales=@Corte
		   END
		SET @RMs=''
		SET @Corte=@IdSalidaMateriales1
	   END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroRequerimiento)+' '+'%', @RMs)=0
			SET @RMs=@RMs+CONVERT(VARCHAR,@NumeroRequerimiento)+' '
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales1, @NumeroRequerimiento
 END
 IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar2
	SET Requerimientos = SUBSTRING(@RMs,1,100)
	WHERE #Auxiliar2.IdSalidaMateriales=@Corte
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT 
 SalidasMateriales.*,
 CASE	WHEN SalidasMateriales.TipoSalida=0 THEN 'Salida a fabrica'
	WHEN SalidasMateriales.TipoSalida=1 THEN 'Salida a obra'
	WHEN SalidasMateriales.TipoSalida=2 THEN 'A Proveedor'
	ELSE SalidasMateriales.ClaveTipoSalida
 END as [TipoSalida1],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [SalidaMateriales],
 #Auxiliar2.Requerimientos as [Requerimientos],
 Obras.NumeroObra as [NumeroObra],
 CentrosCosto.Descripcion as [CentroCosto],
 E1.Nombre as [Emitio1],
 E1.Nombre as [Aprobo1],
 Proveedores.RazonSocial as [Proveedor],
 Transportistas.RazonSocial as [Transportista],
 #Auxiliar0.Equipos as [EquipoDestino],
 Depositos.Descripcion as [Origen],
 ProduccionOrdenes.NumeroOrdenProduccion as [NumeroOrdenProduccion1]
FROM SalidasMateriales
LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON SalidasMateriales.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1 = Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON SalidasMateriales.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN #Auxiliar0 ON SalidasMateriales.IdSalidaMateriales = #Auxiliar0.IdSalidaMateriales
LEFT OUTER JOIN #Auxiliar2 ON SalidasMateriales.IdSalidaMateriales = #Auxiliar2.IdSalidaMateriales
LEFT OUTER JOIN Depositos ON SalidasMateriales.IdDepositoOrigen = Depositos.IdDeposito
LEFT OUTER JOIN ProduccionOrdenes ON SalidasMateriales.IdProduccionOrden = ProduccionOrdenes.IdProduccionOrden
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = SalidasMateriales.Emitio
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = SalidasMateriales.Aprobo
WHERE SalidasMateriales.IdSalidaMateriales=@IdSalidaMateriales

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar10