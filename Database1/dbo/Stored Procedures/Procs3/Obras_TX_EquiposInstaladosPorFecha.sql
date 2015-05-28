


CREATE  Procedure [dbo].[Obras_TX_EquiposInstaladosPorFecha]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdArticuloEquipo INTEGER,
			 IdObra INTEGER,
			 IdObraAnterior INTEGER,
			 FechaInstalacion DATETIME,
			 FechaDesinstalacion DATETIME
			)
INSERT INTO #Auxiliar1
SELECT
 Articulos.IdArticulo,
 Null,
 Null,
 Null,
 Null
FROM Articulos
WHERE IdRubro=14


CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticuloEquipo) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdArticuloEquipo int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY
	FOR
		SELECT IdArticuloEquipo
		FROM #Auxiliar1
		ORDER BY IdArticuloEquipo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdArticuloEquipo
WHILE @@FETCH_STATUS = 0
   BEGIN
	UPDATE #Auxiliar1
	SET 
		IdObra = (Select Top 1 doei.IdObra
				From DetalleObrasEquiposInstalados doei
				Where doei.IdArticulo=@IdArticuloEquipo and
					doei.FechaDesinstalacion is null
				Order By doei.FechaInstalacion Desc),
		FechaInstalacion = (Select Top 1 doei.FechaInstalacion
					From DetalleObrasEquiposInstalados doei
					Where doei.IdArticulo=@IdArticuloEquipo and
						doei.FechaDesinstalacion is null
					Order By doei.FechaInstalacion Desc),
		IdObraAnterior = (Select Top 1 doei.IdObra
				  From DetalleObrasEquiposInstalados doei
				  Where doei.IdArticulo=@IdArticuloEquipo and
					doei.FechaDesinstalacion is not null
				  Order By doei.FechaInstalacion Desc),
		FechaDesinstalacion = (Select Top 1 doei.FechaDesinstalacion
					From DetalleObrasEquiposInstalados doei
					Where doei.IdArticulo=@IdArticuloEquipo and
						doei.FechaDesinstalacion is not null
					Order By doei.FechaInstalacion Desc)
	WHERE CURRENT OF Cur

	FETCH NEXT FROM Cur INTO @IdArticuloEquipo
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111111133'
Set @vector_T='0C44444444400'

SELECT
 #Auxiliar1.IdArticuloEquipo,
 A1.Descripcion as [Equipo],
 A1.Codigo as [Nro de serie],
 A1.Datos1 as [Telefono],
 O1.NumeroObra as [Dominio actual],
 O1.IdObra as [Identificador],
 #Auxiliar1.FechaInstalacion as [Fecha Inst.],
 #Auxiliar1.FechaDesinstalacion as [Fecha Desinst.],
 C1.RazonSocial as [Cliente],
 O2.NumeroObra as [Dominio anterior],
 C2.RazonSocial as [Cliente anterior],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos A1 ON #Auxiliar1.IdArticuloEquipo=A1.IdArticulo
LEFT OUTER JOIN Obras O1 ON #Auxiliar1.IdObra=O1.IdObra
LEFT OUTER JOIN Clientes C1 ON O1.IdCliente=C1.IdCliente
LEFT OUTER JOIN Obras O2 ON #Auxiliar1.IdObraAnterior=O2.IdObra
LEFT OUTER JOIN Clientes C2 ON O2.IdCliente=C2.IdCliente
WHERE (#Auxiliar1.FechaInstalacion Between @FechaDesde And @FechaHasta) or 
	(#Auxiliar1.FechaDesinstalacion Between @FechaDesde And @FechaHasta)
ORDER BY A1.Descripcion

DROP TABLE #Auxiliar1


