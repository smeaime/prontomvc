CREATE Procedure [dbo].[Tree_TX_Actualizar]  
  
@Clave varchar(100), 
@IdComprobante int, 
@Controlador varchar(100)

AS   

SET NOCOUNT ON

DECLARE @Fecha datetime, @FechaAux datetime, @Año int, @Mes int, @Clave2 varchar(100), @Clave3 varchar(100), @FechaInicial varchar(10), @FechaFinal varchar(10), 
		@IdItemRoot varchar(30), @IdItem1 varchar(30), @IdItem2 varchar(30), @IdItem3 varchar(30), @ParentId varchar(30), @Item int, @Directorio varchar(50), 
		@NombreMes varchar(15), @Entidad varchar(100)

SET @Fecha=0
SET @Directorio='Pronto2'

IF @Clave='RequerimientosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaRequerimiento From Requerimientos Where IdRequerimiento=@IdComprobante),0)
IF @Clave='SolicitudesCompraAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaSolicitud From SolicitudesCompra Where IdSolicitudCompra=@IdComprobante),0)
IF @Clave='AjustesStockAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaAjuste From AjustesStock Where IdAjusteStock=@IdComprobante),0)
IF @Clave='RecepcionesAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaRecepcion From Recepciones Where IdRecepcion=@IdComprobante),0)
IF @Clave='ValesSalidaAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaValeSalida From ValesSalida Where IdValeSalida=@IdComprobante),0)
IF @Clave='SalidaMaterialesAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaSalidaMateriales From SalidasMateriales Where IdSalidaMateriales=@IdComprobante),0)
IF @Clave='OtrosIngresosAlmacenAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaOtroIngresoAlmacen From OtrosIngresosAlmacen Where IdOtroIngresoAlmacen=@IdComprobante),0)
IF @Clave='OrdenesCompraAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaOrdenCompra From OrdenesCompra Where IdOrdenCompra=@IdComprobante),0)
IF @Clave='RemitosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaRemito From Remitos Where IdRemito=@IdComprobante),0)
IF @Clave='FacturasAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaFactura From Facturas Where IdFactura=@IdComprobante),0)
IF @Clave='DevolucionesAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaDevolucion From Devoluciones Where IdDevolucion=@IdComprobante),0)
IF @Clave='RecibosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaRecibo From Recibos Where IdRecibo=@IdComprobante),0)
IF @Clave='NotasDebitoAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaNotaDebito From NotasDebito Where IdNotaDebito=@IdComprobante),0)
IF @Clave='NotasCreditoAgrupadas'
	SET @Fecha=IsNull((Select Top 1 FechaNotaCredito From NotasCredito Where IdNotaCredito=@IdComprobante),0)
IF @Clave='PresupuestosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaIngreso From Presupuestos Where IdPresupuesto=@IdComprobante),0)
IF @Clave='ComparativasAgrupadas'
	SET @Fecha=IsNull((Select Top 1 Fecha From Comparativas Where IdComparativa=@IdComprobante),0)
IF @Clave='PedidosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaPedido From Pedidos Where IdPedido=@IdComprobante),0)
IF @Clave='AutorizacionesCompraAgrupadas'
	SET @Fecha=IsNull((Select Top 1 Fecha From AutorizacionesCompra Where IdAutorizacionCompra=@IdComprobante),0)
IF @Clave='ComprobantesPrvPorMes'
	SET @Fecha=IsNull((Select Top 1 FechaRecepcion From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobante),0)
IF @Clave='OPagoPorMes'
	SET @Fecha=IsNull((Select Top 1 FechaOrdenPago From OrdenesPago Where IdOrdenPago=@IdComprobante),0)
IF @Clave='DepositosBancariosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaDeposito From DepositosBancarios Where IdDepositoBancario=@IdComprobante),0)
IF @Clave='GastosBancariosAgrupados'
	SET @Fecha=IsNull((Select Top 1 FechaGasto From Valores Where IdValor=@IdComprobante),0)

