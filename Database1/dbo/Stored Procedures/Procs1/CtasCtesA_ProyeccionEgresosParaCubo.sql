CREATE Procedure [dbo].[CtasCtesA_ProyeccionEgresosParaCubo]

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
 Case When Proveedores.Saldo is null Then 0
	Else Proveedores.Saldo
 End
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 GROUP By CtaCte.IdProveedor,Proveedores.CodigoProveedor,Proveedores.RazonSocial,Proveedores.Saldo

UPDATE Proveedores
SET Saldo=0

UPDATE Proveedores
SET Saldo=(Select #Auxiliar0.Calculado From #Auxiliar0 Where #Auxiliar0.c_IdProveedor=Proveedores.IdProveedor)
WHERE (Select #Auxiliar0.Calculado-#Auxiliar0.Saldo 
	From #Auxiliar0 Where #Auxiliar0.c_IdProveedor=Proveedores.IdProveedor)<>0

UPDATE Proveedores
SET Saldo=0
WHERE Saldo is null


CREATE TABLE #Auxiliar1 
			(
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Importe NUMERIC(15, 2)
			)
INSERT INTO #Auxiliar1 
SELECT 
 cta.IdProveedor,
 Case When cta.FechaVencimiento is not null Then cta.FechaVencimiento Else cta.Fecha End,
 cta.Saldo*-1
FROM CuentasCorrientesAcreedores cta
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cta.IdTipoComp
WHERE TiposComprobante.Coeficiente=1

CREATE TABLE #Auxiliar2 (
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Importe NUMERIC(15, 2)
			)
INSERT INTO #Auxiliar2 
SELECT 
 #Auxiliar1.A_IdProveedor,
 #Auxiliar1.A_Fecha,
 SUM(#Auxiliar1.A_Importe)
FROM #Auxiliar1
GROUP BY  #Auxiliar1.A_IdProveedor,#Auxiliar1.A_Fecha

UNION ALL

SELECT 
 cta.IdProveedor,
 @FechaDesde-1,
 SUM(cta.Saldo)
FROM CuentasCorrientesAcreedores cta
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cta.IdTipoComp
WHERE TiposComprobante.Coeficiente=-1
GROUP BY  cta.IdProveedor


CREATE TABLE #Auxiliar3
		 	(
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Importe NUMERIC(15, 2)
			)
INSERT INTO #Auxiliar3 
SELECT 
 #Auxiliar2.A_IdProveedor,
 CASE WHEN (#Auxiliar2.A_Fecha Is Null or #Auxiliar2.A_Fecha<=@FechaDesde) And #Auxiliar2.A_Importe>=0
	THEN CONVERT(datetime,@FechaDesde,103)
	ELSE #Auxiliar2.A_Fecha
 END,
 #Auxiliar2.A_Importe
FROM #Auxiliar2


CREATE TABLE #Auxiliar4
		 	(
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Importe NUMERIC(15, 2)
			)
INSERT INTO #Auxiliar4 
SELECT 
 #Auxiliar3.A_IdProveedor,
 #Auxiliar3.A_Fecha,
 SUM(#Auxiliar3.A_Importe)
FROM #Auxiliar3
GROUP BY A_IdProveedor,A_Fecha


TRUNCATE TABLE _TempCuboProyeccionEgresos
INSERT INTO _TempCuboProyeccionEgresos 
SELECT 
 A_IdProveedor,
 Proveedores.RazonSocial,
 A_Fecha,
 A_Importe,
 Null
FROM #Auxiliar4
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=A_IdProveedor
WHERE A_Importe<>0 

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF