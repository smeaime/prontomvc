CREATE  Procedure [dbo].[Valores_TX_EnCartera]

@Formato varchar(20) = Null,
@Fecha datetime = Null,
@IdBancoProbable int = Null

AS 

SET @Formato=IsNull(@Formato,'')
SET @Fecha=IsNull(@Fecha,0)
SET @IdBancoProbable=IsNull(@IdBancoProbable,-1)

IF @Formato=''
  BEGIN
	DECLARE @vector_X varchar(30),@vector_T varchar(30)
	SET @vector_X='011111111111133'
	SET @vector_T='029114312124200'
	
	SELECT 
	 Valores.IdValor,
	 T1.DescripcionAb as [Tipo valor],
	 Valores.IdValor as [IdVal],
	 Valores.NumeroInterno as [Nro.Int.],
	 Valores.NumeroValor as [Numero],
	 Valores.FechaValor as [Fecha Vto.],
	 Valores.Importe as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 Bancos.Nombre as [Banco origen],
	 T2.DescripcionAb as [Comp.],
	 Valores.NumeroComprobante as [Nro.Comp.],
	 Valores.FechaComprobante as [Fec.Comp.],
	 Clientes.RazonSocial as [Cliente],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Valores 
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN TiposComprobante T1 ON Valores.IdTipoValor=T1.IdTipoComprobante
	LEFT OUTER JOIN TiposComprobante T2 ON Valores.IdTipoComprobante=T2.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
	WHERE Valores.Estado is null and 
		(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
		IsNull(T1.Agrupacion1,'') ='CHEQUES'
	ORDER BY Valores.FechaValor,Valores.NumeroInterno
  END

IF @Formato='REPORTE_FINANCIERO'
  BEGIN
	DECLARE @IdBancoDestinoDefault int

	SET @IdBancoDestinoDefault=8 -- Este es el banco galicia donde van los cheques que vienen de bancos que no pertenecen a la empresa

	SELECT SUM(Valores.Importe) as [Importe]
	FROM Valores 
	LEFT OUTER JOIN TiposComprobante T1 ON Valores.IdTipoValor=T1.IdTipoComprobante
	WHERE Valores.Estado is null and 
		(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
		IsNull(T1.Agrupacion1,'') ='CHEQUES' and 
		Valores.FechaValor=@Fecha and 
		(@IdBancoProbable<=0 or Valores.IdBanco=@IdBancoProbable or (@IdBancoProbable=@IdBancoDestinoDefault and Not Exists(Select Top 1 cb.IdCuentaBancaria From CuentasBancarias cb Where cb.IdBanco=Valores.IdBanco)))
  END
  
IF @Formato='REPORTE_FINANCIERO2'
  BEGIN
	SELECT SUM(Valores.Importe) as [Importe]
	FROM Valores 
	LEFT OUTER JOIN TiposComprobante T1 ON Valores.IdTipoValor=T1.IdTipoComprobante
	WHERE 
		Valores.FechaComprobante<=@Fecha and 
		(Valores.Estado is null  or 
		 (Valores.Estado='D' and Valores.FechaConfirmacionBanco>@Fecha) or 
		 (Valores.Estado='E' and Valores.FechaOrdenPago>@Fecha)) and 
		(Valores.IdTipoComprobante<>17 or Valores.IdTipoComprobante is null) and 
		IsNull(T1.Agrupacion1,'') ='CHEQUES' 
  END