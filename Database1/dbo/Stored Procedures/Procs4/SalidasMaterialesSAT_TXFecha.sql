CREATE  Procedure [dbo].[SalidasMaterialesSAT_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdObraAsignadaUsuario int = Null,
@ConCostos varchar(2) = Null

AS 

SET NOCOUNT ON

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)
SET @ConCostos=IsNull(@ConCostos,'SI')

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases WHERE name = N'+''''+@BasePRONTOMANT+''''
CREATE TABLE #Auxiliar10 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1

CREATE TABLE #Auxiliar0 
			(
			 IdSalidaMateriales INTEGER,
			 Equipos VARCHAR(200)
			)
CREATE TABLE #Auxiliar1 
			(
			 IdSalidaMateriales INTEGER,
			 Equipo VARCHAR(10)
			)
IF (SELECT COUNT(*) FROM #Auxiliar10)>0
   BEGIN
	SET @sql1='SELECT DetSal.IdSalidaMateriales, A.NumeroInventario
			FROM DetalleSalidasMateriales DetSal
			LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Articulos A ON DetSal.IdEquipoDestino = A.IdArticulo
			WHERE A.NumeroInventario is not null and 
				SalidasMateriales.FechaSalidaMateriales between Convert(datetime,'''+Convert(varchar,@Desde,103)+''',103) and 
				Convert(datetime,'''+Convert(varchar,@hasta,103)+''',103)'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
    END
ELSE
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DetSal.IdSalidaMateriales, Articulos.NumeroInventario
	 FROM DetalleSalidasMateriales DetSal
	 LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	 LEFT OUTER JOIN Articulos ON DetSal.IdEquipoDestino = Articulos.IdArticulo
	 WHERE Articulos.NumeroInventario is not null and 
		SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta
    END

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdSalidaMateriales,Equipo) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT 
  IdSalidaMateriales,
  ''
 FROM #Auxiliar1
 GROUP BY IdSalidaMateriales

/*  CURSOR  */
DECLARE @IdSalidaMateriales int, @Equipo varchar(20), @P varchar(200), @Corte int
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdSalidaMateriales, Equipo
		FROM #Auxiliar1
		ORDER BY IdSalidaMateriales
OPEN Cur 
FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @Equipo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdSalidaMateriales
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Equipos = SUBSTRING(@P,1,200)
			WHERE #Auxiliar0.IdSalidaMateriales=@Corte
		   END
		SET @P=''
		SET @Corte=@IdSalidaMateriales
	   END
	IF NOT @Equipo IS NULL
		IF PATINDEX('%'+@Equipo+' '+'%', @P)=0
			SET @P=@P+@Equipo+' '
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @Equipo
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Equipos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar0.IdSalidaMateriales=@Corte
    END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='0111111111111111111111133'
Set @vector_T='07533154512222255253G0400'

SELECT 
 Sal.IdSalidaMateriales, CASE	WHEN Sal.TipoSalida=0 THEN 'Salida a fabrica'
	WHEN Sal.TipoSalida=1 THEN 'Salida a obra'
	WHEN Sal.TipoSalida=2 THEN 'A Proveedor'
	ELSE Null
 END as [Tipo de salida],
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(Sal.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(Sal.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Sal.NumeroSalidaMateriales)))+
	Convert(varchar,Sal.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 Sal.Observaciones as [Observaciones],
 Case When @ConCostos='SI' 
	Then (Select Sum(IsNull(dsm.Cantidad,0)*IsNull(dsm.CostoUnitario,0))
		From DetalleSalidasMaterialesSAT dsm 
		Where dsm.IdSalidaMateriales=Sal.IdSalidaMateriales) 
	Else Null 
 End as [Costo total],
 Sal.Anulada as [Anulada],
 Sal.ValePreimpreso as [Vale preimpreso],
 Sal.FechaSalidaMateriales as [Fecha],
 Obras.NumeroObra as [Numero obra],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 CentrosCosto.Descripcion as [Centro de costo],
 (Select Top 1 Empleados.Nombre 
  From Empleados Where Empleados.IdEmpleado=Sal.Emitio) as [Emitio],
 (Select Top 1 Empleados.Nombre 
  From Empleados Where Empleados.IdEmpleado=Sal.Aprobo) as [Aprobo],
 Sal.Cliente as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 Sal.Direccion as [Direccion],
 Sal.Localidad as [Localidad],
 Sal.CodigoPostal as [Cod.pos.],
 Transportistas.RazonSocial as [Transportista],
 (Select Count(*) From DetalleSalidasMaterialesSAT dsm  
  Where dsm.IdSalidaMateriales=Sal.IdSalidaMateriales) as [Cant.Items],
 #Auxiliar0.Equipos as [Equipo(s) destino],
 (Select Top 1 Empleados.Nombre 
  From Empleados Where Empleados.IdEmpleado=Sal.IdUsuarioAnulo) as [Anulo],
 Sal.FechaAnulacion as [Fecha anul.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SalidasMaterialesSAT Sal
LEFT OUTER JOIN Obras ON Sal.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Sal.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Transportistas ON Sal.IdTransportista1 = Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON Sal.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Sal.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN #Auxiliar0 ON Sal.IdSalidaMateriales = #Auxiliar0.IdSalidaMateriales
WHERE Sal.FechaSalidaMateriales between @Desde and @hasta and 
	(@IdObraAsignadaUsuario=-1 or Sal.IdObra=@IdObraAsignadaUsuario)
ORDER BY Sal.FechaSalidaMateriales, [Nro. de salida]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10