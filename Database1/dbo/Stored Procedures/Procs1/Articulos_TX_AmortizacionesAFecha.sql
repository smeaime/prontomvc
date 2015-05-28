
CREATE Procedure [dbo].[Articulos_TX_AmortizacionesAFecha]

@FechaUltimoCalculo datetime,
@AFecha datetime,
@Contable_Impositivo varchar(1) = Null

AS

SET NOCOUNT ON

SET @Contable_Impositivo=IsNull(@Contable_Impositivo,'C')

CREATE TABLE #Auxiliar1
			(
			 IdArticulo INTEGER,
			 Grupo VARCHAR(50),
			 Rubro VARCHAR(50),
			 FechaPrimeraAmortizacionContable DATETIME,
			 ValorOrigenContable NUMERIC(19, 6),
			 UltimoRevaluo NUMERIC(19, 6),
			 FechaUltimoRevaluo DATETIME,
			 Coeficiente1 NUMERIC(19, 6),
			 Coeficiente2 NUMERIC(19, 6),
			 Indice NUMERIC(19, 6),
			 PorcentajeAmortizacion NUMERIC(7, 3),
			 PorcentajeValorResidual NUMERIC(7, 3),
			 AltaBaja VARCHAR(1),
			 VidaUtilContable INTEGER,
			 VidaUtilContableTranscurrida INTEGER,
			 VidaUtilEjercicio INTEGER,
			 VidaUtilEjercicioParaCalculo INTEGER,
			 VidaUtilContableRestante INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Articulos.IdArticulo,
  GruposActivosFijos.Descripcion,
  Rubros.Descripcion,
  Articulos.FechaPrimeraAmortizacionContable,
  IsNull(Articulos.ValorOrigenContable,0),
  Articulos.UltimoRevaluoContable,
  Articulos.FechaUltimoRevaluo,
/*(Select Top 1 DAAF.Importe 
	From DetalleArticulosActivosFijos DAAF
	Where DAAF.IdArticulo=Articulos.IdArticulo and DAAF.Fecha<=@AFecha and 
		DAAF.TipoConcepto='R'
	Order By DAAF.IdArticulo,DAAF.Fecha Desc),
  (Select Top 1 DAAF.Fecha 
	From DetalleArticulosActivosFijos DAAF
	Where DAAF.IdArticulo=Articulos.IdArticulo and DAAF.Fecha<=@AFecha and 
		DAAF.TipoConcepto='R'
	Order By DAAF.IdArticulo,DAAF.Fecha Desc),*/

/*  Case When Articulos.FechaPrimeraAmortizacionContable is null or 
		Articulos.FechaPrimeraAmortizacionContable<@FechaUltimoCalculo
	Then (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(DateAdd(m,-1,@FechaUltimoCalculo)) and 
			CC.Mes=Month(DateAdd(m,-1,@FechaUltimoCalculo)))
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(Articulos.FechaPrimeraAmortizacionContable) and 
			CC.Mes=Month(Articulos.FechaPrimeraAmortizacionContable))
  End, */

/*
  Case When Articulos.CalculaValorActualizado is not null and Articulos.CalculaValorActualizado='NO'
	Then 1
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(Articulos.FechaPrimeraAmortizacionContable) and 
			CC.Mes=Month(Articulos.FechaPrimeraAmortizacionContable))
  End,
*/

  Case When IsNull(Articulos.CalculaValorActualizado,'')='NO' Then 1
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(Articulos.FechaCompra) and CC.Mes=Month(Articulos.FechaCompra))
  End,
  Case When IsNull(Articulos.CalculaValorActualizado,'')='NO' Then 1
	Else (Select CC.CoeficienteActualizacion From CoeficientesContables CC
		Where CC.Año=Year(@AFecha) and CC.Mes=Month(@AFecha))
  End,
  1,
  Case When @Contable_Impositivo='C' Then Case When IsNull(Articulos.VidaUtilContable,0)<>0 Then 12/Articulos.VidaUtilContable Else 0 End
	Else Case When IsNull(Articulos.VidaUtilImpositiva,0)<>0 Then 12/Articulos.VidaUtilImpositiva Else 0 End End,
  0,
  Case 	When Articulos.FechaPrimeraAmortizacionContable is not null and Year(Articulos.FechaPrimeraAmortizacionContable)=Year(@AFecha) Then 'A'
	When Articulos.FechaBajaAmortizacion is not null and Year(Articulos.FechaBajaAmortizacion)=Year(@AFecha) Then 'B'
	 Else ' '
  End,
  Case When @Contable_Impositivo='C' Then IsNull(Articulos.VidaUtilContable,0) Else IsNull(Articulos.VidaUtilImpositiva,0) End,
  0,
  Case 	When IsNull(Articulos.FechaPrimeraAmortizacionContable,0)<@FechaUltimoCalculo Then DateDiff(m,@FechaUltimoCalculo,@AFecha)+1
	When Articulos.FechaPrimeraAmortizacionContable>@AFecha Then 0
	Else DateDiff(m,Articulos.FechaPrimeraAmortizacionContable,@AFecha)+1
  End,
  DateDiff(m,@FechaUltimoCalculo,@AFecha)+1,
  0
 FROM Articulos
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
 LEFT OUTER JOIN GruposActivosFijos ON Articulos.IdGrupoActivoFijo = GruposActivosFijos.IdGrupoActivoFijo 
 WHERE Articulos.ActivoFijo is not null and Articulos.ActivoFijo='SI' and 
	Not Exists(Select Top 1 DAAF.IdArticulo From DetalleArticulosActivosFijos DAAF
			Where DAAF.IdArticulo=Articulos.IdArticulo and DAAF.TipoConcepto='B' and DAAF.Fecha <= @AFecha)

