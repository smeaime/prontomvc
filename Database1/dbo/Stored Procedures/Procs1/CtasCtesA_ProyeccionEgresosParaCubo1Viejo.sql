CREATE Procedure [dbo].[CtasCtesA_ProyeccionEgresosParaCubo1Viejo]

@FechaDesde datetime,
@Dts varchar(100) 

AS 

SET NOCOUNT ON

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
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_IdCondicionCompra INTEGER,
			 A_Coeficiente INTEGER,
			 A_Importe NUMERIC(15, 2),
			 A_Saldo NUMERIC(15, 2),
			 A_ImporteCuota NUMERIC(15, 2),
			 A_SaldoCuota NUMERIC(15, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdCtaCte,A_Fecha Desc) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaComprobante,CtaCte.Fecha)),
  Case When cp.FechaRecepcion is not null
	Then 'Ref. : '+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroReferencia)))+Convert(varchar,cp.NumeroReferencia)+' '+		Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)	Else Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  cp.IdCondicionCompra,
  1,
  CtaCte.ImporteTotal,
  CtaCte.Saldo,
  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,
  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON cp.IdCondicionCompra=Tmp.IdCondicionCompra
 WHERE TiposComprobante.Coeficiente=1 and CtaCte.Saldo<>0

UNION ALL

 SELECT 
  CtaCte.IdProveedor*-1,
  CtaCte.IdProveedor,
  @FechaDesde-1,
  '',
  Null,
  -1,
  SUM(CtaCte.ImporteTotal),
  SUM(CtaCte.Saldo),
  SUM(CtaCte.ImporteTotal),
  SUM(CtaCte.Saldo)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE TiposComprobante.Coeficiente=-1 and CtaCte.Saldo<>0
 GROUP BY CtaCte.IdProveedor

UPDATE #Auxiliar1
SET A_Fecha=CONVERT(datetime,@FechaDesde,103)
WHERE (#Auxiliar1.A_Fecha Is Null or #Auxiliar1.A_Fecha<=@FechaDesde) And #Auxiliar1.A_Importe>=0

/*  CURSOR  */
DECLARE @IdAux int, @IdCtaCte int, @SaldoCuota numeric(18,2), @Saldo numeric(18,2), @A_Fecha datetime,@Corte int, @SaldoAAplicar numeric(18,2)
SET @Corte=0
SET @SaldoAAplicar=0
DECLARE CtaCte CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_Saldo, A_SaldoCuota FROM #Auxiliar1 WHERE A_IdCtaCte>0 and A_Saldo<>0 ORDER BY A_IdCtaCte,A_Fecha Desc
OPEN CtaCte
FETCH NEXT FROM CtaCte INTO @IdCtaCte, @Saldo, @SaldoCuota
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Corte<>@IdCtaCte
		BEGIN
			SET @SaldoAAplicar=@Saldo
			SET @Corte=@IdCtaCte
		END
	IF @SaldoAAplicar>=@SaldoCuota
		SET @SaldoAAplicar=@SaldoAAplicar-@SaldoCuota
	ELSE
		BEGIN
			UPDATE #Auxiliar1
			SET A_SaldoCuota = @SaldoAAplicar
			WHERE CURRENT OF CtaCte
			SET @SaldoAAplicar=0
		END
	FETCH NEXT FROM CtaCte INTO @IdCtaCte, @Saldo, @SaldoCuota
END
CLOSE CtaCte
DEALLOCATE CtaCte

CREATE TABLE #Auxiliar2 
			(
			 A_IdProveedor INTEGER,
			 A_Saldo NUMERIC(15, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdProveedor) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT A_IdProveedor, Sum(IsNull(A_SaldoCuota * A_Coeficiente * -1,0))
 FROM #Auxiliar1
 GROUP BY A_IdProveedor

TRUNCATE TABLE _TempCuboProyeccionEgresos
INSERT INTO _TempCuboProyeccionEgresos 
 SELECT 
  #Auxiliar1.A_IdProveedor,
  Proveedores.RazonSocial,
  #Auxiliar1.A_Fecha,
  #Auxiliar1.A_SaldoCuota * #Auxiliar1.A_Coeficiente * -1,
  #Auxiliar1.A_Detalle
 FROM #Auxiliar1
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar1.A_IdProveedor
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.A_IdProveedor=#Auxiliar1.A_IdProveedor
 WHERE A_SaldoCuota<>0 and #Auxiliar2.A_Saldo<>0

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF