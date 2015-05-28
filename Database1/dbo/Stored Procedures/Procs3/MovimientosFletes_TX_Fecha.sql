
CREATE Procedure [dbo].[MovimientosFletes_TX_Fecha]

@Desde datetime,
@Hasta datetime,
@Todos int = Null,
@IdMovimientoFlete int = Null

AS 

SET NOCOUNT ON

SET @Todos=IsNull(@Todos,0)
SET @IdMovimientoFlete=IsNull(@IdMovimientoFlete,-1)

CREATE TABLE #Auxiliar 
			(
			 IdMovimientoFlete INTEGER,
			 IdFlete INTEGER,
			 Fecha DATETIME,
			 Tipo VARCHAR(1),
			 Tiempo DATETIME, 
			 IdDispositivoGPS INTEGER,
			 Color INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar (IdFlete,Fecha,IdMovimientoFlete) ON [PRIMARY]
INSERT INTO #Auxiliar 
 SELECT IdMovimientoFlete, IdFlete, Fecha, Tipo, Null, IdDispositivoGPS, Null
 FROM MovimientosFletes 
 WHERE (@Todos=-1 or Fecha between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdMovimientoFlete=-1 or IdMovimientoFlete=@IdMovimientoFlete)

/*  CURSOR  */
DECLARE @IdMovimientoFlete1 int, @IdMovimientoFlete2 int, @IdFlete int, @Fecha datetime, @Tipo varchar(1), @TipoAnt varchar(1), 
	@Tiempo datetime, @FechaAnt datetime, @IdFleteAnt int, @IdDispositivoGPS int, @Color varchar(10)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdMovimientoFlete, IdFlete, Fecha, Tipo, Tiempo, IdDispositivoGPS
		FROM #Auxiliar
		ORDER BY IdFlete,Fecha,IdMovimientoFlete
OPEN Cur
FETCH NEXT FROM Cur INTO @IdMovimientoFlete1, @IdFlete, @Fecha, @Tipo, @Tiempo, @IdDispositivoGPS
SET @FechaAnt=0
SET @IdFleteAnt=0
WHILE @@FETCH_STATUS = 0
    BEGIN
	IF @IdFleteAnt<>@IdFlete
	    BEGIN
		SET @IdFleteAnt=@IdFlete
		SET @TipoAnt=''
		SET @IdMovimientoFlete2=0
	    END
	IF (@Tipo='C' and @TipoAnt='C') or (@Tipo='D' and @TipoAnt<>'C')
		UPDATE #Auxiliar
		SET Color = 12
		WHERE CURRENT OF Cur
	IF @Tipo='V' and @TipoAnt='C'
		UPDATE #Auxiliar
		SET Color = 9
		WHERE IdMovimientoFlete=@IdMovimientoFlete2
	IF @Tipo='D' and @TipoAnt='C' and @FechaAnt>0
		UPDATE #Auxiliar
		SET Tiempo = @Fecha-@FechaAnt
		WHERE CURRENT OF Cur
	SET @FechaAnt=@Fecha
	SET @TipoAnt=@Tipo
	SET @IdMovimientoFlete2=@IdMovimientoFlete1
	FETCH NEXT FROM Cur INTO @IdMovimientoFlete1, @IdFlete, @Fecha, @Tipo, @Tiempo, @IdDispositivoGPS
    END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111111111133'
SET @vector_T='039914H4H10HH2333682267900'

SELECT 
 mf.IdMovimientoFlete,
 Fletes.Patente as [Patente],
 mf.IdMovimientoFlete as [IdAux1],
 mf.IdPatronGPS as [IdAux2],
 mf.Touch as [Touch],
 mf.Fecha as [Fecha],
 Convert(varchar,mf.Fecha,108) as [Hora],
 Case When mf.Tipo='C' Then 'Carga' 
	When mf.Tipo='D' Then 'Descarga' 
	When mf.Tipo='V' Then 'Viaje' 
	Else Null 
 End as [Operacion],
 Convert(varchar,#Auxiliar.Tiempo,108) as [Tiempo],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 DispositivosGPS.Descripcion as [Dispositivo GPS],
 Fletes.Capacidad as [Capacidad],
 LecturasGPS.Latitud as [Latitud],
 LecturasGPS.Longitud as [Longitud],
 LecturasGPS.Altura as [Altura],
 mf.DistanciaRecorridaKm as [Dist.recorrida en km],
 Case When mf.Tipo='C' Then '' Else 
	Case When IsNull(mf.ModalidadFacturacion,0)=1 Then 'Por M3-Km'
		When IsNull(mf.ModalidadFacturacion,0)=2 Then 'Por Viaje'
		When IsNull(mf.ModalidadFacturacion,0)=3 Then 'Por Horas'
		Else ''
	End
 End as [Modalidad de facturacion],
 Case When mf.Tipo='C' Then Null Else mf.ValorUnitario End as [Valor Un.],
 Case When mf.Tipo='C' Then Null Else 
	Case When IsNull(mf.ModalidadFacturacion,0)=1 Then Fletes.Capacidad*mf.DistanciaRecorridaKm*mf.ValorUnitario
		When IsNull(mf.ModalidadFacturacion,0)=2 Then mf.ValorUnitario
		When IsNull(mf.ModalidadFacturacion,0)=3 Then Null
		Else Null
	End
 End as [A liquidar],
 mf.FechaUltimaModificacionManual as [Ult.Modif.Manual],
 mf.FechaLecturaArchivoMovimiento as [Ult.Lect.Arch.Mov.],
 #Auxiliar.Color as [Id_Color],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM MovimientosFletes mf 
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=mf.IdFlete
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
LEFT OUTER JOIN #Auxiliar ON #Auxiliar.IdMovimientoFlete=mf.IdMovimientoFlete
LEFT OUTER JOIN DispositivosGPS ON DispositivosGPS.IdDispositivoGPS=mf.IdDispositivoGPS
LEFT OUTER JOIN LecturasGPS ON LecturasGPS.IdLecturaGPS=mf.IdLecturaGPS
WHERE (@Todos=-1 or mf.Fecha between @Desde and DATEADD(n,1439,@Hasta)) and 
	(@IdMovimientoFlete=-1 or mf.IdMovimientoFlete=@IdMovimientoFlete)
ORDER BY Fletes.Patente, mf.Fecha

DROP TABLE #Auxiliar
