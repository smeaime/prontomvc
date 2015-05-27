CREATE Procedure [dbo].[Valores_TX_ChequesNoUsados]

@Visto varchar(2) = Null

AS

SET NOCOUNT ON

SET @Visto=IsNull(@Visto,'NO')

DECLARE @IdBancoChequera int, @DesdeCheque numeric(18,0), @UltimoNumeroCheque numeric(18,0), @NumeroCheque numeric(18,0),  @Detalle varchar(100), @IdValorFaltanteVisto int

CREATE TABLE #Auxiliar1 (IdBancoChequera INTEGER, NumeroCheque NUMERIC(18,0), Detalle VARCHAR(100))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdBancoChequera,NumeroCheque) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT Convert(int,AuxNum4), Convert(int,AuxNum2), Detalle
 FROM Log
 WHERE IsNull(Tipo,'')='CH-EL'

CREATE TABLE #Auxiliar2 (IdBancoChequera INTEGER, DesdeCheque NUMERIC(18,0), UltimoNumeroCheque NUMERIC(18,0))

INSERT INTO #Auxiliar2 
 SELECT IdBancoChequera, DesdeCheque, IsNull(ProximoNumeroCheque,0)-1
 FROM BancoChequeras
 WHERE IsNull(ProximoNumeroCheque,0)>DesdeCheque --and IsNull(Activa,'')<>'NO' 

CREATE TABLE #Auxiliar3 (IdBancoChequera INTEGER, NumeroCheque NUMERIC(18,0), Detalle VARCHAR(100))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdBancoChequera,NumeroCheque) ON [PRIMARY]

CREATE TABLE #Auxiliar4 (IdBancoChequera INTEGER, NumeroCheque NUMERIC(18,0))
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdBancoChequera,NumeroCheque) ON [PRIMARY]

INSERT INTO #Auxiliar4
 SELECT dopv.IdBancoChequera, Valores.NumeroValor
 FROM Valores
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 WHERE dopv.IdBancoChequera is not null

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdBancoChequera, DesdeCheque, UltimoNumeroCheque FROM #Auxiliar2 ORDER BY IdBancoChequera
OPEN Cur
FETCH NEXT FROM Cur INTO @IdBancoChequera, @DesdeCheque, @UltimoNumeroCheque
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @NumeroCheque=@DesdeCheque
	IF ABS(@UltimoNumeroCheque-@DesdeCheque)>1000
	   BEGIN
		SET @IdValorFaltanteVisto=IsNull((Select Top 1 IdValorFaltanteVisto From ValoresFaltantesVistos Where IdBancoChequera=@IdBancoChequera and NumeroCheque=0),0)
		IF (@Visto='NO' and @IdValorFaltanteVisto=0) or (@Visto='SI' and @IdValorFaltanteVisto>0)
			INSERT INTO #Auxiliar3
			(IdBancoChequera, NumeroCheque, Detalle)
			VALUES
			(@IdBancoChequera, 0, 'ERROR EN NUMERADORES DE CHEQUERA.(CHEQUE INICIAL '+Convert(varchar,@DesdeCheque)+', ULTIMO CHEQUE '+Convert(varchar,@UltimoNumeroCheque))
	   END
	ELSE
	   BEGIN
		WHILE @NumeroCheque<=@UltimoNumeroCheque
		   BEGIN
			IF Not Exists(Select Top 1 * From #Auxiliar4 Where NumeroCheque=@NumeroCheque and IdBancoChequera=@IdBancoChequera)
			   BEGIN
				SET @Detalle=IsNull((Select Top 1 Detalle From #Auxiliar1 Where IdBancoChequera=@IdBancoChequera and NumeroCheque=@NumeroCheque),'')

				SET @IdValorFaltanteVisto=IsNull((Select Top 1 IdValorFaltanteVisto From ValoresFaltantesVistos Where IdBancoChequera=@IdBancoChequera and NumeroCheque=@NumeroCheque),0)
				IF (@Visto='NO' and @IdValorFaltanteVisto=0) or (@Visto='SI' and @IdValorFaltanteVisto>0)
					INSERT INTO #Auxiliar3
					(IdBancoChequera, NumeroCheque, Detalle)
					VALUES
					(@IdBancoChequera, @NumeroCheque, @Detalle)
			   END
			SET @NumeroCheque=@NumeroCheque+1
		   END
	   END
	FETCH NEXT FROM Cur INTO @IdBancoChequera, @DesdeCheque, @UltimoNumeroCheque
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
IF @Visto='NO'
   BEGIN
	SET @vector_X='01111133'
	SET @vector_T='05955500'

	SELECT
	 #Auxiliar3.IdBancoChequera as [IdAux1],
	 Bancos.Nombre as [Banco],
	 #Auxiliar3.IdBancoChequera as [IdAux2],
	 BancoChequeras.NumeroChequera as [Chequera],
	 #Auxiliar3.NumeroCheque as [Nro.Cheque],
	 #Auxiliar3.Detalle as [Detalle faltante],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar3 
	LEFT OUTER JOIN BancoChequeras ON BancoChequeras.IdBancoChequera=#Auxiliar3.IdBancoChequera
	LEFT OUTER JOIN Bancos ON Bancos.IdBanco=BancoChequeras.IdBanco
	ORDER BY Bancos.Nombre, BancoChequeras.NumeroChequera, #Auxiliar3.NumeroCheque
   END
ELSE
   BEGIN
	SET @vector_X='01111111133'
	SET @vector_T='05955555500'

	SELECT
	 #Auxiliar3.IdBancoChequera as [IdAux1],
	 Bancos.Nombre as [Banco],
	 #Auxiliar3.IdBancoChequera as [IdAux2],
	 BancoChequeras.NumeroChequera as [Chequera],
	 #Auxiliar3.NumeroCheque as [Nro.Cheque],
	 #Auxiliar3.Detalle as [Detalle visto],
	 Empleados.Nombre as [Marco visto],
	 ValoresFaltantesVistos.FechaMarcado as [Fecha visto],
	 ValoresFaltantesVistos.MotivoMarcado as [Motivo visto],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar3 
	LEFT OUTER JOIN BancoChequeras ON BancoChequeras.IdBancoChequera=#Auxiliar3.IdBancoChequera
	LEFT OUTER JOIN Bancos ON Bancos.IdBanco=BancoChequeras.IdBanco
	LEFT OUTER JOIN ValoresFaltantesVistos ON ValoresFaltantesVistos.IdBancoChequera=#Auxiliar3.IdBancoChequera and ValoresFaltantesVistos.NumeroCheque=#Auxiliar3.NumeroCheque
	LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=ValoresFaltantesVistos.IdUsuarioMarco
	ORDER BY Bancos.Nombre, BancoChequeras.NumeroChequera, #Auxiliar3.NumeroCheque
   END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4