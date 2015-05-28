CREATE Procedure [dbo].[ConsultaStockCompleto_TX3]

@IdDeposito int = Null

AS

SET @IdDeposito=IsNull(@IdDeposito,-1)

SET NOCOUNT ON

DECLARE @vector_X varchar(50), @vector_T varchar(50), @Clave varchar(3), @MostrarDatosTelas varchar(2)

SET @MostrarDatosTelas=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Mostrar datos de telas en consultas de stock' and IsNull(ProntoIni.Valor,'')='SI'),'')

EXEC Stock_CalcularEquivalencias

SET @vector_X='011111111111111111111133'
IF @MostrarDatosTelas='SI'
	SET @vector_T='0993DH511909222223222F00'
ELSE
	SET @vector_T='0993DH511909222223229900'
SET @Clave='SCD'

SET NOCOUNT OFF

SELECT 
 Stk.IdStock as [IdStock],
 @Clave as [Stock],
 Stk.IdArticulo as [IdArticulo],
 Articulos.Codigo as [Codigo],
 Rtrim(Articulos.Descripcion)+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 Stk.Partida as [Partida],
 Stk.CantidadUnidades as [Cant.],
 (Select sum(DetalleReservas.CantidadUnidades) From DetalleReservas Where DetalleReservas.IdStock=Stk.IdStock) as [Cant.Res.],
 U1.Abreviatura as [En :],
 Stk.IdStock as [IdAux],
 U2.Abreviatura as [Equiv. a],
 Stk.Equivalencia as [Equiv.],
 Stk.CantidadEquivalencia as [Cant.Equiv.],
 Stk.NumeroCaja as [Nro.Caja],
 Rubros.Descripcion as [Rubro],
 Articulos.StockMinimo as [Stock Min.],
 UnidadesEmpaque.PesoBruto as [P.Bruto],
 UnidadesEmpaque.Tara as [Tara],
 UnidadesEmpaque.Metros as [Metros],
 UnidadesEmpaque.PartidasOrigen as [Partidas utilizadas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Stock Stk
LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades U1 ON Stk.IdUnidad = U1.IdUnidad
LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON Stk.IdObra = Obras.IdObra
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN UnidadesEmpaque ON Stk.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON IsNull(UnidadesEmpaque.IdColor,Stk.IdColor) = Colores.IdColor
WHERE NOT Stk.CantidadUnidades=0 and (@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and 
	IsNull(Articulos.Activo,'SI')='SI' and IsNull(Articulos.RegistrarStock,'SI')='SI'
ORDER BY [Codigo], [Obra], [Ubicacion], [Partida]