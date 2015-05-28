CREATE  Procedure [dbo].[ValesSalida_TX_TT]

@IdValeSalida int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar8 
			(
			 IdValeSalida INTEGER,
			 Salidas VARCHAR(100)
			)

CREATE TABLE #Auxiliar9 
			(
			 IdValeSalida INTEGER,
			 Salida VARCHAR(13)
			)
INSERT INTO #Auxiliar9 
 SELECT 
  Det.IdValeSalida,
  Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,13)
 FROM DetalleValesSalida Det
 LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE (Det.IdValeSalida=@IdValeSalida)

CREATE NONCLUSTERED INDEX IX__Auxiliar9 ON #Auxiliar9 (IdValeSalida,Salida) ON [PRIMARY]

INSERT INTO #Auxiliar8 
 SELECT IdValeSalida, ''
 FROM #Auxiliar9
 GROUP BY IdValeSalida

/*  CURSOR  */
DECLARE @IdValeSalida1 int, @P varchar(100), @Corte int, @Salida varchar(13)
SET @Corte=0
SET @P=''

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdValeSalida, Salida FROM #Auxiliar9 ORDER BY IdValeSalida
OPEN Cur
FETCH NEXT FROM Cur INTO @IdValeSalida1, @Salida
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Corte<>@IdValeSalida
	  BEGIN
		IF @Corte<>0
		  BEGIN
			UPDATE #Auxiliar8
			SET Salidas = SUBSTRING(@P,1,100)
			WHERE IdValeSalida=@Corte
		  END
		SET @P=''
		SET @Corte=@IdValeSalida1
	  END
	IF NOT @Salida IS NULL
		IF PATINDEX('%'+@Salida+' '+'%', @P)=0
			SET @P=@P+@Salida+' '
	FETCH NEXT FROM Cur INTO @IdValeSalida1, @Salida
  END
IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar8
	SET Salidas = SUBSTRING(@P,1,100)
	WHERE IdValeSalida=@Corte
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111133'
SET @vector_T='069944092E725225200'

SELECT 
 ValesSalida.IdValeSalida,
 ValesSalida.NumeroValeSalida as [Numero de vale],
 ValesSalida.IdValeSalida as [IdAux],
 ValesSalida.NumeroValePreimpreso as [Nro.preimp.],
 ValesSalida.FechaValeSalida as [Fecha],
 Obras.NumeroObra as [Numero obra],
 e3.Nombre as [Aprobo],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Case When IsNull(ValesSalida.Cumplido,'NO')='SI' Then 'SI'
		When Exists(Select Top 1 Det.IdValeSalida From DetalleValesSalida Det Where Det.IdValeSalida=ValesSalida.IdValeSalida and IsNull(Det.Cumplido,'NO')='SI') Then 'PA'
		Else ValesSalida.Cumplido
 End as [Cumplido],
 #Auxiliar8.Salidas as [Salidas],
 ValesSalida.Observaciones as [Observaciones],
 e1.Nombre as [Anulo],
 ValesSalida.FechaAnulacion as [Fecha anulacion],
 ValesSalida.MotivoAnulacion as [Motivo anulacion],
 e2.Nombre as [Dio por cumplido],
 ValesSalida.FechaDioPorCumplido as [Fecha dio por cumplido],
 ValesSalida.MotivoDioPorCumplido as [Motivo dio por cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ValesSalida
LEFT OUTER JOIN Obras ON ValesSalida.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados e1 ON e1.IdEmpleado = ValesSalida.IdUsuarioAnulo
LEFT OUTER JOIN Empleados e2 ON e2.IdEmpleado = ValesSalida.IdUsuarioDioPorCumplido
LEFT OUTER JOIN Empleados e3 ON e3.IdEmpleado = ValesSalida.Aprobo
LEFT OUTER JOIN ArchivosATransmitirDestinos ON ValesSalida.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN #Auxiliar8 ON ValesSalida.IdValeSalida=#Auxiliar8.IdValeSalida
WHERE (ValesSalida.IdValeSalida=@IdValeSalida)

DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9
