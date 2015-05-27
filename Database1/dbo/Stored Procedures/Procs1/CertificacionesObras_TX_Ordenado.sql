CREATE Procedure [dbo].[CertificacionesObras_TX_Ordenado]

@NumeroProyecto int,
@Mes int, 
@Año int,
@TipoPartida int = Null

AS

SET NOCOUNT ON

SET @TipoPartida=IsNull(@TipoPartida,-1)

DECLARE @Profundidad int, @Nivel int, @Nivel1 int, @Pos int, @Orden varchar(50), @Orden1 varchar(50), @IdAux int, 
	@IdCertificacionObras int, @IdNodoPadre int, @Depth int, @Lineage varchar(255), @Cantidad numeric(18,2), 
	@Importe numeric(18,4), @Descripcion varchar(255), @IdUnidad int, @IdNodoHijo int, @Fecha datetime, @Item varchar(10)

SET @Profundidad=IsNull((Select Top 1 Max(IsNull(Depth,0)) From CertificacionesObras Where NumeroProyecto=@NumeroProyecto),0)
SET @Nivel=0
SET @Fecha=Convert(datetime,'1/'+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año),103)

CREATE TABLE #Auxiliar1 
			(
			 IdCertificacionObras INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 Descripcion VARCHAR(255),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,4),
			 IdUnidad INTEGER,
			 Item VARCHAR(10),
			 IdNodoHijo INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdNodoPadre, Item, IdCertificacionObras) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT CO.IdCertificacionObras, CO.IdNodoPadre, CO.Depth, CO.Lineage, CO.Descripcion, CO.Cantidad, CO.Importe, CO.IdUnidad, IsNull(CO.Item,''), 
	(Select Top 1 CO1.IdCertificacionObras From CertificacionesObras CO1
		Where CO1.NumeroProyecto=@NumeroProyecto and Patindex('%/'+Convert(varchar,CO.IdCertificacionObras)+'/%', CO1.Lineage)<>0)
 FROM CertificacionesObras CO
 WHERE CO.NumeroProyecto=@NumeroProyecto and (@TipoPartida=-1 or CO.TipoPartida=@TipoPartida)

CREATE TABLE #Auxiliar2 
			(
			 IdCertificacionObras INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 Descripcion VARCHAR(255),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,4),
			 IdUnidad INTEGER,
			 IdNodoHijo INTEGER,
			 Item VARCHAR(10),
			 Orden VARCHAR(50)
			)

WHILE @Nivel<=@Profundidad
    BEGIN
	SET @Pos=1
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdCertificacionObras, IdNodoPadre, Depth, Lineage, Descripcion, Cantidad, Importe, IdUnidad, IdNodoHijo, Item
			FROM #Auxiliar1
			WHERE Depth=@Nivel
			ORDER BY IdNodoPadre, Item, IdCertificacionObras
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo, @Item
	WHILE @@FETCH_STATUS = 0
	    BEGIN
		SET @Orden1=Substring('0000',1,4-Len(Convert(varchar,@Pos)))+Convert(varchar,@Pos)
		SET @IdAux=IsNull((Select Top 1 IdCertificacionObras From CertificacionesObras Where IdCertificacionObras=@IdNodoPadre),0)
		IF @IdAux=0 -- Nivel=0
		    BEGIN
			SET @Nivel1=@Nivel
			SET @Orden=@Orden1
			WHILE @Nivel1<=@Profundidad
			    BEGIN
				SET @Orden=@Orden+' 0000'
				SET @Nivel1=@Nivel1+1
			    END
		    END
		ELSE
		    BEGIN
			SET @Orden=IsNull((Select Top 1 Orden From #Auxiliar2 Where IdCertificacionObras=@IdAux),'')
			SET @Orden=Substring(@Orden,1,(@Nivel*5))+@Orden1+' '+Substring(@Orden,((@Nivel+1)*5)+1,50)
		    END

		INSERT INTO #Auxiliar2 
		 (IdCertificacionObras, IdNodoPadre, Depth, Lineage, Descripcion, Cantidad, Importe, IdUnidad, IdNodoHijo, Item, Orden)
		VALUES
		 (@IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo, @Item, @Orden)

		SET @Pos=@Pos+1
		FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo, @Item
	    END
	CLOSE Cur
	DEALLOCATE Cur
	SET @Nivel=@Nivel+1
    END

UPDATE #Auxiliar2
SET Cantidad=Null, Importe=Null
WHERE IdNodoHijo is not Null

SET NOCOUNT OFF

SELECT #Auxiliar2.*, Unidades.Abreviatura as [Unidad], 
	(Select Top 1 PxQ.CantidadAvance From CertificacionesObrasPxQ PxQ 
	 Where PxQ.IdCertificacionObras=#Auxiliar2.IdCertificacionObras and PxQ.Mes=@Mes and PxQ.Año=@Año and #Auxiliar2.IdNodoHijo is Null) as [CantidadMes],
	(Select Top 1 PxQ.ImporteAvance From CertificacionesObrasPxQ PxQ 
	 Where PxQ.IdCertificacionObras=#Auxiliar2.IdCertificacionObras and PxQ.Mes=@Mes and PxQ.Año=@Año and #Auxiliar2.IdNodoHijo is Null) as [ImportedMes],
	(Select Sum(IsNull(PxQ.CantidadAvance,0)) From CertificacionesObrasPxQ PxQ 
	 Where PxQ.IdCertificacionObras=#Auxiliar2.IdCertificacionObras and #Auxiliar2.IdNodoHijo is Null and 
		Convert(datetime,'1/'+Convert(varchar,PxQ.Mes)+'/'+Convert(varchar,PxQ.Año),103)<@Fecha) as [CantidadAcumuladaAnterior],
	(Select Sum(IsNull(PxQ.ImporteAvance,0)) From CertificacionesObrasPxQ PxQ 
	 Where PxQ.IdCertificacionObras=#Auxiliar2.IdCertificacionObras and #Auxiliar2.IdNodoHijo is Null and 
		Convert(datetime,'1/'+Convert(varchar,PxQ.Mes)+'/'+Convert(varchar,PxQ.Año),103)<@Fecha) as [ImporteAcumuladoAnterior]
FROM #Auxiliar2
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar2.IdUnidad
ORDER BY #Auxiliar2.Orden, #Auxiliar2.Item

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2