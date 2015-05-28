CREATE Procedure [dbo].[Proveedores_TX_RankingCompras]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato int = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,0)

CREATE TABLE #Auxiliar1 	
			(
			 IdAux INTEGER IDENTITY (1, 1),
			 IdProveedor INTEGER,
			 NumeroOrden INTEGER,
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 TotalSinImpuestos NUMERIC(18,2),
			 PorcentajeParcial NUMERIC(18,3),
			 PorcentajeAcumulado NUMERIC(18,2),
			 CodigoESRI VARCHAR(10)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  cp.IdProveedor,
  0,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  Sum(cp.TotalBruto*cp.CotizacionMoneda*TiposComprobante.Coeficiente),
  0,
  0,
  IsNull(Paises.CodigoESRI,'00')+'.'+IsNull(Provincias.CodigoESRI,'00')+'.'+IsNull(Localidades.CodigoESRI,'00')
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Paises ON Paises.IdPais=Proveedores.IdPais
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Proveedores.IdProvincia
 LEFT OUTER JOIN Localidades ON Localidades.IdLocalidad=Proveedores.IdLocalidad
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and cp.IdProveedor is not null
 GROUP BY cp.IdProveedor, Proveedores.CodigoEmpresa, Proveedores.RazonSocial, Paises.CodigoESRI, Provincias.CodigoESRI, Localidades.CodigoESRI

DECLARE @TotalGeneral numeric(18,2), @Acumulado numeric(18,3), @IdAux int, @PorcentajeParcial numeric(18,3), @NumeroOrden int, @TotalSinImpuestos numeric(18,2)

SET @NumeroOrden=0
SET @Acumulado=0
SET @TotalGeneral=(Select Sum(TotalSinImpuestos) From #Auxiliar1)
IF @TotalGeneral>0
	UPDATE #Auxiliar1 SET PorcentajeParcial=ROUND(TotalSinImpuestos/@TotalGeneral*100,3)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdAux, PorcentajeParcial, TotalSinImpuestos FROM #Auxiliar1 ORDER BY TotalSinImpuestos Desc, IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @IdAux, @PorcentajeParcial, @TotalSinImpuestos
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @NumeroOrden=@NumeroOrden+1
	SET @Acumulado=@Acumulado+@PorcentajeParcial
	UPDATE #Auxiliar1 SET NumeroOrden=@NumeroOrden, PorcentajeAcumulado=Round(@Acumulado,2) WHERE IdAux=@IdAux
	FETCH NEXT FROM Cur INTO @IdAux, @PorcentajeParcial, @TotalSinImpuestos
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00111111133'
SET @vector_T='00217522900'

IF @Formato=0
    BEGIN
	SELECT 
		0 as [IdProveedor],
		1 as [K_Orden],
		NumeroOrden as [Ranking],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		TotalSinImpuestos as [Total s/impuestos],
		PorcentajeParcial as [%],
		PorcentajeAcumulado as [% Acum.],
		CodigoESRI as [CodigoESRI],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	UNION ALL 
	
	SELECT 
		0 as [IdProveedor],
		2 as [K_Orden],
		Null as [Ranking],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Total s/impuestos],
		Null as [%],
		Null as [% Acum.],
		Null as [CodigoESRI],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	
	UNION ALL 
	
	SELECT 
		0 as [IdProveedor],
		3 as [K_Orden],
		Null as [Ranking],
		Null as [Codigo],
		'TOTAL' as [Proveedor],
		SUM(TotalSinImpuestos) as [Total s/impuestos],
		Null as [%],
		Null as [% Acum.],
		Null as [CodigoESRI],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	ORDER BY [K_Orden], [Total s/impuestos] DESC
    END

IF @Formato=1
    BEGIN
	SELECT 
		0 as [IdProveedor],
		1 as [K_Orden],
		NumeroOrden as [Ranking],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		TotalSinImpuestos as [Total s/impuestos],
		PorcentajeParcial as [%],
		PorcentajeAcumulado as [% Acum.],
		CodigoESRI as [CodigoESRI],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	ORDER BY [K_Orden], [Total s/impuestos] DESC
    END

DROP TABLE #Auxiliar1