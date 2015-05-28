CREATE Procedure [dbo].[Articulos_TT]

AS 

DECLARE @MostrarCuentaCompras varchar(2), @SistemaVentasPorTalle varchar(2), @vector_X varchar(30), @vector_T varchar(30)

SET @MostrarCuentaCompras=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Mostrar cuenta contable de compras en articulos'),'')
SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET @vector_X='01111111111111111111111111133'
SET @vector_T='05E91193234342233042622999900'
IF @MostrarCuentaCompras='SI'
	SET @vector_T='05E91193234342233042622529900'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='05E91113234342233042622991100'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Codigo material],
 Articulos.Descripcion,
 Articulos.IdArticulo as [Identificador],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Marcas.Descripcion as [Marca],
 Articulos.NumeroInventario as [Nro.inv.],
 Articulos.AlicuotaIVA as [% IVA],
 Case When Articulos.CostoPPP=0 Then Null Else Articulos.CostoPPP End as [Costo PPP],
 Case When Articulos.CostoPPPDolar=0 Then Null Else Articulos.CostoPPPDolar End as [Costo PPP u$s],
 Case When Articulos.CostoReposicion=0 Then Null Else Articulos.CostoReposicion End as [Costo Rep.],
 Case When Articulos.CostoReposicionDolar=0 Then Null Else Articulos.CostoReposicionDolar End as [Costo Rep u$s],
 Articulos.StockMinimo as [Stock Min.],
 Articulos.StockReposicion as [Stock Rep.],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades Where Articulos.IdUnidad=Unidades.IdUnidad) as [En],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Articulos.FechaAlta as [Fecha alta],
 Articulos.UsuarioAlta as [Usuario alta],
 Articulos.FechaUltimaModificacion as [Fecha ult.modif.],
 Articulos.ParaMantenimiento as [p/mant.],
 Articulos.AuxiliarString10 as [NMC],
 Cuentas.Codigo as [Cod.Cta.Compras],
 Cuentas.Descripcion as [Cuenta de compras],
 CurvasTalles.Codigo as [Cod.Curva],
 Articulos.Curva as [Curva],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Articulos.IdCuentaCompras 
LEFT OUTER JOIN CurvasTalles ON CurvasTalles.IdCurvaTalle = Articulos.IdCurvaTalle 
LEFT OUTER JOIN Marcas ON Articulos.IdMarca = Marcas.IdMarca
WHERE IsNull(Articulos.Activo,'')<>'NO'
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo