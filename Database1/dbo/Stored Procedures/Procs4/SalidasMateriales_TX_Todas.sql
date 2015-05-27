CREATE  Procedure [dbo].[SalidasMateriales_TX_Todas]

@IdObraAsignadaUsuario int = Null,
@ConCostos varchar(2) = Null,
@SoloPesadas varchar(2) = Null

AS 

SET NOCOUNT ON

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)
SET @ConCostos=IsNull(@ConCostos,'SI')
SET @SoloPesadas=IsNull(@SoloPesadas,'')

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50), @MostrarEntreCalles varchar(2)

SET @MostrarEntreCalles=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Mostrar entre calles en salida de materiales'),'')

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases WHERE name = N'+''''+@BasePRONTOMANT+''''
CREATE TABLE #Auxiliar10 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar10 EXEC sp_executesql @sql1

CREATE TABLE #Auxiliar0 
			(
			 IdSalidaMateriales INTEGER,
			 Equipos VARCHAR(2000)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdSalidaMateriales) ON [PRIMARY]
CREATE TABLE #Auxiliar1 
			(
			 IdSalidaMateriales INTEGER,
			 Descripcion VARCHAR(256),
			 NumeroInventario VARCHAR(20)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdSalidaMateriales,NumeroInventario) ON [PRIMARY]

IF (SELECT COUNT(*) FROM #Auxiliar10)>0
   BEGIN
	SET @sql1='SELECT DISTINCT DetSal.IdSalidaMateriales, a.Descripcion, a.NumeroInventario 
			FROM DetalleSalidasMateriales DetSal
			LEFT OUTER JOIN SalidasMateriales sm ON DetSal.IdSalidaMateriales = sm.IdSalidaMateriales
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Articulos a ON DetSal.IdEquipoDestino = a.IdArticulo
			WHERE a.IdArticulo is not null'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
    END
ELSE
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DISTINCT DetSal.IdSalidaMateriales, Articulos.Descripcion, Articulos.NumeroInventario
	 FROM DetalleSalidasMateriales DetSal
	 LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	 LEFT OUTER JOIN Articulos ON DetSal.IdEquipoDestino = Articulos.IdArticulo
	 WHERE Articulos.IdArticulo is not null
    END

INSERT INTO #Auxiliar0 
 SELECT IdSalidaMateriales, '' FROM #Auxiliar1 GROUP BY IdSalidaMateriales

/*  CURSOR  */
DECLARE @IdSalidaMateriales int, @NumeroInventario varchar(20), @Descripcion varchar(256), @Equipos varchar(2000), @Corte int
SET @Corte=0
SET @Equipos=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdSalidaMateriales, NumeroInventario, Descripcion FROM #Auxiliar1 ORDER BY IdSalidaMateriales
OPEN Cur 
FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @NumeroInventario, @Descripcion
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdSalidaMateriales
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar0
			SET Equipos = SUBSTRING(@Equipos,1,2000)
			WHERE IdSalidaMateriales=@Corte
		SET @Equipos=''
		SET @Corte=@IdSalidaMateriales
	   END
	IF NOT @NumeroInventario IS NULL
		IF PATINDEX('%'+@NumeroInventario+' '+'%', @Equipos)=0
			SET @Equipos=@Equipos+@NumeroInventario+' '+@Descripcion+' '
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @NumeroInventario, @Descripcion
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Equipos = SUBSTRING(@Equipos,1,2000)
	WHERE IdSalidaMateriales=@Corte
    END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar2 
			(
			 IdSalidaMateriales INTEGER,
			 Requerimientos VARCHAR(100)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdSalidaMateriales) ON [PRIMARY]

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
 LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
 LEFT OUTER JOIN DetalleRequerimientos ON DetalleValesSalida.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento

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
FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @NumeroRequerimiento
WHILE @@FETCH_STATUS = 0
 BEGIN
	IF @Corte<>@IdSalidaMateriales
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar2
			SET Requerimientos = SUBSTRING(@RMs,1,100)
			WHERE #Auxiliar2.IdSalidaMateriales=@Corte
		   END
		SET @RMs=''
		SET @Corte=@IdSalidaMateriales
	   END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroRequerimiento)+' '+'%', @RMs)=0
			SET @RMs=@RMs+CONVERT(VARCHAR,@NumeroRequerimiento)+' '
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @NumeroRequerimiento
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


DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111111111111133'
IF @MostrarEntreCalles='SI'
	SET @vector_T='075331540512222255253A043314142253F00'
ELSE
	SET @vector_T='075331540512222255253A043314142253900'

SELECT 
 SalidasMateriales.IdSalidaMateriales, Case When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else SalidasMateriales.ClaveTipoSalida
 End as [Tipo de salida],
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 SalidasMateriales.Observaciones as [Observaciones],
 Case When @ConCostos='SI' 
	Then (Select Sum(IsNull(dsm.Cantidad,0)*IsNull(dsm.CostoUnitario,0))
		From DetalleSalidasMateriales dsm 
		Where dsm.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales) 
	Else Null 
 End as [Costo total],
 SalidasMateriales.Anulada as [Anulada],
 SalidasMateriales.ValePreimpreso as [Vale preimpreso],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 #Auxiliar2.Requerimientos as [Requerimientos],
 Obras.NumeroObra as [Numero obra],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 CentrosCosto.Descripcion as [Centro de costo],
 E1.Nombre as [Emitio],
 E2.Nombre as [Aprobo],
 SalidasMateriales.Cliente as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 SalidasMateriales.Direccion as [Direccion],
 SalidasMateriales.Localidad as [Localidad],
 SalidasMateriales.CodigoPostal as [Cod.pos.],
 Transportistas.RazonSocial as [Transportista],
 (Select Count(*) From DetalleSalidasMateriales Where DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales) as [Cant.Items],
 #Auxiliar0.Equipos as [Equipo(s) destino],
 E3.Nombre as [Anulo],
 SalidasMateriales.FechaAnulacion as [Fecha anul.],
 SalidasMateriales.MotivoAnulacion as [Motivo anulacion],
 SalidasMateriales.NumeroOrdenProduccion as [Nro.Orden Prod.], E4.Nombre as [Confecciono],
 SalidasMateriales.FechaIngreso as [Fecha ing.],
 E5.Nombre as [Modifico],
 SalidasMateriales.FechaModifico as [Fecha modif.],
 Depositos.Descripcion as [Origen],
 ProduccionOrdenes.NumeroOrdenProduccion as [Nro.OP],
 SalidasMateriales.Detalle as [Detalle],
 SalidasMateriales.NumeroPesada as [Nro.Pesada],
 IsNull(C1.Nombre,'')+IsNull(' entre '+C2.Nombre,'')+IsNull(' y '+C3.Nombre,'') as [Destino - Calles],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SalidasMateriales
LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON SalidasMateriales.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1 = Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON SalidasMateriales.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN ArchivosATransmitirDestinos ON SalidasMateriales.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN #Auxiliar0 ON SalidasMateriales.IdSalidaMateriales = #Auxiliar0.IdSalidaMateriales
LEFT OUTER JOIN #Auxiliar2 ON SalidasMateriales.IdSalidaMateriales = #Auxiliar2.IdSalidaMateriales
LEFT OUTER JOIN Depositos ON SalidasMateriales.IdDepositoOrigen = Depositos.IdDeposito
LEFT OUTER JOIN Empleados E1 ON SalidasMateriales.Emitio = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON SalidasMateriales.Aprobo = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON SalidasMateriales.IdUsuarioAnulo = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON SalidasMateriales.IdUsuarioIngreso = E4.IdEmpleado
LEFT OUTER JOIN Empleados E5 ON SalidasMateriales.IdUsuarioModifico = E5.IdEmpleado
LEFT OUTER JOIN ProduccionOrdenes ON SalidasMateriales.IdProduccionOrden = ProduccionOrdenes.IdProduccionOrden
LEFT OUTER JOIN Calles C1 ON SalidasMateriales.IdCalle1 = C1.IdCalle
LEFT OUTER JOIN Calles C2 ON SalidasMateriales.IdCalle2 = C2.IdCalle
LEFT OUTER JOIN Calles C3 ON SalidasMateriales.IdCalle3 = C3.IdCalle
WHERE (@IdObraAsignadaUsuario=-1 or SalidasMateriales.IdObra=@IdObraAsignadaUsuario or IsNull(SalidasMateriales.IdObraOrigen,-1)=@IdObraAsignadaUsuario) and 
	(@SoloPesadas='' or (@SoloPesadas='SI' and IsNull(SalidasMateriales.NumeroPesada,0)>0))
ORDER BY SalidasMateriales.FechaSalidaMateriales

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar10