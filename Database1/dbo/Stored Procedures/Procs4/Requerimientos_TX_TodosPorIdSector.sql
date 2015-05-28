CREATE  Procedure [dbo].[Requerimientos_TX_TodosPorIdSector]

@IdSector int,
@IdObraAsignadaUsuario int = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)
SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @ActivarSolicitudMateriales varchar(2)
SET @ActivarSolicitudMateriales=IsNull((Select Top 1 P.ActivarSolicitudMateriales 
					From Parametros P Where P.IdParametro=1),'NO')

/* PRESUPUESTOS */
CREATE TABLE #Auxiliar0 
			(
			 IdRequerimiento INTEGER,
			 Presupuestos VARCHAR(100)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdRequerimiento INTEGER,
			 Presupuesto VARCHAR(13)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetReq.IdRequerimiento,
  Convert(varchar,Presupuestos.Numero)+
	Case When Presupuestos.Subnumero is not null
		Then '/'+Convert(varchar,Presupuestos.Subnumero)
		Else ''
	End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
 LEFT OUTER JOIN Presupuestos ON DetallePresupuestos.IdPresupuesto = Presupuestos.IdPresupuesto
 WHERE (@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdRequerimiento,Presupuesto) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar1
 GROUP BY IdRequerimiento

/*  CURSOR  */
DECLARE @IdRequerimiento int, @Presupuesto varchar(13), @P varchar(100), @Corte int
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Presupuesto
		FROM #Auxiliar1
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @Presupuesto
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Presupuestos = SUBSTRING(@P,1,100)
			WHERE #Auxiliar0.IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento
	   END
	IF NOT @Presupuesto IS NULL
		IF PATINDEX('%'+@Presupuesto+' '+'%', @P)=0
			SET @P=@P+@Presupuesto+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @Presupuesto
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar0
	SET Presupuestos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar0.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


/* COMPARATIVAS */
CREATE TABLE #Auxiliar2 
			(
			 IdRequerimiento INTEGER,
			 Comparativas VARCHAR(100)
			)

CREATE TABLE #Auxiliar3 
			(
			 IdRequerimiento INTEGER,
			 Comparativa INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT DetReq.IdRequerimiento, Comparativas.Numero
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
 LEFT OUTER JOIN DetalleComparativas ON DetallePresupuestos.IdDetallePresupuesto = DetalleComparativas.IdDetallePresupuesto
 LEFT OUTER JOIN Comparativas ON DetalleComparativas.IdComparativa = Comparativas.IdComparativa
 WHERE (@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdRequerimiento,Comparativa) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar3
 GROUP BY IdRequerimiento

/*  CURSOR  */
DECLARE @Comparativa int, @C varchar(100)
SET @Corte=0
SET @C=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Comparativa
		FROM #Auxiliar3
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @Comparativa
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar2
			SET Comparativas = SUBSTRING(@C,1,100)
			WHERE #Auxiliar2.IdRequerimiento=@Corte
		   END
		SET @C=''
		SET @Corte=@IdRequerimiento
	   END
	IF NOT @Comparativa IS NULL
		IF PATINDEX('%'+Convert(varchar,@Comparativa)+' '+'%', @C)=0
			SET @C=@C+Convert(varchar,@Comparativa)+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @Comparativa
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar2
	SET Comparativas = SUBSTRING(@C,1,100)
	WHERE #Auxiliar2.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


/* PEDIDOS */
CREATE TABLE #Auxiliar4 
			(
			 IdRequerimiento INTEGER,
			 Pedidos VARCHAR(100)
			)

CREATE TABLE #Auxiliar5 
			(
			 IdRequerimiento INTEGER,
			 Pedido VARCHAR(13)
			)
INSERT INTO #Auxiliar5 
 SELECT 
  DetReq.IdRequerimiento,
  Convert(varchar,Pedidos.NumeroPedido)+
	Case When Pedidos.Subnumero is not null
		Then '/'+Convert(varchar,Pedidos.Subnumero)
		Else ''
	End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetallePedidos ON DetReq.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
 LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
 WHERE (@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdRequerimiento,Pedido) ON [PRIMARY]

INSERT INTO #Auxiliar4 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar5
 GROUP BY IdRequerimiento

/*  CURSOR  */
DECLARE @Pedido varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Pedido
		FROM #Auxiliar5
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @Pedido
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar4
			SET Pedidos = SUBSTRING(@P,1,100)
			WHERE #Auxiliar4.IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento
	   END
	IF NOT @Pedido IS NULL
		IF PATINDEX('%'+@Pedido+' '+'%', @P)=0
			SET @P=@P+@Pedido+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @Pedido
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar4
	SET Pedidos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar4.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


/* RECEPCION DE MATERIALES */
CREATE TABLE #Auxiliar6 
			(
			 IdRequerimiento INTEGER,
			 Recepciones VARCHAR(100)
			)

CREATE TABLE #Auxiliar7 
			(
			 IdRequerimiento INTEGER,
			 Recepcion VARCHAR(20)
			)
INSERT INTO #Auxiliar7 
 SELECT 
  DetReq.IdRequerimiento,
  Case When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
  End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetalleRecepciones ON DetReq.IdDetalleRequerimiento = DetalleRecepciones.IdDetalleRequerimiento
 LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
 WHERE (@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 (IdRequerimiento,Recepcion) ON [PRIMARY]

INSERT INTO #Auxiliar6 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar7
 GROUP BY IdRequerimiento

/*  CURSOR  */
DECLARE @Recepcion varchar(20)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Recepcion
		FROM #Auxiliar7
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @Recepcion
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar6
			SET Recepciones = SUBSTRING(@P,1,100)
			WHERE IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento
	   END
	IF NOT @Recepcion IS NULL
		IF PATINDEX('%'+@Recepcion+' '+'%', @P)=0
			SET @P=@P+@Recepcion+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @Recepcion
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar6
	SET Recepciones = SUBSTRING(@P,1,100)
	WHERE IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


/* SALIDAS DE MATERIALES */
CREATE TABLE #Auxiliar8 
			(
			 IdRequerimiento INTEGER,
			 Salidas VARCHAR(100)
			)

CREATE TABLE #Auxiliar9 
			(
			 IdRequerimiento INTEGER,
			 Salida VARCHAR(13)
			)
INSERT INTO #Auxiliar9 
 SELECT 
  DetReq.IdRequerimiento,
  Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,13)
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN DetalleValesSalida ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
 LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleValesSalida.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE (@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

CREATE NONCLUSTERED INDEX IX__Auxiliar9 ON #Auxiliar9 (IdRequerimiento,Salida) ON [PRIMARY]

INSERT INTO #Auxiliar8 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar9
 GROUP BY IdRequerimiento

/*  CURSOR  */
DECLARE @Salida varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Salida
		FROM #Auxiliar9
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @Salida
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar8
			SET Salidas = SUBSTRING(@P,1,100)
			WHERE IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento
	   END
	IF NOT @Salida IS NULL
		IF PATINDEX('%'+@Salida+' '+'%', @P)=0
			SET @P=@P+@Salida+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @Salida
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar8
	SET Salidas = SUBSTRING(@P,1,100)
	WHERE IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='011111111111111111111111111111133'
IF @ActivarSolicitudMateriales='SI'
	Set @vector_T='0594922200FFFFF511235D143E1620500'
ELSE
	Set @vector_T='0594122200FFFFF511235D143E1620500'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 #Auxiliar0.Presupuestos as [Presupuestos],
 #Auxiliar2.Comparativas as [Comparativas],
 #Auxiliar4.Pedidos as [Pedidos],
 #Auxiliar6.Recepciones as [Recepciones],
 #Auxiliar8.Salidas as [Salidas],
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
	Articulos.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo 
				From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
					Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
	Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador 
				From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdImporto=Empleados.IdEmpleado) as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar0 ON Requerimientos.IdRequerimiento=#Auxiliar0.IdRequerimiento
LEFT OUTER JOIN #Auxiliar2 ON Requerimientos.IdRequerimiento=#Auxiliar2.IdRequerimiento
LEFT OUTER JOIN #Auxiliar4 ON Requerimientos.IdRequerimiento=#Auxiliar4.IdRequerimiento
LEFT OUTER JOIN #Auxiliar6 ON Requerimientos.IdRequerimiento=#Auxiliar6.IdRequerimiento
LEFT OUTER JOIN #Auxiliar8 ON Requerimientos.IdRequerimiento=#Auxiliar8.IdRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE IsNull(Requerimientos.Confirmado,'SI')<>'NO' and 
	(@IdSector=-1 or Requerimientos.IdSector=@IdSector) and 
	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario) and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Requerimientos.IdObra))
ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9