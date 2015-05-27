CREATE PROCEDURE [dbo].[Conciliaciones_TX_NoConciliadosAFecha]

@FechaFinalConciliacion datetime ,
@Formato varchar(10) = Null

AS

SET NOCOUNT ON 

SET @Formato=IsNull(@Formato,'')

CREATE TABLE #Auxiliar1 (IdConciliacion INTEGER, IdCuentaBancaria INTEGER)
CREATE TABLE #Auxiliar2 (IdConciliacion INTEGER)

INSERT INTO #Auxiliar1
 SELECT IdConciliacion, IdCuentaBancaria FROM Conciliaciones WHERE FechaInicial<=@FechaFinalConciliacion and FechaFinal>=@FechaFinalConciliacion
 
INSERT INTO #Auxiliar2
 SELECT Max(IdConciliacion) FROM #Auxiliar1 GROUP BY IdCuentaBancaria
 
SET NOCOUNT OFF

IF @Formato=''
	SELECT
	 DetConc.IdDetalleConciliacion,
	 DetConc.IdConciliacion,
	 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo valor],
	 DetConc.IdValor,
	 Valores.NumeroValor as [Numero valor],
	 Valores.NumeroInterno as [Nro.Int.],
	 Valores.FechaValor as [Fecha valor],
	 Valores.FechaDeposito as [Fecha dep.],
	 Valores.NumeroDeposito as [Nro. dep.],
	 Case 	When 	(Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=Conciliaciones.IdCuentaBancaria)
			OR
			((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=-1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [Ingresos],
	 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [Egresos],
	 Valores.Iva as [Iva],
	 Bancos.Nombre as [Banco origen],
	 tc.DescripcionAb as [Tipo],
	 Valores.NumeroComprobante as [Comp.],
	 Valores.FechaComprobante as [Fec.Comp.],
	 Clientes.RazonSocial as [Cliente],
	 Proveedores.RazonSocial as [Proveedor],
	 Case 	When 	(Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=Conciliaciones.IdCuentaBancaria)
			OR
			((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=-1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [TotalIngresos],
	 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [TotalEgresos],
	 DetConc.Controlado,
	 DetConc.IdDetalleConciliacion as [IdAux],
	 DetConc.ControladoNoConciliado
	FROM DetalleConciliaciones DetConc
	LEFT OUTER JOIN Conciliaciones ON DetConc.IdConciliacion=Conciliaciones.IdConciliacion
	LEFT OUTER JOIN Valores ON DetConc.IdValor=Valores.IdValor
	LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN CuentasBancarias ON Conciliaciones.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	WHERE DetConc.IdConciliacion In (Select IdConciliacion From #Auxiliar2) and DetConc.Conciliado is not null and DetConc.Conciliado='NO'
ELSE
	SELECT
	 Valores.IdTipoValor,
	 Case 	When 	(Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=Conciliaciones.IdCuentaBancaria)
			OR
			((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=-1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [TotalIngresos],
	 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)))
			OR
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 tc.Coeficiente=1)
		 Then 	Case When Valores.Importe>=0 
				Then Valores.Importe 
				Else Valores.Importe*-1 
			End 
		When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.Estado is null and
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
					Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  								from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
				 Then 	Case When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  									  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
						Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
						Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  										from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
					End 
				 Else Null 
			End
		Else Null
	 End as [TotalEgresos]
	FROM DetalleConciliaciones DetConc
	LEFT OUTER JOIN Conciliaciones ON DetConc.IdConciliacion=Conciliaciones.IdConciliacion
	LEFT OUTER JOIN Valores ON DetConc.IdValor=Valores.IdValor
	LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN CuentasBancarias ON Conciliaciones.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	WHERE DetConc.IdConciliacion In (Select IdConciliacion From #Auxiliar2) and DetConc.Conciliado is not null and DetConc.Conciliado='NO'

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2