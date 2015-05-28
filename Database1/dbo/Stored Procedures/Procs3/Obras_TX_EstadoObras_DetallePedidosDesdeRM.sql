
CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_DetallePedidosDesdeRM]

@IdDetalleRequerimiento as int

AS 

SET NOCOUNT ON

DECLARE @IdPedido int, @IdAutorizo int, @FechaAutorizacion datetime, @OrdenAutorizacion int, 
	@Corte int, @A1 varchar(100), @A2 varchar(100), @Autorizo varchar(6)

CREATE TABLE #Auxiliar1 (
			 IdPedido INTEGER,
			 IdAutorizo INTEGER,
			 Autorizo VARCHAR(6),
			 FechaAutorizacion DATETIME,
			 OrdenAutorizacion INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPedido,OrdenAutorizacion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT DISTINCT Det.IdPedido, apc.IdAutorizo, IsNull(Empleados.Iniciales,'???'), 
		 apc.FechaAutorizacion, apc.OrdenAutorizacion
 FROM DetallePedidos Det
 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN AutorizacionesPorComprobante apc ON Det.IdPedido = apc.IdComprobante and apc.IdFormulario=4
 LEFT OUTER JOIN Empleados ON apc.IdAutorizo = Empleados.IdEmpleado
 WHERE Det.IdDetalleRequerimiento=@IdDetalleRequerimiento and apc.IdAutorizo is not null and 
	IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN'

CREATE TABLE #Auxiliar2 (
			 IdPedido INTEGER,
			 Autorizaciones VARCHAR(100),
			 Fechas VARCHAR(100)
			)
SET @Corte=0
SET @A1=''
SET @A2=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdPedido, IdAutorizo, Autorizo, FechaAutorizacion, OrdenAutorizacion
		FROM #Auxiliar1
		ORDER BY IdPedido, OrdenAutorizacion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPedido, @IdAutorizo, @Autorizo, @FechaAutorizacion, @OrdenAutorizacion
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdPedido
	   BEGIN
		IF @Corte<>0
		   BEGIN
			INSERT INTO #Auxiliar2 
			(IdPedido, Autorizaciones, Fechas)
			VALUES
			(@Corte, SUBSTRING(@A1,1,LEN(@A1)-2), SUBSTRING(@A2,1,LEN(@A2)-2))
		   END
		SET @A1=''
		SET @A2=''
		SET @Corte=@IdPedido
	   END
	SET @A1=@A1+@Autorizo+' - '
	SET @A2=@A2+CONVERT(varchar,@FechaAutorizacion,103)+' - '
	FETCH NEXT FROM Cur INTO @IdPedido, @IdAutorizo, @Autorizo, @FechaAutorizacion, @OrdenAutorizacion
   END
   IF @Corte<>0
      BEGIN
	INSERT INTO #Auxiliar2 
	(IdPedido, Autorizaciones, Fechas)
	VALUES
	(@Corte, SUBSTRING(@A1,1,LEN(@A1)-2), SUBSTRING(@A2,1,LEN(@A2)-2))
      END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111110001133'
SET @vector_T='019H41F410I120002400'

SELECT
 DetallePedidos.IdDetallePedido,
 Pedidos.NumeroPedido as [Pedido],
 DetallePedidos.IdPedido,
 DetallePedidos.NumeroItem as [Item],
 Pedidos.FechaPedido as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 E1.Nombre as [Comprador],
 DetallePedidos.FechaEntrega as [F.entrega],
 DetallePedidos.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unid.],
 Monedas.Abreviatura as [Mon.],
 DetallePedidos.Precio as [Prec.Un.],
 (DetallePedidos.Cantidad*DetallePedidos.Precio) as [Imp.Item],
/*
 Case 	When Pedidos.TotalIva1 is not null Then Pedidos.TotalPedido-Pedidos.TotalIva1
	Else Pedidos.TotalPedido
 End as [Importe s/iva],
*/
 DetallePedidos.Precio,
 DetallePedidos.Cumplido,
 (DetallePedidos.Cantidad * DetallePedidos.Precio) as [ImporteItem],
 IsNull(E2.Iniciales,'???')+' - '+#Auxiliar2.Autorizaciones COLLATE SQL_Latin1_General_CP1_CI_AS as [Aprobo],
 Convert(varchar,Pedidos.FechaAprobacion,103)+' - '+#Auxiliar2.Fechas as [Fecha aprobo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo = E2.IdEmpleado
LEFT OUTER JOIN Unidades ON DetallePedidos.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN #Auxiliar2 ON DetallePedidos.IdPedido = #Auxiliar2.IdPedido
WHERE DetallePedidos.IdDetalleRequerimiento=@IdDetalleRequerimiento  and 
	IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(DetallePedidos.Cumplido,'NO')<>'AN'
ORDER By Pedidos.NumeroPedido

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
