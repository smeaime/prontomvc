
CREATE procedure [dbo].[REP_IMPUTAC_SEL]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 REP_IMPUTAC_INS VARCHAR(1),
			 PROVEEDOR VARCHAR(7),
			 CABEZA VARCHAR(12),
			 CODCABEZA VARCHAR(2),
			 RENGLON INTEGER,
			 IMPUTACION VARCHAR(12),
			 CCOSTOS VARCHAR(12),
			 DH VARCHAR(1),
			 IMPORTEML NUMERIC(18,2),
			 CONCEPTO VARCHAR(30),
			 IDSUBDIARIO INT,
			 REP_IMPUTAC_ELIMINADO VARCHAR(1)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	Subdiarios.REP_IMPUTAC_INS,
	IsNull((Select Top 1 Prov.CodigoEmpresa 
		From Proveedores Prov 
		Where Prov.IdProveedor=cp.IdProveedor),''),
	Substring('000000000000',1,12-Len(Convert(varchar,cp.NumeroReferencia)))+
		Convert(varchar,cp.NumeroReferencia),
	IsNull(cp.InformacionAuxiliar,(Select Top 1 TP.InformacionAuxiliar 
					From TiposComprobante TP 
					Where TP.IdTipoComprobante=cp.IdTipoComprobante)),
	1,
	IsNull(Cuentas.Codigo,''),
	IsNull(Obras.NumeroObra,''),
	Case When Subdiarios.Debe is not null Then 'D' Else 'H' End,
	IsNull(Subdiarios.Debe,Subdiarios.Haber),
	IsNull(Subdiarios.Detalle,''),
	Subdiarios.IdSubdiario,
	''
 FROM Subdiarios
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON Subdiarios.IdComprobante=cp.IdComprobanteProveedor and 
						Subdiarios.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN DetalleComprobantesProveedores dcp ON Subdiarios.IdDetalleComprobante=dcp.IdDetalleComprobanteProveedor
 LEFT OUTER JOIN Obras ON dcp.IdObra=Obras.IdObra Where Subdiarios.REP_IMPUTAC_INS = 'Y' or Subdiarios.REP_IMPUTAC_upd = 'Y'

/*  CURSOR  */
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (PROVEEDOR,CABEZA,CODCABEZA,DH) ON [PRIMARY]

DECLARE @Corte varchar(21), @Renglon1 int,
	@Proveedor varchar(7), @Cabeza varchar(12), @CodCabeza varchar(2), @Renglon int
SET @Corte=''
SET @Renglon1=1
DECLARE Subd CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT PROVEEDOR,CABEZA,CODCABEZA,RENGLON
		FROM #Auxiliar1
		ORDER BY PROVEEDOR,CABEZA,CODCABEZA
OPEN Subd
FETCH NEXT FROM Subd INTO @Proveedor,@Cabeza,@CodCabeza,@Renglon
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Corte<>@Proveedor+@Cabeza+@CodCabeza
		BEGIN
			SET @Renglon1=1
			SET @Corte=@Proveedor+@Cabeza+@CodCabeza
		END
		UPDATE #Auxiliar1
		SET RENGLON = @Renglon1
		WHERE CURRENT OF Subd
		SET @Renglon1=@Renglon1+1
	FETCH NEXT FROM Subd INTO @Proveedor,@Cabeza,@CodCabeza,@Renglon
END
CLOSE Subd
DEALLOCATE Subd

INSERT INTO #Auxiliar1 
 SELECT 
	'',
	PROVEEDOR,
	CABEZA,
	CODCABEZA,
	'',
	'',
	'',
	'',
	0,
	'',
	IDSUBDIARIO,
	'Y'
 FROM _BorradoSubdiarios

SET NOCOUNT ON

SELECT * 
FROM #Auxiliar1
ORDER BY REP_IMPUTAC_ELIMINADO DESC,PROVEEDOR,CABEZA,CODCABEZA,RENGLON,DH

DROP TABLE #Auxiliar1