IF @Fecha<>0
  BEGIN
	SET @Año=Year(@Fecha)
	SET @Mes=Month(@Fecha)

	SET @FechaInicial='01/'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año)  
	SET @FechaAux=DateAdd(d,-1,DateAdd(m,1,Convert(datetime,@FechaInicial,103)))  
	SET @FechaFinal=Substring('00',1,2-Len(Convert(varchar,Day(@FechaAux))))+Convert(varchar,Day(@FechaAux))+'/'+  
					Substring('00',1,2-Len(Convert(varchar,Month(@FechaAux))))+Convert(varchar,Month(@FechaAux))+'/'+Convert(varchar,Year(@Fecha))  

	SELECT @NombreMes = Case When @Mes=1 Then 'Enero' When @Mes=2 Then 'Febrero' When @Mes=3 Then 'Marzo' When @Mes=4 Then 'Abril'   
							 When @Mes=5 Then 'Mayo' When @Mes=6 Then 'Junio' When @Mes=7 Then 'Julio' When @Mes=8 Then 'Agosto'  
							 When @Mes=9 Then 'Septiembre' When @Mes=10 Then 'Octubre' When @Mes=11 Then 'Noviembre' When @Mes=12 Then 'Diciembre'  
						End  

	SET @IdItemRoot=IsNull((Select Top 1 IdItem From Tree Where Clave=@Clave),'')
	SET @ParentId=IsNull((Select Top 1 ParentId From Tree Where Clave=@Clave),'')

	IF Len(@IdItemRoot)>0
	  BEGIN
		SET @Entidad=IsNull((Select Top 1 Imagen From Tree Where IdItem=@IdItemRoot),'')
		
		-- Verificar si existe el nodo del año
		SET @Clave2=@Clave+Convert(varchar,@Año)
		SET @IdItem2=IsNull((Select Top 1 IdItem From Tree Where Clave=@Clave2),'')
		IF Len(@IdItem2)=0
		  BEGIN
			SET @IdItem1=IsNull((Select Top 1 IdItem From Tree Where ParentId=@IdItemRoot Order By IdItem Desc),'')
			SET @Item=Convert(int,Substring(@IdItem1,Len(@IdItem1)-2,3))
			SET @IdItem2=@IdItemRoot+'-'+Substring('000',1,3-Len(Convert(varchar,@Item+1)))+Convert(varchar,@Item+1)  
			INSERT INTO Tree   
			(IdItem, Clave, Descripcion, ParentId, Orden, Parametros, Link, Imagen, EsPadre, GrupoMenu)
			VALUES
			(@IdItem2, @Clave2, Convert(varchar,@Año), @IdItemRoot, 1, Null, 
			 '<a href="/' + @Directorio + '/'+@Controlador+'/Index?fechainicial=01/01/'+Convert(varchar,@Año)+'&fechafinal=31/12/'+Convert(varchar,@Año)+'">'+Convert(varchar,@Año)+'</a>', 
			 @Entidad, 'SI', 'Principal')
		  END
		
		-- Verificar si existe el nodo del mes
		SET @Clave3=@Clave+Convert(varchar,@Año)+Convert(varchar,Abs(12-@Mes))
		SET @IdItem3=IsNull((Select Top 1 IdItem From Tree Where Clave=@Clave3),'')
		IF Len(@IdItem3)=0
		  BEGIN
			SET @IdItem3=@IdItem2+'-'+Substring('00',1,2-Len(Convert(varchar,Abs(12-@Mes))))+Convert(varchar,Abs(12-@Mes))  

			INSERT INTO Tree   
			(IdItem, Clave, Descripcion, ParentId, Orden, Parametros, Link, Imagen, EsPadre, GrupoMenu)
			VALUES
			(@IdItem3, @Clave3, @NombreMes, @IdItem2, Abs(12-@Mes), Null, 
			 '<a href="/' + @Directorio + '/'+@Controlador+'/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 
			 @Entidad, 'NO','Principal')
		  END
	  END
  END

SET NOCOUNT OFF