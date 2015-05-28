CREATE Procedure [dbo].[ConsultaStockCompleto_TX5]

@IdDeposito int = Null,
@ConCurvas varchar(2) = Null

AS

SET NOCOUNT ON

SET @IdDeposito=IsNull(@IdDeposito,-1)
SET @ConCurvas=IsNull(@ConCurvas,'SI')

DECLARE @vector_X varchar(50), @vector_T varchar(50), @Clave varchar(3), @MostrarDatosTelas varchar(2), @IdArticulo int, @IdColor int, @IdCurvaTalle int, @Talle varchar(2), 
	@CantidadUnidades numeric(18,2), @IdAux int, @Curva varchar(50), @Pos int, @i int, @ConCurvas2 varchar(2), 
	@T1 int, @T2 int, @T3 int, @T4 int, @T5 int, @T6 int, @T7 int, @T8 int, @T9 int, @T10 int, @T11 int, @T12 int, @T13 int, @T14 int, @T15 int, 
	@ConsolidacionDeBDs varchar(2), @NombreServidorWeb varchar(100), @UsuarioServidorWeb varchar(50), @PasswordServidorWeb varchar(50), @BaseDeDatosServidorWeb varchar(50), 
	@proc_name varchar(1000)

SET @vector_X='01111111111111111111111133'
SET @vector_T='00999DGFGGGGGGGGGGGGGGG200'
SET @ConCurvas2='NO'

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER, 
			 IdColor INTEGER, 
			 IdCurvaTalle INTEGER, 
			 Talle VARCHAR(2), 
			 CantidadUnidades NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticulo, IdColor, IdCurvaTalle, Talle) ON [PRIMARY]

