
CREATE  Procedure [dbo].[wPedidos_T]

@IdPedido int = Null

AS 

SET NOCOUNT ON

SET @IdPedido=IsNull(@IdPedido,-1)

CREATE TABLE #Auxiliar0 
			(
			 IdPedido INTEGER,
			 Requerimientos VARCHAR(100),
			 Obras VARCHAR(100)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdPedido INTEGER,
			 NumeroRequerimiento INTEGER,
			 NumeroObra VARCHAR(13),
			 SAT VARCHAR(1)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetPed.IdPedido,
  Case When Requerimientos.NumeroRequerimiento is not null
	Then Requerimientos.NumeroRequerimiento
	Else Acopios.NumeroAcopio
  End,
  Obras.NumeroObra,
  Case When DetalleRequerimientos.IdOrigenTransmision is not null
	Then 'S'
	Else ''
  End
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
 LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
 WHERE @IdPedido=-1 or DetPed.IdPedido=@IdPedido

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPedido,NumeroRequerimiento) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT IdPedido, '', ''
 FROM #Auxiliar1
 GROUP BY IdPedido

/*  CURSOR  */
DECLARE @IdPedido1 int, @NumeroRequerimiento int, @NumeroObra varchar(13), 
	@RMs varchar(100), @Obras varchar(100), @Corte int, @SAT varchar(1)
SET @Corte=0
SET @RMs=''
SET @Obras=''
DECLARE PedReq CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdPedido, NumeroRequerimiento, NumeroObra, SAT
		FROM #Auxiliar1
		ORDER BY IdPedido
OPEN PedReq
FETCH NEXT FROM PedReq INTO @IdPedido1, @NumeroRequerimiento, @NumeroObra, @SAT
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdPedido1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
			WHERE #Auxiliar0.IdPedido=@Corte
		   END
		SET @RMs=''
		SET @Obras=''
		SET @Corte=@IdPedido1
	   END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+'%', @RMs)=0
			SET @RMs=@RMs+'['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+@SAT+' '
	IF NOT @NumeroObra IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroObra)+' '+'%', @Obras)=0
			SET @Obras=@Obras+@NumeroObra+' '
	FETCH NEXT FROM PedReq INTO @IdPedido1, @NumeroRequerimiento, @NumeroObra, @SAT
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
	WHERE #Auxiliar0.IdPedido=@Corte
    END
CLOSE PedReq
DEALLOCATE PedReq

SET NOCOUNT OFF

SELECT 
 Pedidos.*,
 #Auxiliar0.Requerimientos as [RMs],
 #Auxiliar0.Obras as [Obras],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When TotalIva2 is null
	 Then TotalPedido-TotalIva1+Bonificacion
	 Else TotalPedido-TotalIva1-TotalIva2+Bonificacion
 End as [NetoGravado],
 Monedas.Abreviatura as [Moneda],
 E1.Nombre as [Comprador],
 E2.Nombre as [Libero],
 (Select Count(*) From DetallePedidos Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [CantidadItems],
 PedidosAbiertos.NumeroPedidoAbierto as [PedidoAbierto],
 (Select Top 1 A.Descripcion From Articulos A 
	Where A.IdArticulo=(Select Top 1 Requerimientos.IdEquipoDestino 
				From DetalleRequerimientos DR
				Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DR.IdRequerimiento
				Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento 
								 From DetallePedidos DP 
								 Where DP.IdPedido=Pedidos.IdPedido and 
									DP.IdDetalleRequerimiento is not null))) as [EquipoDestino],
 cc.Descripcion as [CondicionCompra]
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN #Auxiliar0 ON Pedidos.IdPedido=#Auxiliar0.IdPedido
LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
LEFT OUTER JOIN [Condiciones Compra] cc ON Pedidos.IdCondicionCompra=cc.IdCondicionCompra
WHERE @IdPedido=-1 or Pedidos.IdPedido=@IdPedido
ORDER BY NumeroPedido DESC,SubNumero DESC

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1

