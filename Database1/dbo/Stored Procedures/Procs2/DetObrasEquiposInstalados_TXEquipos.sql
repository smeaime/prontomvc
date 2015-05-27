CREATE PROCEDURE [dbo].[DetObrasEquiposInstalados_TXEquipos]

@IdObra int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleObraEquipoInstalado INTEGER,
			 IdSubequipo1 INTEGER,
			 IdSubequipo2 INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleObraEquipoInstalado) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT doei.IdDetalleObraEquipoInstalado, Null, Null
 FROM DetalleObrasEquiposInstalados doei
 WHERE doei.IdObra=@IdObra

DECLARE @IdDetalleObraEquipoInstalado int, @IdSubequipo1 int, @IdSubequipo2 int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleObraEquipoInstalado FROM #Auxiliar1 ORDER BY IdDetalleObraEquipoInstalado 
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleObraEquipoInstalado
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @IdSubequipo1=IsNull((Select Top 1 IdArticulo From DetalleObrasEquiposInstalados2 Where IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado and FechaDesinstalacion is null),0)
	IF @IdSubequipo1<>0
	    BEGIN
		UPDATE #Auxiliar1
		SET IdSubequipo1=@IdSubequipo1
		WHERE IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado

		SET @IdSubequipo2=IsNull((Select Top 1 IdArticulo From DetalleObrasEquiposInstalados2 Where IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado and FechaDesinstalacion is null and IdArticulo<>@IdSubequipo1),0)
		IF @IdSubequipo2<>0
			UPDATE #Auxiliar1
			SET IdSubequipo2=@IdSubequipo2
			WHERE IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado
	    END
	FETCH NEXT FROM Cur INTO @IdDetalleObraEquipoInstalado
    END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='04C02255500'

SELECT
 DetEI.IdDetalleObraEquipoInstalado,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Equipo],
 DetEI.Cantidad as [Cant.],
 (Select Top 1 Codigo From Articulos Where Articulos.IdArticulo=#Auxiliar1.IdSubequipo1) as [Subequipo 1],
 (Select Top 1 Codigo From Articulos Where Articulos.IdArticulo=#Auxiliar1.IdSubequipo2) as [Subequipo 2],
 DetEI.FechaInstalacion as [Fecha Inst.],
 DetEI.FechaDesinstalacion as [Fecha Desinst.],
 DetEI.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasEquiposInstalados DetEI
LEFT OUTER JOIN Articulos ON DetEI.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetalleObraEquipoInstalado=DetEI.IdDetalleObraEquipoInstalado
WHERE (DetEI.IdObra = @IdObra)
ORDER by Articulos.NumeroInventario

DROP TABLE #Auxiliar1