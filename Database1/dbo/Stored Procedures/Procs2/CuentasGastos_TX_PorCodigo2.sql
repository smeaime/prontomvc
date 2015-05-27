CREATE Procedure [dbo].[CuentasGastos_TX_PorCodigo2]

@Codigo varchar(20)

AS 

IF Not Exists(Select Top 1 IdCuentaGasto From CuentasGastos Where Codigo=@Codigo) and IsNumeric(@Codigo)=1
  BEGIN
	SET NOCOUNT ON

	CREATE TABLE #Auxiliar1
				(
				 IdCuentaGasto INTEGER,
				 CodigoSubcuenta INTEGER,
				 Descripcion VARCHAR(50),
				 IdRubroContable INTEGER,
				 IdCuentaMadre INTEGER,
				 Activa VARCHAR(2),
				 Codigo VARCHAR(20),
				 CodigoDestino VARCHAR(10),
				 Titulo VARCHAR(2),
				 Nivel INTEGER
				)
	INSERT INTO #Auxiliar1 
	 SELECT IdCuentaGasto, CodigoSubcuenta, Descripcion, IdRubroContable, IdCuentaMadre, Activa, Codigo, CodigoDestino, Titulo, Nivel
	 FROM CuentasGastos
	 WHERE IsNumeric(Codigo)=1

	SET NOCOUNT OFF

	SELECT * FROM #Auxiliar1 WHERE Convert(numeric(18,5),Codigo)=Convert(numeric(18,5),@Codigo)
	DROP TABLE #Auxiliar1
  END
ELSE
	SELECT * FROM CuentasGastos WHERE (Codigo=@Codigo)