CREATE TABLE #Auxiliar10
			(
			 IdAux INTEGER,
			 Codigo VARCHAR(20),
			 IdAux0 INTEGER,
			 IdAux1 INTEGER,
			 IdAux2 INTEGER,
			 Articulo VARCHAR(300),
			 Color VARCHAR(50),
			 CodigoCurva INTEGER,
			 T1 VARCHAR(20),
			 T2 VARCHAR(20),
			 T3 VARCHAR(20),
			 T4 VARCHAR(20),
			 T5 VARCHAR(20),
			 T6 VARCHAR(20),
			 T7 VARCHAR(20),
			 T8 VARCHAR(20),
			 T9 VARCHAR(20),
			 T10 VARCHAR(20),
			 T11 VARCHAR(20),
			 T12 VARCHAR(20),
			 T13 VARCHAR(20),
			 T14 VARCHAR(20),
			 T15 VARCHAR(20),
			 Total NUMERIC(18,2),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

CREATE TABLE #Auxiliar11
			(
			 IdArticulo INTEGER,
			 IdColor INTEGER,
			 T1 INTEGER, 
			 T2 INTEGER, 
			 T3 INTEGER, 
			 T4 INTEGER, 
			 T5 INTEGER,
			 T6 INTEGER, 
			 T7 INTEGER, 
			 T8 INTEGER, 
			 T9 INTEGER, 
			 T10 INTEGER, 
			 T11 INTEGER, 
			 T12 INTEGER, 
			 T13 INTEGER, 
			 T14 INTEGER, 
			 T15 INTEGER, 
			 Total INTEGER
			)

INSERT INTO #Auxiliar1
 SELECT s.IdArticulo, s.IdColor, a.IdCurvaTalle, IsNull(s.Talle,'00'), Sum(IsNull(s.CantidadUnidades,0))
 FROM Stock s 
 LEFT OUTER JOIN Articulos a ON a.IdArticulo = s.IdArticulo
 GROUP BY s.IdArticulo, s.IdColor, a.IdCurvaTalle, s.Talle

CREATE TABLE #Auxiliar2 
			(
			 IdAux INTEGER IDENTITY (1, 1), 
			 IdArticulo INTEGER, 
			 IdColor INTEGER, 
			 IdCurvaTalle INTEGER, 
			 T1 INTEGER, 
			 T2 INTEGER, 
			 T3 INTEGER, 
			 T4 INTEGER, 
			 T5 INTEGER,
			 T6 INTEGER, 
			 T7 INTEGER, 
			 T8 INTEGER, 
			 T9 INTEGER, 
			 T10 INTEGER, 
			 T11 INTEGER, 
			 T12 INTEGER, 
			 T13 INTEGER, 
			 T14 INTEGER, 
			 T15 INTEGER, 
			 Total INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticulo, IdColor) ON [PRIMARY]

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticulo, IdColor, IdCurvaTalle, Talle, CantidadUnidades FROM #Auxiliar1 ORDER BY IdArticulo, IdColor, IdCurvaTalle, Talle
OPEN Cur
FETCH NEXT FROM Cur INTO @IdArticulo, @IdColor, @IdCurvaTalle, @Talle, @CantidadUnidades
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar2 Where IdArticulo=@IdArticulo and IdColor=@IdColor),0)
	SET @Curva=IsNull((Select Top 1 Curva From CurvasTalles Where IdCurvaTalle=@IdCurvaTalle),'')

	SET @T1=0
	SET @T2=0
	SET @T3=0
	SET @T4=0
	SET @T5=0
	SET @T6=0
	SET @T7=0
	SET @T8=0
	SET @T9=0
	SET @T10=0
	SET @T11=0
	SET @T12=0
	SET @T13=0
	SET @T14=0
	SET @T15=0

	SET @Pos=0
	SET @i=0
	WHILE @i<15
	    BEGIN
		SET @i=@i+1
		IF Substring(@Curva,(@i-1)*2+1,2)=@Talle
		    BEGIN
			SET @Pos=@i
			BREAK
		    END
	    END
	IF @Pos<=1
		SET @T1=@CantidadUnidades
	IF @Pos=2
		SET @T2=@CantidadUnidades
	IF @Pos=3
		SET @T3=@CantidadUnidades
	IF @Pos=4
		SET @T4=@CantidadUnidades
	IF @Pos=5
		SET @T5=@CantidadUnidades
	IF @Pos=6
		SET @T6=@CantidadUnidades
	IF @Pos=7
		SET @T7=@CantidadUnidades
	IF @Pos=8
		SET @T8=@CantidadUnidades
	IF @Pos=9
		SET @T9=@CantidadUnidades
	IF @Pos=10
		SET @T10=@CantidadUnidades
	IF @Pos=11
		SET @T11=@CantidadUnidades
	IF @Pos=12
		SET @T12=@CantidadUnidades
	IF @Pos=13
		SET @T13=@CantidadUnidades
	IF @Pos=14
		SET @T14=@CantidadUnidades
	IF @Pos=15
		SET @T15=@CantidadUnidades

	IF @IdAux=0
		INSERT INTO #Auxiliar2 (IdArticulo, IdColor, IdCurvaTalle, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, Total)
			VALUES (@IdArticulo, @IdColor, @IdCurvaTalle, @T1, @T2, @T3, @T4, @T5, @T6, @T7, @T8, @T9, @T10, @T11, @T12, @T13, @T14, @T15, Null)
	ELSE
		UPDATE #Auxiliar2
		SET T1=T1+@T1, T2=T2+@T2, T3=T3+@T3, T4=T4+@T4, T5=T5+@T5, T6=T6+@T6, T7=T7+@T7, T8=T8+@T8, T9=T9+@T9, T10=T10+@T10, T11=T11+@T11, T12=T12+@T12, T13=T13+@T13, T14=T14+@T14, T15=T15+@T15
		WHERE IdAux=@IdAux

	FETCH NEXT FROM Cur INTO @IdArticulo, @IdColor, @IdCurvaTalle, @Talle, @CantidadUnidades
    END
CLOSE Cur
DEALLOCATE Cur

UPDATE #Auxiliar2
SET Total=T1+T2+T3+T4+T5+T6+T7+T8+T9+T10+T11+T12+T13+T14+T15

IF @ConCurvas='SI'
	INSERT INTO #Auxiliar10 
	 SELECT 
	  0,
	  Null,
	  CurvasTalles.IdCurvaTalle,
	  0,
	  0,
	  Null,
	  Null,
	  CurvasTalles.Codigo,
	  Substring(CurvasTalles.Curva,1,2),
	  Substring(CurvasTalles.Curva,3,2),
	  Substring(CurvasTalles.Curva,5,2),
	  Substring(CurvasTalles.Curva,7,2),
	  Substring(CurvasTalles.Curva,9,2),
	  Substring(CurvasTalles.Curva,11,2),
	  Substring(CurvasTalles.Curva,13,2),
	  Substring(CurvasTalles.Curva,15,2),
	  Substring(CurvasTalles.Curva,17,2),
	  Substring(CurvasTalles.Curva,19,2),
	  Substring(CurvasTalles.Curva,21,2),
	  Substring(CurvasTalles.Curva,23,2),
	  Substring(CurvasTalles.Curva,25,2),
	  Substring(CurvasTalles.Curva,27,2),
	  Substring(CurvasTalles.Curva,29,2),
	  Null,
	  @Vector_T,
	  @Vector_X
	 FROM CurvasTalles
	 WHERE IsNull(MostrarCurvaEnInformes,'')='SI'

INSERT INTO #Auxiliar10 
 SELECT 
  aux.IdAux,
  Articulos.Codigo,
  999,
  aux.IdArticulo,
  aux.IdColor,
  Articulos.Descripcion,
  Colores.Descripcion,
  CurvasTalles.Codigo,
  Convert(varchar,Case When aux.T1<>0 Then aux.T1 Else Null End),
  Convert(varchar,Case When aux.T2<>0 Then aux.T2 Else Null End),
  Convert(varchar,Case When aux.T3<>0 Then aux.T3 Else Null End),
  Convert(varchar,Case When aux.T4<>0 Then aux.T4 Else Null End),
  Convert(varchar,Case When aux.T5<>0 Then aux.T5 Else Null End),
  Convert(varchar,Case When aux.T6<>0 Then aux.T6 Else Null End),
  Convert(varchar,Case When aux.T7<>0 Then aux.T7 Else Null End),
  Convert(varchar,Case When aux.T8<>0 Then aux.T8 Else Null End),
  Convert(varchar,Case When aux.T9<>0 Then aux.T9 Else Null End),
  Convert(varchar,Case When aux.T10<>0 Then aux.T10 Else Null End),
  Convert(varchar,Case When aux.T11<>0 Then aux.T11 Else Null End),
  Convert(varchar,Case When aux.T12<>0 Then aux.T12 Else Null End),
  Convert(varchar,Case When aux.T13<>0 Then aux.T13 Else Null End),
  Convert(varchar,Case When aux.T14<>0 Then aux.T14 Else Null End),
  Convert(varchar,Case When aux.T15<>0 Then aux.T15 Else Null End),
  aux.Total,
  @Vector_T,
  @Vector_X
 FROM #Auxiliar2 aux
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = aux.IdArticulo
 LEFT OUTER JOIN Colores ON Colores.IdColor = aux.IdColor
 LEFT OUTER JOIN CurvasTalles ON CurvasTalles.IdCurvaTalle = Articulos.IdCurvaTalle
 WHERE IsNull(Articulos.Activo,'SI')='SI' and IsNull(Articulos.RegistrarStock,'SI')='SI'

IF Len(@NombreServidorWeb)>0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.ConsultaStockCompleto_TX5'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @IdDeposito,@ConCurvas2
	EXEC sp_dropserver @NombreServidorWeb
