CREATE PROCEDURE [dbo].[Recibos_TX_Impuestos]

@IdRecibo int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdRecibo INTEGER,
			 Tipo VARCHAR(30),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT Recibos.IdRecibo, 'RETENCION IVA', Recibos.RetencionIVA
 FROM Recibos
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.RetencionIVA,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 'RETENCION GANANCIAS', Recibos.RetencionGanancias
 FROM Recibos
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.RetencionGanancias,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros1
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta1 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros1,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros2
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta2 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros2,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros3
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta3 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros3,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros4
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta4 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros4,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros5
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta5 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros5,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros6
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta6 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros6,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros7
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta7 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros7,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros8
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta8 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros8,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros9
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta9 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros9,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, Substring(Cuentas.Descripcion,1,30), Recibos.Otros10
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta10 = Cuentas.IdCuenta
 WHERE (@IdRecibo=-1 or Recibos.IdRecibo=@IdRecibo) and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros10,0)<>0

SET NOCOUNT OFF

SELECT * FROM #Auxiliar1

DROP TABLE #Auxiliar1
