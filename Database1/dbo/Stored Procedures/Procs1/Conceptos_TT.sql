CREATE  Procedure [dbo].[Conceptos_TT]

AS 

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
WHERE IsNull(Grupo,0)=0
ORDER BY Conceptos.Descripcion