CREATE Procedure [dbo].[ConsultaStockCompleto_TX6]

@IdDeposito int = Null

AS

SET NOCOUNT ON

SET @IdDeposito=IsNull(@IdDeposito,-1)

DECLARE @vector_X varchar(50), @vector_T varchar(50), @ConsolidacionDeBDs varchar(2), @NombreServidorWeb varchar(100), @UsuarioServidorWeb varchar(50), @PasswordServidorWeb varchar(50), 
	@BaseDeDatosServidorWeb varchar(50), @proc_name varchar(1000)

SET @vector_X='0111111111133'
SET @vector_T='02D2002211100'

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar10
			(
			 IdAux INTEGER,
			 CodigoArticulo VARCHAR(20),
			 Articulo VARCHAR(300),
			 CodigoColor VARCHAR(5),
			 Color VARCHAR(50),
			 Talle VARCHAR(2),
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2),
			 Marca VARCHAR(50),
			 Rubro VARCHAR(50),
			 Subrubro VARCHAR(50),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

CREATE TABLE #Auxiliar11
			(
			 IdAux INTEGER,
			 CodigoArticulo VARCHAR(20),
			 Articulo VARCHAR(300),
			 CodigoColor VARCHAR(5),
			 Color VARCHAR(50),
			 Talle VARCHAR(2),
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2),
			 Marca VARCHAR(50),
			 Rubro VARCHAR(50),
			 Subrubro VARCHAR(50),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

IF Len(@NombreServidorWeb)>0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.ConsultaStockCompleto_TX6'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @IdDeposito
	EXEC sp_dropserver @NombreServidorWeb
  END

INSERT INTO #Auxiliar10 
 SELECT 
  1,
  Articulos.Codigo,
  Articulos.Descripcion,
  Colores.Codigo2,
  Colores.Descripcion,
  Stk.Talle,
  Stk.CantidadUnidades,
  dbo.PrecioPorTalle(Stk.IdArticulo,Stk.Talle),
  Marcas.Descripcion,
  Rubros.Descripcion,
  Subrubros.Descripcion,
  @Vector_T,
  @Vector_X
 FROM Stock Stk
 LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Colores ON Stk.IdColor = Colores.IdColor
 LEFT OUTER JOIN Marcas ON Articulos.IdMarca = Marcas.IdMarca
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Subrubros ON Articulos.IdRubro = Subrubros.IdSubrubro
 LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
 WHERE NOT Stk.CantidadUnidades=0 and (@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and IsNull(Articulos.Activo,'SI')='SI'

INSERT INTO #Auxiliar11 
 SELECT IdAux, CodigoArticulo, Articulo, CodigoColor, Color, Talle, Sum(IsNull(Cantidad,0)), Max(Precio), Marca, Rubro, Subrubro, Vector_T, Vector_X
 FROM #Auxiliar10
 GROUP BY IdAux, CodigoArticulo, Articulo, CodigoColor, Color, Talle, Marca, Rubro, Subrubro, Vector_T, Vector_X

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar11
ORDER BY CodigoArticulo, Color, Talle

DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11