--EXEC sp_dropserver 'serversql1'

	INSERT INTO #Auxiliar11 
	 SELECT IdAux1, IdAux2, Sum(Convert(int,IsNull(T1,'0'))), Sum(Convert(int,IsNull(T2,'0'))), Sum(Convert(int,IsNull(T3,'0'))), 
			Sum(Convert(int,IsNull(T4,'0'))), Sum(Convert(int,IsNull(T5,'0'))), Sum(Convert(int,IsNull(T6,'0'))), Sum(Convert(int,IsNull(T7,'0'))), 
			Sum(Convert(int,IsNull(T8,'0'))), Sum(Convert(int,IsNull(T9,'0'))), Sum(Convert(int,IsNull(T10,'0'))), Sum(Convert(int,IsNull(T11,'0'))), 
			Sum(Convert(int,IsNull(T12,'0'))), Sum(Convert(int,IsNull(T13,'0'))), Sum(Convert(int,IsNull(T14,'0'))), Sum(Convert(int,IsNull(T15,'0'))), 0
	 FROM #Auxiliar10
	 WHERE IdAux0=999
	 GROUP BY IdAux1, IdAux2

	UPDATE #Auxiliar11
	SET Total=T1+T2+T3+T4+T5+T6+T7+T8+T9+T10+T11+T12+T13+T14+T15

	DELETE #Auxiliar10 WHERE IdAux0=999
	
	INSERT INTO #Auxiliar10 
	 SELECT 
	  0,
	  Articulos.Codigo,
	  999,
	  aux.IdArticulo,
	  aux.IdColor,
	  Articulos.Descripcion,
	  Colores.Descripcion,
	  CurvasTalles.Codigo,
	  Convert(varchar,Case When aux.T1<>0 Then aux.T1 Else Null End),
	  Convert(varchar,Case When aux.T2<>0 Then aux.T2 Else Null End),
	  Convert(varchar,Case When aux.T3<>0 Then aux.T3 Else Null End),
	  Convert(varchar,Case When aux.T4<>0 Then aux.T4 Else Null End),
	  Convert(varchar,Case When aux.T5<>0 Then aux.T5 Else Null End),
	  Convert(varchar,Case When aux.T6<>0 Then aux.T6 Else Null End),
	  Convert(varchar,Case When aux.T7<>0 Then aux.T7 Else Null End),
	  Convert(varchar,Case When aux.T8<>0 Then aux.T8 Else Null End),
	  Convert(varchar,Case When aux.T9<>0 Then aux.T9 Else Null End),
	  Convert(varchar,Case When aux.T10<>0 Then aux.T10 Else Null End),
	  Convert(varchar,Case When aux.T11<>0 Then aux.T11 Else Null End),
	  Convert(varchar,Case When aux.T12<>0 Then aux.T12 Else Null End),
	  Convert(varchar,Case When aux.T13<>0 Then aux.T13 Else Null End),
	  Convert(varchar,Case When aux.T14<>0 Then aux.T14 Else Null End),
	  Convert(varchar,Case When aux.T15<>0 Then aux.T15 Else Null End),
	  aux.Total,
	  @Vector_T,
	  @Vector_X
	 FROM #Auxiliar11 aux
	 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = aux.IdArticulo
	 LEFT OUTER JOIN Colores ON Colores.IdColor = aux.IdColor
	 LEFT OUTER JOIN CurvasTalles ON CurvasTalles.IdCurvaTalle = Articulos.IdCurvaTalle
  END

SET NOCOUNT OFF

SELECT 
 IdAux as [IdAux],
 Codigo as [Codigo],
 IdAux0 as [IdAux0],
 IdAux1 as [IdAux1],
 IdAux2 as [IdAux2],
 Articulo as [Articulo],
 Color as [Color],
 CodigoCurva as [C],
 T1 as [T1],
 T2 as [T2],
 T3 as [T3],
 T4 as [T4],
 T5 as [T5],
 T6 as [T6],
 T7 as [T7],
 T8 as [T8],
 T9 as [T9],
 T10 as [T10],
 T11 as [T11],
 T12 as [T12],
 T13 as [T13],
 T14 as [T14],
 T15 as [T15],
 Total as [Total],
 Vector_T as [Vector_T],
 Vector_X as [Vector_X]
FROM #Auxiliar10
ORDER BY IdAux0, Codigo, Articulo, Color

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11