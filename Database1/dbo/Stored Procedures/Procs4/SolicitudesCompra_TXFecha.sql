



CREATE  Procedure [dbo].[SolicitudesCompra_TXFecha]

@Desde datetime,
@Hasta datetime

AS 

SET NOCOUNT ON

/* REQUERIMIENTOS */
CREATE TABLE #Auxiliar0 
			(
			 IdSolicitudCompra INTEGER,
			 Requerimiento VARCHAR(100)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdSolicitudCompra INTEGER,
			 Requerimiento VARCHAR(13)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetSol.IdSolicitudCompra,
  Convert(varchar,Requerimientos.NumeroRequerimiento)
 FROM DetalleSolicitudesCompra DetSol
 LEFT OUTER JOIN SolicitudesCompra ON DetSol.IdSolicitudCompra = SolicitudesCompra.IdSolicitudCompra
 LEFT OUTER JOIN DetalleRequerimientos ON DetSol.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE (SolicitudesCompra.FechaSolicitud Between @Desde And @Hasta)

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdSolicitudCompra,Requerimiento) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT 
  IdSolicitudCompra,
  ''
 FROM #Auxiliar1
 GROUP BY IdSolicitudCompra

/*  CURSOR  */
DECLARE @IdSolicitudCompra int, @Requerimiento varchar(13), @P varchar(100), @Corte int
SET @Corte=0
SET @P=''
DECLARE SolReq CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT IdSolicitudCompra, Requerimiento
		FROM #Auxiliar1
		ORDER BY IdSolicitudCompra
OPEN SolReq
FETCH NEXT FROM SolReq
	INTO @IdSolicitudCompra, @Requerimiento

WHILE @@FETCH_STATUS = 0
 BEGIN
	IF @Corte<>@IdSolicitudCompra
	 BEGIN
		IF @Corte<>0
		 BEGIN
			UPDATE #Auxiliar0
			SET Requerimiento = SUBSTRING(@P,1,100)
			WHERE #Auxiliar0.IdSolicitudCompra=@Corte
		 END
		SET @P=''
		SET @Corte=@IdSolicitudCompra
	 END
	IF NOT @Requerimiento IS NULL
		IF PATINDEX('%'+@Requerimiento+' '+'%', @P)=0
			SET @P=@P+@Requerimiento+' '
	FETCH NEXT FROM SolReq
		INTO @IdSolicitudCompra, @Requerimiento
 END
 IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar0
	SET Requerimiento = SUBSTRING(@P,1,100)
	WHERE #Auxiliar0.IdSolicitudCompra=@Corte
  END
CLOSE SolReq
DEALLOCATE SolReq

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111133'
Set @vector_T='0494F000'

SELECT 
 SolicitudesCompra.IdSolicitudCompra,
 SolicitudesCompra.NumeroSolicitud as [Nro.solicitud],
 SolicitudesCompra.IdSolicitudCompra as [IdSol],
 SolicitudesCompra.FechaSolicitud as [Fecha],
 #Auxiliar0.Requerimiento as [RM's],
 Empleados.Nombre as [Confecciono],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SolicitudesCompra
LEFT OUTER JOIN Empleados ON SolicitudesCompra.Confecciono=Empleados.IdEmpleado
LEFT OUTER JOIN #Auxiliar0 ON SolicitudesCompra.IdSolicitudCompra=#Auxiliar0.IdSolicitudCompra
WHERE (SolicitudesCompra.FechaSolicitud Between @Desde And @Hasta)
ORDER BY NumeroSolicitud

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1



