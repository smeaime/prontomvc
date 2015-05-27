CREATE Procedure [dbo].[SubcontratosDatos_CrearEtapasDesdePedidos]

@IdSubcontratoDatos int

AS 

SET NOCOUNT ON

DECLARE @NumeroSubcontrato int, @Item int, @TipoPartida int, @IdUnidad int, @Descripcion varchar(255), @Cantidad numeric(18,2), @Importe numeric(18,2), 
	@IdDetallePedido int, @IdPedido int, @NumeroPedido int, @NumeroItem int, @PrimerIdPedido int

SET @NumeroSubcontrato=IsNull((Select Top 1 NumeroSubcontrato From SubcontratosDatos Where IdSubcontratoDatos=@IdSubcontratoDatos),0)
SET @PrimerIdPedido=IsNull((Select Top 1 IdPedido From DetalleSubcontratosDatosPedidos Where IdSubcontratoDatos=@IdSubcontratoDatos),0)

CREATE TABLE #Auxiliar1 (IdPedido INTEGER)
INSERT INTO #Auxiliar1
 SELECT IdPedido
 FROM DetalleSubcontratosDatosPedidos 
 WHERE IdSubcontratoDatos=@IdSubcontratoDatos

CREATE TABLE #Auxiliar2	(
			 IdDetallePedido INTEGER,
			 IdPedido INTEGER,
			 NumeroPedido INTEGER,
			 NumeroItem INTEGER,
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Descripcion VARCHAR(255),
			 DescripcionArticulo VARCHAR(255)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (NumeroPedido, NumeroItem) ON [PRIMARY]
INSERT INTO #Auxiliar2
 SELECT Det.IdDetallePedido, Det.IdPedido, Pedidos.NumeroPedido, Det.NumeroItem, Det.Cantidad, Det.Precio*IsNull(Pedidos.CotizacionMoneda,1), 
	Det.IdUnidad, Ltrim(IsNull(Convert(varchar(255),Det.Observaciones),'')), IsNull(Articulos.Descripcion,'')+' '+Convert(varchar,Det.NumeroItem)
 FROM DetallePedidos Det 
 LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = Det.IdPedido
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Det.IdArticulo
 WHERE Det.IdPedido In (Select IdPedido From #Auxiliar1)

UPDATE #Auxiliar2
SET Descripcion=DescripcionArticulo
WHERE LEN(Descripcion)=0


/*  CURSOR  */
SET @Item=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido, IdPedido, NumeroPedido, NumeroItem, Cantidad, Importe, IdUnidad, Descripcion 
					  FROM #Auxiliar2 ORDER BY NumeroPedido, NumeroItem
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetallePedido, @IdPedido, @NumeroPedido, @NumeroItem, @Cantidad, @Importe, @IdUnidad, @Descripcion 
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @Item=@Item+1

	IF @IdPedido=@PrimerIdPedido
		SET @TipoPartida=1
	ELSE
		SET @TipoPartida=2

	IF Not Exists(Select Top 1 IdSubcontrato From Subcontratos Where NumeroSubcontrato=@NumeroSubcontrato and Descripcion=@Descripcion)
	   BEGIN
		SET @Item=IsNull((Select Max(Convert(integer,Item)) From Subcontratos Where NumeroSubcontrato=@NumeroSubcontrato),0)+1
		INSERT INTO [Subcontratos]
		(Depth, Lineage, TipoNodo, Descripcion, TipoPartida, IdUnidad, UnidadAvance, Cantidad, Importe, NumeroSubcontrato, Item)
		VALUES
		(0, '/', 3, @Descripcion, @TipoPartida, @IdUnidad, 'U', @Cantidad, @Importe, @NumeroSubcontrato, @Item)
	   END

	FETCH NEXT FROM Cur INTO @IdDetallePedido, @IdPedido, @NumeroPedido, @NumeroItem, @Cantidad, @Importe, @IdUnidad, @Descripcion 
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

SET NOCOUNT OFF