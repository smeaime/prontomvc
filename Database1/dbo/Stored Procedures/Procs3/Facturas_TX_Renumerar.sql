CREATE  Procedure [dbo].[Facturas_TX_Renumerar]

@IdsFacturas varchar(4000),
@NumeroInicial int

AS 

SET NOCOUNT ON

DECLARE @IdFactura int, @TipoABC varchar(1), @PuntoVenta int, @Numero int, @NuevoNumero int, @RegistrosConError int, @PuntoVentaAProcesar int

CREATE TABLE #Auxiliar1 
			(
			 IdFactura INTEGER,
			 TipoABC VARCHAR(1),
			 PuntoVenta INTEGER,
			 Numero INTEGER,
			 NuevoNumero INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdFactura) ON [PRIMARY]

CREATE TABLE #Auxiliar9 
			(
			 Resultado VARCHAR(100)
			)

INSERT INTO #Auxiliar1
 SELECT IdFactura, TipoABC, PuntoVenta, NumeroFactura, 0
 FROM Facturas 
 WHERE Patindex('%('+Convert(varchar,IdFactura)+')%', @IdsFacturas)<>0

SET @NuevoNumero=@NumeroInicial
SET @PuntoVentaAProcesar=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdFactura, TipoABC, PuntoVenta, Numero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, Numero
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura, @TipoABC, @PuntoVenta, @Numero
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @PuntoVentaAProcesar=0
		SET @PuntoVentaAProcesar=@PuntoVenta

	UPDATE #Auxiliar1
	SET NuevoNumero=@NuevoNumero
	WHERE IdFactura=@IdFactura
	
	IF Exists(Select Top 1 IdFactura From Facturas Where TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroFactura=@NuevoNumero and IdFactura<>@IdFactura)
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La factura original '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' no puede renumerarse a la '+@TipoABC+' '+
		 Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@NuevoNumero)))+Convert(varchar,@NuevoNumero)+' porque ya existe.'
		 )
		
	IF Len(IsNull((Select Top 1 CAE From Facturas Where IdFactura=@IdFactura),''))>0
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La factura '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' tiene CAE y no puede formar parte de la renumeracion.'
		 )
		
	IF @PuntoVentaAProcesar<>@PuntoVenta and @PuntoVentaAProcesar<>-1
	  BEGIN
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('En el grupo de factura elegidas para renumeracion hay puntos de venta distintos' )
		SET @PuntoVentaAProcesar=-1
	  END

	SET @NuevoNumero=@NuevoNumero+1

	FETCH NEXT FROM Cur INTO @IdFactura, @TipoABC, @PuntoVenta, @Numero
  END
CLOSE Cur
DEALLOCATE Cur

SET @RegistrosConError=IsNull((Select Count(*) From #Auxiliar9),0)

IF @RegistrosConError=0
  BEGIN
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdFactura, TipoABC, PuntoVenta, Numero, NuevoNumero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, NuevoNumero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdFactura, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		UPDATE Facturas
		SET NumeroFactura=@NuevoNumero
		WHERE IdFactura=@IdFactura
		
		UPDATE CuentasCorrientesDeudores
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComp=1 and IdComprobante=@IdFactura
		
		UPDATE Subdiarios
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComprobante=1 and IdComprobante=@IdFactura

		FETCH NEXT FROM Cur INTO @IdFactura, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

SET NOCOUNT OFF

SELECT 0 as [Id],* FROM #Auxiliar9

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar9
