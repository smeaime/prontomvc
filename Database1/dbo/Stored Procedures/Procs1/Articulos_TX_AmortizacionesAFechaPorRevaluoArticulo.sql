
CREATE Procedure [dbo].[Articulos_TX_AmortizacionesAFechaPorRevaluoArticulo]

@FechaUltimoCalculo datetime,
@AFecha datetime,
@IdRevaluo int,
@IdArticulo int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdArticulo INTEGER,
			 Grupo VARCHAR(50),
			 Rubro VARCHAR(50),
			 FechaDetalleRevaluo DATETIME,
			 FechaRevaluo DATETIME,
			 ValorOrigenContable NUMERIC(19, 6),
			 Coeficiente1 NUMERIC(19, 6),
			 Coeficiente2 NUMERIC(19, 6),
			 Indice NUMERIC(19, 6),
			 PorcentajeAmortizacion NUMERIC(7, 3),
			 PorcentajeValorResidual NUMERIC(7, 3),
			 AltaBaja VARCHAR(1),
			 VidaUtilContable INTEGER,
			 VidaUtilContableTranscurrida INTEGER,
			 VidaUtilEjercicio INTEGER,
			 VidaUtilContableRestante INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Articulos.IdArticulo,
  GruposActivosFijos.Descripcion,
  Rubros.Descripcion,
  DetAFijos.Fecha,
  Revaluos.FechaRevaluo,
  IsNull(DetAFijos.ImporteRevaluo,0),
/*  Case When Revaluos.FechaRevaluo is null or 
		Revaluos.FechaRevaluo<@FechaUltimoCalculo
	Then (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(DateAdd(m,-1,@FechaUltimoCalculo)) and 
			CC.Mes=Month(DateAdd(m,-1,@FechaUltimoCalculo)))
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(Revaluos.FechaRevaluo) and 
			CC.Mes=Month(Revaluos.FechaRevaluo))
  End,  */
  Case When IsNull(Articulos.CalculaValorActualizado,'')='NO' Then 1
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC Where CC.Año=Year(Revaluos.FechaRevaluo) and CC.Mes=Month(Revaluos.FechaRevaluo))
  End,
  Case When IsNull(Articulos.CalculaValorActualizado,'')='NO' Then 1
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC Where CC.Año=Year(@AFecha) and CC.Mes=Month(@AFecha))
  End,
  1,
  Case When IsNull(DetAFijos.VidaUtilRevaluo,0)<>0 Then 12/DetAFijos.VidaUtilRevaluo Else 0 End,
  0,
  Case 	When DetAFijos.Fecha is not null and Year(DetAFijos.Fecha)=Year(@AFecha) Then 'A'
	When Articulos.FechaBajaAmortizacion is not null and Year(Articulos.FechaBajaAmortizacion)=Year(@AFecha) Then 'B'
	 Else ' '
  End,
  Case When IsNull(DetAFijos.VidaUtilRevaluo,0)<>0 Then DetAFijos.VidaUtilRevaluo Else 0 End,
  0,
  Case 	When IsNull(DetAFijos.Fecha,0)<@FechaUltimoCalculo Then DateDiff(m,@FechaUltimoCalculo,@AFecha) + 1
	When DetAFijos.Fecha>@AFecha Then 0
/*	Else DateDiff(m,DetAFijos.Fecha,@AFecha)+1	TOMAR TODO EL AÑO CUANDO SON ALTAS DEL PERIODO*/
	Else DateDiff(m,@FechaUltimoCalculo,@AFecha) + 1
  End,
  0
 FROM DetalleArticulosActivosFijos DetAFijos
 LEFT OUTER JOIN Revaluos ON DetAFijos.IdRevaluo=Revaluos.IdRevaluo
 LEFT OUTER JOIN Articulos ON DetAFijos.IdArticulo = Articulos.IdArticulo 
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
 LEFT OUTER JOIN GruposActivosFijos ON Articulos.IdGrupoActivoFijo = GruposActivosFijos.IdGrupoActivoFijo 
 WHERE DetAFijos.IdRevaluo is not null and DetAFijos.IdRevaluo=@IdRevaluo and DetAFijos.IdArticulo=@IdArticulo

UPDATE #Auxiliar1
SET PorcentajeValorResidual = 1-PorcentajeAmortizacion

UPDATE #Auxiliar1
SET Indice = Coeficiente2 / Coeficiente1
WHERE Coeficiente1 is not null and Coeficiente2 is not null and Coeficiente1<>0

UPDATE #Auxiliar1
SET VidaUtilEjercicio = 0
WHERE FechaDetalleRevaluo is not null and DateAdd(m,VidaUtilContable,FechaDetalleRevaluo)<@FechaUltimoCalculo

UPDATE #Auxiliar1
SET VidaUtilEjercicio = DateDiff(m,@FechaUltimoCalculo,DateAdd(m,VidaUtilContable,FechaDetalleRevaluo))
WHERE FechaDetalleRevaluo is not null and 
	DateAdd(m,VidaUtilContable,FechaDetalleRevaluo)>=@FechaUltimoCalculo and 
	DateAdd(m,VidaUtilContable,FechaDetalleRevaluo)<=@AFecha

UPDATE #Auxiliar1
SET VidaUtilEjercicio = 0
WHERE VidaUtilContable = 0

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = DateDiff(m,FechaDetalleRevaluo,@FechaUltimoCalculo)
WHERE FechaDetalleRevaluo is not null

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = VidaUtilContable
WHERE FechaDetalleRevaluo is null or 
	VidaUtilContableTranscurrida>VidaUtilContable

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = 0
WHERE VidaUtilContableTranscurrida<0

UPDATE #Auxiliar1
SET VidaUtilContableRestante = VidaUtilContable - VidaUtilContableTranscurrida - VidaUtilEjercicio


SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdArticulo,
 Grupo,
 Rubro,
 Articulos.Codigo,
 Articulos.NumeroInventario,
 Articulos.Descripcion as [Articulo],
 Articulos.CalculaAmortizacion,
 Articulos.FechaCompra,
 Sectores.Descripcion as [Sector],
 #Auxiliar1.FechaDetalleRevaluo,
 #Auxiliar1.FechaRevaluo,
 #Auxiliar1.ValorOrigenContable,
 #Auxiliar1.Indice,
 #Auxiliar1.PorcentajeAmortizacion,
 #Auxiliar1.PorcentajeValorResidual,
 #Auxiliar1.AltaBaja,
 #Auxiliar1.VidaUtilContable,
 #Auxiliar1.VidaUtilContableTranscurrida,
 #Auxiliar1.VidaUtilEjercicio,
 #Auxiliar1.VidaUtilContableRestante
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo 
LEFT OUTER JOIN Sectores ON Articulos.IdSector = Sectores.IdSector
ORDER BY Grupo,Rubro,[Articulo]

DROP TABLE #Auxiliar1
