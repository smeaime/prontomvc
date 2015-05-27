
CREATE  Procedure [dbo].[DepositosBancarios_TX_TT]

@IdDepositoBancario int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdDepositoBancario INTEGER,
			 Valores NUMERIC(18, 2),
			 Efectivo NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DepositosBancarios.IdDepositoBancario, 
  (Select Sum(Valores.Importe) 
   From DetalleDepositosBancarios DetDep
   Left Outer Join Valores On Valores.IdValor=DetDep.IdValor
   Where DetDep.IdDepositoBancario = DepositosBancarios.IdDepositoBancario),
  DepositosBancarios.Efectivo 
 FROM DepositosBancarios 
 WHERE DepositosBancarios.IdDepositoBancario=@IdDepositoBancario

UPDATE #Auxiliar1
SET Valores=0
WHERE Valores IS NULL

UPDATE #Auxiliar1
SET Efectivo=0
WHERE Efectivo IS NULL

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011166611133'
Set @vector_T='042344412400'

SELECT 
 #Auxiliar1.IdDepositoBancario, 
 DepositosBancarios.FechaDeposito as [Fecha de deposito],
 Bancos.Nombre as [Banco],
 DepositosBancarios.NumeroDeposito as [Boleta nro.],
 Case When #Auxiliar1.Valores<>0 Then #Auxiliar1.Valores Else Null End as [Valores],
 Case When #Auxiliar1.Efectivo<>0 Then #Auxiliar1.Efectivo Else Null End as [Efectivo],
 #Auxiliar1.Valores+#Auxiliar1.Efectivo as [Total deposito],
 Anulado,
 Empleados.Nombre as [Anulo],
 FechaAnulacion as [Fecha anulacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
LEFT OUTER JOIN Bancos ON DepositosBancarios.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Empleados ON DepositosBancarios.IdAutorizaAnulacion=Empleados.IdEmpleado
ORDER BY DepositosBancarios.FechaDeposito

DROP TABLE #Auxiliar1
