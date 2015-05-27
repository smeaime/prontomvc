
CREATE Procedure [dbo].[Presto_SetearMovimientosComoProcesados]

@TipoSalida varchar(1),
@FechaDesde datetime,
@FechaHasta datetime ,
@Obras varchar(4000),
@TodasLasObras int,
@VectorProceso varchar(6)

AS 

SET @VectorProceso=IsNull(@VectorProceso,'211111')

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')
IF Len(@BasePRONTOMANT)=0
	RETURN


CREATE TABLE #Auxiliar1 (IdComp INTEGER)

IF Substring(@VectorProceso,4,1)='1'
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DISTINCT DetPed.IdPedido
	 FROM DetallePedidos DetPed
	 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
	 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetPed.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
	 WHERE (Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
		Pedidos.PRESTOFechaProceso is null and Obras.NumeroObra is not null and 
		Pedidos.FechaPedido Between @FechaDesde And @FechaHasta and 
		(@TodasLasObras=-1 or Patindex('%('+Convert(varchar,Obras.NumeroObra)+')%', @Obras)<>0)
	
	UPDATE Pedidos
	SET PRESTOFechaProceso=GetDate()
	WHERE EXISTS(Select Top 1 #Auxiliar1.IdComp From #Auxiliar1
			Where #Auxiliar1.IdComp=Pedidos.IdPedido)
    END

IF Substring(@VectorProceso,3,1)='1'
   BEGIN
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT DISTINCT DetRec.IdRecepcion 
	 FROM DetalleRecepciones DetRec
	 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
	 LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
	 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI' and Recepciones.PRESTOFechaProceso is null and 
		Obras.NumeroObra is not null and 
		Recepciones.FechaRecepcion Between @FechaDesde And @FechaHasta and 
		(@TodasLasObras=-1 or Patindex('%('+Convert(varchar,Obras.NumeroObra)+')%', @Obras)<>0)
	
	UPDATE Recepciones
	SET PRESTOFechaProceso=GetDate()
	WHERE EXISTS(Select Top 1 #Auxiliar1.IdComp From #Auxiliar1
			Where #Auxiliar1.IdComp=Recepciones.IdRecepcion)
    END

IF Substring(@VectorProceso,1,1)<>'0'
   BEGIN
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT Det.IdComprobanteProveedor
	 FROM DetalleComprobantesProveedores Det
	 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor = cp.IdComprobanteProveedor
	 LEFT OUTER JOIN Obras ON Det.IdObra = Obras.IdObra
	 LEFT OUTER JOIN DetalleRecepciones DetRec ON Det.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
	 WHERE cp.PRESTOFechaProceso is null and Obras.NumeroObra is not null and 
		cp.FechaComprobante Between @FechaDesde And @FechaHasta and 
		(@TodasLasObras=-1 or Patindex('%('+Convert(varchar,Obras.NumeroObra)+')%', @Obras)<>0) and 
		((Substring(@VectorProceso,1,1)='1' and Det.IdDetalleRecepcion is null and Det.IdDetallePedido is null) or 
		 (Substring(@VectorProceso,1,1)='2' and Det.IdDetalleRecepcion is not null and DetRec.IdDetallePedido is not null) or 
		 (Substring(@VectorProceso,1,1)='3' and Det.IdDetalleRecepcion is null and Det.IdDetallePedido is not null) or 
		 (Substring(@VectorProceso,1,1)='4' and Det.IdDetalleRecepcion is not null and DetRec.IdDetallePedido is null))
	
	UPDATE ComprobantesProveedores
	SET PRESTOFechaProceso=GetDate()
	WHERE EXISTS(Select Top 1 #Auxiliar1.IdComp From #Auxiliar1
			Where #Auxiliar1.IdComp=ComprobantesProveedores.IdComprobanteProveedor)
    END

IF Substring(@VectorProceso,6,1)='1'
   BEGIN
	SET @sql1='UPDATE '+@BasePRONTOMANT+'.dbo.DetallePartesDiariosEmpleados  
			SET PRESTOFechaProceso=GetDate() 
			WHERE PRESTOFechaProceso is null and 
				(Select Top 1 pde.Fecha
				 From '+@BasePRONTOMANT+'.dbo.PartesDiariosEmpleados pde 
				 Where IdParteDiarioEmpleados=pde.IdParteDiarioEmpleados)
				Between Convert(datetime,'''+Convert(varchar,@FechaDesde,103)+''',103) and 
				Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103) '
	/*
	IF @TodasLasObras<>-1
		SET @sql1=@sql1 + ' and Patindex('''+'%('+'''+Convert(varchar,
				IsNull((Select Top 1 ob.NumeroObra
					From '+@BasePRONTOMANT+'.dbo.PartesDiariosEmpleados pde 
					Left Outer Join '+@BasePRONTOMANT+'.dbo.Obras ob ON pde.IdOrigenTransmision = ob.IdObra 
					Where DetallePartesDiariosEmpleados.IdParteDiarioEmpleados = pde.IdParteDiarioEmpleados),0))+'''+')%'+''', '''+@Obras+''')<>0'
	*/
	EXEC sp_executesql @sql1
    END

IF Substring(@VectorProceso,5,1)='1'
   BEGIN
	SET @sql1='UPDATE '+@BasePRONTOMANT+'.dbo.DetallePartesDiarios  
			SET PRESTOFechaProceso=GetDate() 
			Where PRESTOFechaProceso is null and 
				(Select Top 1 pd.FechaParteDiario 
				 From '+@BasePRONTOMANT+'.dbo.PartesDiarios pd 
				 Where IdParteDiario=pd.IdParteDiario)
				Between Convert(datetime,'''+Convert(varchar,@FechaDesde,103)+''',103) and 
				Convert(datetime,'''+Convert(varchar,@FechaHasta,103)+''',103) '
	EXEC sp_executesql @sql1
    END

DROP TABLE #Auxiliar1