UPDATE #Auxiliar1
SET PorcentajeValorResidual = 1-PorcentajeAmortizacion

UPDATE #Auxiliar1
SET Indice = Coeficiente2 / Coeficiente1
WHERE Coeficiente1 is not null and Coeficiente2 is not null and Coeficiente1<>0

UPDATE #Auxiliar1
SET VidaUtilEjercicio = 0, VidaUtilEjercicioParaCalculo=0
WHERE FechaPrimeraAmortizacionContable is not null and DateAdd(m,VidaUtilContable,FechaPrimeraAmortizacionContable)<@FechaUltimoCalculo

UPDATE #Auxiliar1
SET VidaUtilEjercicio = DateDiff(m,@FechaUltimoCalculo,DateAdd(m,VidaUtilContable,FechaPrimeraAmortizacionContable)),
	VidaUtilEjercicioParaCalculo = DateDiff(m,@FechaUltimoCalculo,DateAdd(m,VidaUtilContable,FechaPrimeraAmortizacionContable))
WHERE FechaPrimeraAmortizacionContable is not null and 
	DateAdd(m,VidaUtilContable,FechaPrimeraAmortizacionContable)>=@FechaUltimoCalculo and 
	DateAdd(m,VidaUtilContable,FechaPrimeraAmortizacionContable)<=@AFecha

UPDATE #Auxiliar1
SET VidaUtilEjercicio = 0, VidaUtilEjercicioParaCalculo = 0
WHERE VidaUtilContable = 0

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = DateDiff(m,FechaPrimeraAmortizacionContable,@FechaUltimoCalculo)
WHERE FechaPrimeraAmortizacionContable is not null

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = VidaUtilContable
WHERE FechaPrimeraAmortizacionContable is null or VidaUtilContableTranscurrida>VidaUtilContable

UPDATE #Auxiliar1
SET VidaUtilContableTranscurrida = 0
WHERE VidaUtilContableTranscurrida<0

UPDATE #Auxiliar1
SET VidaUtilContableRestante = VidaUtilContable - VidaUtilContableTranscurrida - VidaUtilEjercicio

UPDATE #Auxiliar1
SET UltimoRevaluo = 0
WHERE UltimoRevaluo is null


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
 #Auxiliar1.FechaPrimeraAmortizacionContable,
 #Auxiliar1.ValorOrigenContable,
 #Auxiliar1.UltimoRevaluo,
 #Auxiliar1.FechaUltimoRevaluo,
 #Auxiliar1.Indice,
 #Auxiliar1.PorcentajeAmortizacion,
 #Auxiliar1.PorcentajeValorResidual,
 #Auxiliar1.AltaBaja,
 #Auxiliar1.VidaUtilContable,
 #Auxiliar1.VidaUtilContableTranscurrida,
 #Auxiliar1.VidaUtilEjercicio,
 #Auxiliar1.VidaUtilEjercicioParaCalculo,
 #Auxiliar1.VidaUtilContableRestante
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo 
LEFT OUTER JOIN Sectores ON Articulos.IdSector = Sectores.IdSector
WHERE Articulos.FechaCompra<=@AFecha
ORDER BY Grupo,Rubro,[Articulo]

DROP TABLE #Auxiliar1
