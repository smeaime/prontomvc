




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TX_Detallado]

@FechaDesde datetime,
@FechaHasta datetime,
@Desde int,
@Hasta int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 A_IdEmpleado INTEGER,
			 A_Fecha DATETIME,
			 A_Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT
  AP.IdEmpleado,
  Case 	When AP.IdOrdenPago is not null Then OP.FechaOrdenPago
	When AP.IdRecibo is not null Then RE.FechaRecibo
	Else Asientos.FechaAsiento
  End,
  Case 	When AP.IdOrdenPago is not null Then AP.Importe * OP.CotizacionMoneda
	When AP.IdRecibo is not null Then AP.Importe * RE.CotizacionMoneda * -1
	 Else AP.Importe * -1
  End
 FROM AnticiposAlPersonal AP
 LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
 LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
 LEFT OUTER JOIN Recibos RE ON RE.IdRecibo = AP.IdRecibo
 LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
 WHERE Empleados.Legajo>=@Desde and Empleados.Legajo<=@Hasta

UPDATE #Auxiliar1
SET A_Importe=0
WHERE A_Fecha>=@FechaDesde

CREATE TABLE #Auxiliar2
			(
			 A_IdEmpleado INTEGER,
			 A_Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT
  #Auxiliar1.A_IdEmpleado,
  SUM(#Auxiliar1.A_Importe)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.A_IdEmpleado

CREATE TABLE #Auxiliar3
			(
			 A_IdEmpleado INTEGER,
			 A_IdAnticipoAlPersonal INTEGER,
			 A_Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT
  #Auxiliar2.A_IdEmpleado, 
  0,
  #Auxiliar2.A_Importe 
 FROM #Auxiliar2 

UNION ALL

 SELECT
  AP.IdEmpleado, 
  AP.IdAnticipoAlPersonal,
  Case 	When AP.IdOrdenPago is not null Then AP.Importe * OP.CotizacionMoneda
	When AP.IdRecibo is not null Then AP.Importe * RE.CotizacionMoneda * -1
	Else  AP.Importe * -1
  End
 FROM AnticiposAlPersonal AP
 LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
 LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
 LEFT OUTER JOIN Recibos RE ON RE.IdRecibo = AP.IdRecibo
 LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
 WHERE Empleados.Legajo>=@Desde and Empleados.Legajo<=@Hasta and 
	((AP.IdOrdenPago is not null and 
	  OP.FechaOrdenPago>=@FechaDesde and OP.FechaOrdenPago<=@FechaHasta) or 
	 (AP.IdAsiento is not null and 
	  Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta) or 
	 (AP.IdRecibo is not null and 
	  RE.FechaRecibo>=@FechaDesde and RE.FechaRecibo<=@FechaHasta))

SET NOCOUNT OFF

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00001111111111133'
set @vector_T='00003355555533300'

SELECT
 #Auxiliar3.A_IdEmpleado as [IdAux1], 
 Empleados.Nombre as [IdAux2],
 1 as [IdAux3],
 Empleados.Legajo as [IdAux4],
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 Null as [O.Pago],
 Null as [Fecha anticipo],
 Null as [Recibo],
 Null as [Fecha recibo],
 Null as [Asiento],
 Null as [Fecha asiento],
 'Saldo al '+Convert(varchar,Dateadd(d,-1,@FechaDesde),103) as [Detalle],
 #Auxiliar3.A_Importe as [Importe],
 Empleados.CuentaBancaria as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 
LEFT OUTER JOIN Empleados ON #Auxiliar3.A_IdEmpleado = Empleados.IdEmpleado
WHERE #Auxiliar3.A_IdAnticipoAlPersonal=0

UNION ALL 

SELECT
 #Auxiliar3.A_IdEmpleado as [IdAux1], 
 Empleados.Nombre as [IdAux2],
 2 as [IdAux3],
 Empleados.Legajo as [IdAux4],
 Null as [Legajo],
 Null as [Nombre],
 OP.NumeroOrdenPago as [O.Pago],
 OP.FechaOrdenPago as [Fecha anticipo],
 RE.NumeroRecibo as [Recibo],
 RE.FechaRecibo as [Fecha recibo],
 Asientos.NumeroAsiento as [Asiento],
 Asientos.FechaAsiento as [Fecha asiento],
 AP.Detalle as [Detalle],
 #Auxiliar3.A_Importe as [Importe],
 Null as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 
LEFT OUTER JOIN AnticiposAlPersonal AP ON #Auxiliar3.A_IdAnticipoAlPersonal = AP.IdAnticipoAlPersonal
LEFT OUTER JOIN Empleados ON #Auxiliar3.A_IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
LEFT OUTER JOIN Recibos RE ON RE.IdRecibo = AP.IdRecibo
WHERE #Auxiliar3.A_IdAnticipoAlPersonal<>0

UNION ALL 

SELECT
 #Auxiliar3.A_IdEmpleado as [IdAux1], 
 Empleados.Nombre as [IdAux2],
 3 as [IdAux3],
 Empleados.Legajo as [IdAux4],
 Null as [Legajo],
 Null as [Nombre],
 Null as [O.Pago],
 Null as [Fecha anticipo],
 Null as [Recibo],
 Null as [Fecha recibo],
 Null as [Asiento],
 Null as [Fecha asiento],
 'Saldo final al '+Convert(varchar,@FechaHasta,103) as [Detalle],
 SUM(#Auxiliar3.A_Importe) as [Importe],
 Null as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 
LEFT OUTER JOIN AnticiposAlPersonal AP ON #Auxiliar3.A_IdAnticipoAlPersonal = AP.IdAnticipoAlPersonal
LEFT OUTER JOIN Empleados ON #Auxiliar3.A_IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
GROUP BY #Auxiliar3.A_IdEmpleado,Empleados.Nombre,Empleados.Legajo

UNION ALL 

SELECT
 #Auxiliar3.A_IdEmpleado as [IdAux1], 
 Empleados.Nombre as [IdAux2],
 4 as [IdAux3],
 Empleados.Legajo as [IdAux4],
 Null as [Legajo],
 Null as [Nombre],
 Null as [O.Pago],
 Null as [Fecha anticipo],
 Null as [Recibo],
 Null as [Fecha recibo],
 Null as [Asiento],
 Null as [Fecha asiento],
 Null as [Detalle],
 Null as [Importe],
 Null as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 
LEFT OUTER JOIN Empleados ON #Auxiliar3.A_IdEmpleado = Empleados.IdEmpleado
WHERE #Auxiliar3.A_IdAnticipoAlPersonal<>0
GROUP BY #Auxiliar3.A_IdEmpleado,Empleados.Nombre,Empleados.Legajo

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3




