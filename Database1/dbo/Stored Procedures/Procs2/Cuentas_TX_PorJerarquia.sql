CREATE Procedure [dbo].[Cuentas_TX_PorJerarquia]

@Seleccion int,
@FechaConsulta datetime = Null

AS 

SET NOCOUNT ON

DECLARE @BasePRONTOConsolidacion varchar(50), @BasePRONTOConsolidacion2 varchar(50), 	@BasePRONTOConsolidacion3 varchar(50), @sql1 nvarchar(4000), @Filtrado int

SET @BasePRONTOConsolidacion=IsNull((Select Top 1 BasePRONTOConsolidacion From Parametros Where IdParametro=1),'')
SET @BasePRONTOConsolidacion2=IsNull((Select Top 1 BasePRONTOConsolidacion2 From Parametros Where IdParametro=1),'')
SET @BasePRONTOConsolidacion3=IsNull((Select Top 1 BasePRONTOConsolidacion3 From Parametros Where IdParametro=1),'')
SET @Filtrado=0
SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

IF not @FechaConsulta is null 
	SET @Filtrado=1

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 CodigoCuenta1 INTEGER,
			 Descripcion1 VARCHAR(50),
			 CodigoCuenta2 INTEGER,
			 Descripcion2 VARCHAR(50),
			 CodigoCuenta3 INTEGER,
			 Descripcion3 VARCHAR(50)
			)
IF Len(@BasePRONTOConsolidacion)>0
   BEGIN
	SET @sql1='Select C1.IdCuenta, C2.Codigo, C2.Descripcion, Null, Null, Null, Null 
			From Cuentas C1
			Left Outer Join '+@BasePRONTOConsolidacion+'.dbo.Cuentas C2 On C1.IdCuentaConsolidacion=C2.IdCuenta'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END
IF Len(@BasePRONTOConsolidacion2)>0
   BEGIN
	SET @sql1='Select C1.IdCuenta, Null, Null, C2.Codigo, C2.Descripcion, Null, Null 
			From Cuentas C1
			Left Outer Join '+@BasePRONTOConsolidacion2+'.dbo.Cuentas C2 On C1.IdCuentaConsolidacion2=C2.IdCuenta'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END
IF Len(@BasePRONTOConsolidacion3)>0
   BEGIN
	SET @sql1='Select C1.IdCuenta, Null, Null, Null, Null, C2.Codigo, C2.Descripcion 
			From Cuentas C1
			Left Outer Join '+@BasePRONTOConsolidacion3+'.dbo.Cuentas C2 On C1.IdCuentaConsolidacion3=C2.IdCuenta'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END

CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 CodigoCuenta1 INTEGER,
			 Descripcion1 VARCHAR(50),
			 CodigoCuenta2 INTEGER,
			 Descripcion2 VARCHAR(50),
			 CodigoCuenta3 INTEGER,
			 Descripcion3 VARCHAR(50)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdCuenta, 
	Max(IsNull(#Auxiliar1.CodigoCuenta1,0)), Max(IsNull(#Auxiliar1.Descripcion1,'')), 
	Max(IsNull(#Auxiliar1.CodigoCuenta2,0)), Max(IsNull(#Auxiliar1.Descripcion2,'')), 
	Max(IsNull(#Auxiliar1.CodigoCuenta3,0)), Max(IsNull(#Auxiliar1.Descripcion3,''))
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdCuenta

CREATE TABLE #Auxiliar3
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(100),
			 Jerarquia VARCHAR(20),
			 CodigoCuentaMadre INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT Cuentas.IdCuenta, 
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo),
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Descripcion),
	IsNull((Select Top 1 dc.JerarquiaAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Jerarquia),
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=CuentasGastos.IdCuentaMadre and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),(Select Top 1 C.Codigo From Cuentas C Where C.IdCuenta=CuentasGastos.IdCuentaMadre))
 FROM Cuentas
 LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 WHERE (@Seleccion=-1 or 
	(@Seleccion=0 and Substring(IsNull(Cuentas.Jerarquia,'0'),1,1)<=5) or 
	(@Seleccion>0 and IsNull(Obras.IdUnidadOperativa,0)=@Seleccion))  

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111133'
SET @vector_T='0191132213243231313100'

SELECT 
 Cuentas.IdCuenta,
 #Auxiliar3.Descripcion as [Descripcion],
 Cuentas.IdCuenta as [IdAux],
 #Auxiliar3.Codigo as [Codigo],
 TiposCuenta.Descripcion as [Tipo de cuenta],
 #Auxiliar3.Jerarquia as [Jerarquia],
 rc1.Descripcion as [Rubro contable],
 rc2.Descripcion as [Rubro financiero],
 TiposCuentaGrupos.Descripcion as [Grupo cuenta],
 #Auxiliar3.CodigoCuentaMadre as [Cod.Cta.Madre],
 CuentasGastos.Descripcion as [Grupo gasto],
 Obras.Descripcion as [Obra / Centro de costo],
 Cuentas.AjustaPorInflacion as [Ajusta p/inf.],
 Cuentas.CodigoSecundario as [Codigo secundario],
 Case When IsNull(#Auxiliar2.CodigoCuenta1,0)<>0 Then #Auxiliar2.CodigoCuenta1 Else Null End as [Cod.Cons.1],
 #Auxiliar2.Descripcion1 as [Cta.Cons.1],
 Case When IsNull(#Auxiliar2.CodigoCuenta2,0)<>0 Then #Auxiliar2.CodigoCuenta2 Else Null End as [Cod.Cons.2],
 #Auxiliar2.Descripcion2 as [Cta.Cons.2],
 Case When IsNull(#Auxiliar2.CodigoCuenta3,0)<>0 Then #Auxiliar2.CodigoCuenta3 Else Null End as [Cod.Cons.3],
 #Auxiliar2.Descripcion3 as [Cta.Cons.3],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Cuentas 
LEFT OUTER JOIN TiposCuenta ON TiposCuenta.IdTipoCuenta=Cuentas.IdTipoCuenta
LEFT OUTER JOIN RubrosContables rc1 ON rc1.IdRubroContable=Cuentas.IdRubroContable
LEFT OUTER JOIN RubrosContables rc2 ON rc2.IdRubroContable=Cuentas.IdRubroFinanciero
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdCuenta=Cuentas.IdCuenta
WHERE 
	(@Seleccion=-1 or 
	 (@Seleccion=0 and Substring(IsNull(Cuentas.Jerarquia,'0'),1,1)<=5) or 
	 (@Seleccion>0 and IsNull(Obras.IdUnidadOperativa,0)=@Seleccion)) and 

	Not (Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),'S/D'))=0 ) and 

	(Len(IsNull(Cuentas.Descripcion,''))>0 or 
	 (Len(IsNull(Cuentas.Descripcion,''))=0 and 
	  Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),''))>0)) and 

	(@Filtrado=0 or Obras.FechaInicio is null or (@Filtrado=1 and Obras.FechaInicio<=@FechaConsulta))

ORDER BY Cuentas.Jerarquia

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3