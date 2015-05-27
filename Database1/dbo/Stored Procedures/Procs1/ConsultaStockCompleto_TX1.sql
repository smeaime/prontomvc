CREATE Procedure [dbo].[ConsultaStockCompleto_TX1]

@IdDeposito int = Null,
@Orden varchar(1) = Null,
@ConTotales varchar(2) = Null

AS

SET @IdDeposito=IsNull(@IdDeposito,-1)
SET @Orden=IsNull(@Orden,'C')
SET @ConTotales=IsNull(@ConTotales,'NO')

SET NOCOUNT ON

DECLARE @vector_X varchar(50), @vector_T varchar(50), @Clave varchar(3), @MostrarDatosTelas varchar(2)

SET @MostrarDatosTelas=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Mostrar datos de telas en consultas de stock' and IsNull(ProntoIni.Valor,'')='SI'),'')

EXEC Stock_CalcularEquivalencias

SET @vector_X='0111111111111111116666666611111133'
IF @MostrarDatosTelas='SI'
	SET @vector_T='099993DH51190922224444454523222F00'
ELSE
	SET @vector_T='099993DH51190922224444454523229900'
SET @Clave='SCD'

SET NOCOUNT OFF

IF @ConTotales='SI'
  BEGIN
	SELECT 
	 Stk.IdStock as [IdStock],
	 1 as [Aux1],
	 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [Aux2],
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
	 Articulos.CostoPPP as [Costo PPP $],
	 Stk.CantidadEquivalencia*Articulos.CostoPPP as [Stock val. $],
	 Articulos.CostoPPPDolar as [Costo PPP u$s],
	 Stk.CantidadEquivalencia*Articulos.CostoPPPDolar as [Stock val. u$s],
	 Articulos.CostoReposicion as [Costo Rep. $],
	 Stk.CantidadEquivalencia*Articulos.CostoReposicion as [Stock val. rep. $],
	 Articulos.CostoReposicionDolar as [Costo Rep u$s.],
	 Stk.CantidadEquivalencia*Articulos.CostoReposicionDolar as [Stock val. rep. u$s],
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

	UNION ALL

	SELECT 
	 0 as [IdStock],
	 2 as [Aux1],
	 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [Aux2],
	 @Clave as [Stock],
	 Stk.IdArticulo as [IdArticulo],
	 Articulos.Codigo as [Codigo],
	 Rtrim(Articulos.Descripcion)+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	 Null as [Ubicacion],
	 Null as [Obra],
	 Null as [Partida],
	 Sum(IsNull(Stk.CantidadUnidades,0)) as [Cant.],
	 Null as [Cant.Res.],
	 Null as [En :],
	 Null as [IdAux],
	 Null as [Equiv. a],
	 Null as [Equiv.],
	 Sum(IsNull(Stk.CantidadEquivalencia,0)) as [Cant.Equiv.],
	 Null as [Nro.Caja],
	 Null as [Costo PPP $],
	 Sum(IsNull(Stk.CantidadEquivalencia,0)*IsNull(Articulos.CostoPPP,0)) as [Stock val. $],
	 Null as [Costo PPP u$s],
	 Sum(IsNull(Stk.CantidadEquivalencia,0)*IsNull(Articulos.CostoPPPDolar,0)) as [Stock val. u$s],
	 Null as [Costo Rep. $],
	 Sum(IsNull(Stk.CantidadEquivalencia,0)*IsNull(Articulos.CostoReposicion,0)) as [Stock val. rep. $],
	 Null as [Costo Rep u$s.],
	 Sum(IsNull(Stk.CantidadEquivalencia,0)*IsNull(Articulos.CostoReposicionDolar,0)) as [Stock val. rep. u$s],
	 Null as [Rubro],
	 Null as [Stock Min.],
	 Sum(IsNull(UnidadesEmpaque.PesoBruto,0)) as [P.Bruto],
	 Sum(IsNull(UnidadesEmpaque.Tara,0)) as [Tara],
	 Sum(IsNull(UnidadesEmpaque.Metros,0)) as [Metros],
	 Null as [Partidas utilizadas],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Stock Stk
	LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
	LEFT OUTER JOIN UnidadesEmpaque ON Stk.NumeroCaja = UnidadesEmpaque.NumeroUnidad
	LEFT OUTER JOIN Colores ON IsNull(UnidadesEmpaque.IdColor,Stk.IdColor) = Colores.IdColor
	WHERE NOT Stk.CantidadUnidades=0 and (@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and 
		IsNull(Articulos.Activo,'SI')='SI' and IsNull(Articulos.RegistrarStock,'SI')='SI'
	GROUP BY Articulos.Codigo, Articulos.Descripcion, Colores.Descripcion, Stk.IdArticulo

	ORDER BY [Aux2], [Aux1], [Codigo], [Obra], [Ubicacion], [Partida]
  END
ELSE
	SELECT 
	 Stk.IdStock as [IdStock],
	 1 as [Aux1],
	 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [Aux2],
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
	 Articulos.CostoPPP as [Costo PPP $],
	 Stk.CantidadEquivalencia*Articulos.CostoPPP as [Stock val. $],
	 Articulos.CostoPPPDolar as [Costo PPP u$s],
	 Stk.CantidadEquivalencia*Articulos.CostoPPPDolar as [Stock val. u$s],
	 Articulos.CostoReposicion as [Costo Rep. $],
	 Stk.CantidadEquivalencia*Articulos.CostoReposicion as [Stock val. rep. $],
	 Articulos.CostoReposicionDolar as [Costo Rep u$s.],
	 Stk.CantidadEquivalencia*Articulos.CostoReposicionDolar as [Stock val. rep. u$s],
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
	ORDER BY [Aux2], [Aux1], [Codigo], [Obra], [Ubicacion], [Partida]