CREATE Procedure [dbo].[CtasCtesA_ProyeccionEgresosParaCubo1]

@FechaDesde datetime,
@Dts varchar(100) 

AS 

SET NOCOUNT ON

DECLARE @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, @IdProveedor1 int, @IdProveedor2 int, @IdProveedorAnt int, 
	@SaldoCuota1 numeric(18,2), @SaldoCuota2 numeric(18,2), @ImporteCuota1 numeric(18,2), @ImporteCuota2 numeric(18,2), @A_Fecha datetime, @SaldoAAplicar numeric(18,2), 
	@SaldoAplicado numeric(18,2), @Diferencia numeric(18,2), @IdAux int, @A_Id int

CREATE TABLE #Auxiliar0 
			(
			 c_IdProveedor INTEGER,
			 Proveedor VARCHAR(50),
			 Calculado NUMERIC(12,2),
			 Saldo NUMERIC(12,2)
			)
INSERT INTO #Auxiliar0 
SELECT  
 CtaCte.IdProveedor,
 Proveedores.RazonSocial,
 Sum(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1),
 Case When Proveedores.Saldo is null Then 0 Else Proveedores.Saldo End
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 GROUP By CtaCte.IdProveedor,Proveedores.CodigoProveedor,Proveedores.RazonSocial,Proveedores.Saldo

UPDATE Proveedores
SET Saldo=0

UPDATE Proveedores
SET Saldo=(Select #Auxiliar0.Calculado From #Auxiliar0 Where #Auxiliar0.c_IdProveedor=Proveedores.IdProveedor)
WHERE (Select #Auxiliar0.Calculado-#Auxiliar0.Saldo From #Auxiliar0 Where #Auxiliar0.c_IdProveedor=Proveedores.IdProveedor)<>0

UPDATE Proveedores
SET Saldo=0
WHERE Saldo is null


CREATE TABLE #Auxiliar1 
			(
			 A_Id INTEGER IDENTITY (1, 1),
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_IdImputacion INTEGER,
			 A_IdCondicionCompra INTEGER,
			 A_Coeficiente INTEGER,
			 A_ImporteCuota NUMERIC(15, 3),
			 A_SaldoCuota NUMERIC(15, 3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdImputacion, A_Fecha, A_Id) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (A_Id) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaComprobante,CtaCte.Fecha)),
  Case When cp.FechaRecepcion is not null
	Then 'Ref. : '+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroReferencia)))+Convert(varchar,cp.NumeroReferencia)+' '+		Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)	Else Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  IsNull(CtaCte.IdImputacion,0),
  cp.IdCondicionCompra,
  1,
  Round(CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,3),
  Round(CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,3)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON cp.IdCondicionCompra=Tmp.IdCondicionCompra
 WHERE TiposComprobante.Coeficiente=1

CREATE TABLE #Auxiliar2 
			(
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_IdImputacion INTEGER,
			 A_IdCondicionCompra INTEGER,
			 A_Coeficiente INTEGER,
			 A_ImporteCuota NUMERIC(15, 3),
			 A_SaldoCuota NUMERIC(15, 3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar2 (A_IdImputacion, A_Fecha) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  @FechaDesde-1,
  Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),
  IsNull(CtaCte.IdImputacion,0),
  Null,
  -1,
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE TiposComprobante.Coeficiente=-1

UPDATE #Auxiliar1
SET A_Fecha=CONVERT(datetime,@FechaDesde,103)
WHERE (#Auxiliar1.A_Fecha Is Null or #Auxiliar1.A_Fecha<=@FechaDesde) And #Auxiliar1.A_ImporteCuota>=0

DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
		FROM #Auxiliar2
		WHERE A_SaldoCuota<>0 and A_IdImputacion<>0
		ORDER BY A_IdImputacion, A_Fecha 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoAAplicar=@SaldoCuota1
	SET @IdImputacionAnt=@IdImputacion1
	SET @IdProveedorAnt=@IdProveedor1

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT A_Id, A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
			FROM #Auxiliar1
			WHERE A_SaldoCuota<>0 and A_IdImputacion=@IdImputacionAnt and A_IdProveedor=@IdProveedorAnt
			ORDER BY A_IdImputacion, A_Fecha, A_Id
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @A_Id, @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	   BEGIN
		IF @SaldoAAplicar>=@SaldoCuota2
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@SaldoCuota2
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@SaldoCuota2-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		UPDATE #Auxiliar1
		SET A_SaldoCuota = @SaldoAplicado
		WHERE A_Id = @A_Id     --CURRENT OF CtaCte2

		FETCH NEXT FROM CtaCte2	INTO @A_Id, @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
	   END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	BEGIN
		UPDATE #Auxiliar2
		SET A_SaldoCuota = @SaldoAAplicar
		WHERE A_IdCtaCte = @IdCtaCte1     --CURRENT OF CtaCte1
	END
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

INSERT INTO #Auxiliar1 
 SELECT 
  0,
  A_IdProveedor,
  Null,
  'Creditos no aplicados',
  Null,
  Null,
  -1,
  Null,
  Sum(IsNull(A_SaldoCuota,0))
 FROM #Auxiliar2
 GROUP BY A_IdProveedor

CREATE TABLE #Auxiliar3 
			(
			 A_IdProveedor INTEGER,
			 A_Saldo NUMERIC(15, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (A_IdProveedor) ON [PRIMARY]
INSERT INTO #Auxiliar3 
 SELECT A_IdProveedor, Sum(IsNull(A_SaldoCuota * A_Coeficiente * -1,0))
 FROM #Auxiliar1
 GROUP BY A_IdProveedor

TRUNCATE TABLE _TempCuboProyeccionEgresos
INSERT INTO _TempCuboProyeccionEgresos 
 SELECT 
  #Auxiliar1.A_IdProveedor,
  Proveedores.RazonSocial,
  #Auxiliar1.A_Fecha,
  Sum(#Auxiliar1.A_SaldoCuota * #Auxiliar1.A_Coeficiente * -1),
  #Auxiliar1.A_Detalle
 FROM #Auxiliar1
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar1.A_IdProveedor
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdProveedor=#Auxiliar1.A_IdProveedor
 WHERE A_SaldoCuota<>0 and #Auxiliar3.A_Saldo<>0
 GROUP BY #Auxiliar1.A_IdProveedor, Proveedores.RazonSocial, #Auxiliar1.A_Fecha, #Auxiliar1.A_Detalle

--select * from #Auxiliar1 where A_IdProveedor=894 order by A_IdImputacion
--select * from #Auxiliar2 where A_IdProveedor=894 order by A_IdImputacion

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF