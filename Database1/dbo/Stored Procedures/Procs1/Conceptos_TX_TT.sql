CREATE  Procedure [dbo].[Conceptos_TX_TT]

@IdConcepto int,
@Grupo int = Null


AS 

SET @Grupo=IsNull(@Grupo,0)

IF @Grupo=0
	SELECT 
	 Conceptos.IdConcepto,
	 Conceptos.CodigoConcepto as [Cod. Concepto],
	 Conceptos.Descripcion as [Descripcion],
	 Cuentas.Codigo as [Codigo cuenta],
	 Cuentas.Descripcion as [Cuenta],
	 Conceptos.ValorRechazado as [Valor rechazado?],
	 Conceptos.GravadoDefault as [Gravado?],
	 Conceptos.CodigoAFIP as [Codigo AFIP],
	 Conceptos.GeneraComision as [Genera comision?],
	 Conceptos.NoTomarEnRanking as [No tomar para ranking]
	FROM Conceptos 
	LEFT OUTER JOIN Cuentas ON Conceptos.IdCuenta = Cuentas.IdCuenta
	WHERE IdConcepto=@IdConcepto and IsNull(Grupo,0)=0

IF @Grupo=-1 or @Grupo=1 or @Grupo=2 or @Grupo=3
	SELECT 
	 Conceptos.IdConcepto,
	 Conceptos.Descripcion as [Descripcion],
	 Case When IsNull(Conceptos.Grupo,0)=0 Then ''
		When IsNull(Conceptos.Grupo,0)=1 Then 'Otros conceptos para OP'
		When IsNull(Conceptos.Grupo,0)=2 Then 'Clasificacion por tipo de cancelacion'
		When IsNull(Conceptos.Grupo,0)=3 Then 'Modalidades de pago'
		When IsNull(Conceptos.Grupo,0)=4 Then 'Enviar a'
		When IsNull(Conceptos.Grupo,0)=5 Then 'Textos auxiliares para OP'
	 End as [Tipo concepto]
	FROM Conceptos 
	WHERE Conceptos.IdConcepto=@IdConcepto and 
		(@Grupo=-1 and (IsNull(Conceptos.Grupo,0)=1 or IsNull(Conceptos.Grupo,0)=2 or IsNull(Conceptos.Grupo,0)=3 or IsNull(Conceptos.Grupo,0)=4 or IsNull(Conceptos.Grupo,0)=5)) or 
		(@Grupo<>-1 and IsNull(Conceptos.Grupo,0)=@Grupo)