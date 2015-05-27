CREATE Procedure [dbo].[Articulos_TX_PorIdConDatos]

@IdArticulo int,
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @LimitarEquiposDestinoSegunEtapasDeObra varchar(2), @RegistroContableComprasAlActivo varchar(2)

SET @LimitarEquiposDestinoSegunEtapasDeObra=IsNull((Select Top 1 Valor From Parametros2 Where Campo='LimitarEquiposDestinoSegunEtapasDeObra'),'NO')
SET @RegistroContableComprasAlActivo=IsNull((Select Top 1 Valor From Parametros2 Where Campo='RegistroContableComprasAlActivo'),'NO')

SELECT 
 Articulos.*,
 Rubros.IdCuenta as [IdCuentaRubro],
 IsNull(Articulos.IdCuentaCompras,Rubros.IdCuentaCompras) as [IdCuentaCompras2],
 IsNull(Articulos.IdCuentaComprasActivo,Rubros.IdCuentaComprasActivo) as [IdCuentaComprasActivo1],
 Rubros.Descripcion as [Rubro],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Marcas.Descripcion as [Marca],
 Modelos.Descripcion as [Modelo],
 Colores.Descripcion as [Color],
 (Select Top 1 Grados.Descripcion From Grados Where Grados.IdGrado=Articulos.IdGrado) as [Grado],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad1) as [Accesorios1],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad2) as [Accesorios2],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad3) as [Accesorios3],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad4) as [Accesorios4],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad5) as [Accesorios5],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad6) as [Accesorios6],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad7) as [Accesorios7],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad8) as [Accesorios8],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad9) as [Accesorios9],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad10) as [Accesorios10],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad11) as [Accesorios11],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad12) as [Accesorios12],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad13) as [Accesorios13],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad14) as [Accesorios14],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad15) as [Accesorios15],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad16) as [Accesorios16],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad17) as [Accesorios17],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad18) as [Accesorios18],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad19) as [Accesorios19],
 (Select Top 1 Sc.Descripcion From Scheduler Sc Where Sc.IdScheduler=Articulos.Unidad20) as [Accesorios20],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdCalidad) as [Programacion1],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdAcabado) as [Programacion2],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdCodigoUniversal) as [Programacion3],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdAlimentacionElectrica) as [Programacion4],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdAnioNorma) as [Programacion5],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdCalidadBase) as [Programacion6],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdCalidadRevestimiento) as [Programacion7],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdBiselado) as [Programacion8],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdCalidadClad) as [Programacion9],
 (Select Top 1 Bs.Descripcion From Biselados Bs Where Bs.IdBiselado=Articulos.IdDensidad) as [Programacion10],
 ControlesCalidad.Descripcion as [Caracteristicas],
 Relaciones.Descripcion as [Servicio],
 Case When @LimitarEquiposDestinoSegunEtapasDeObra='SI' 
	Then (Select Top 1 dod.IdDetalleObraDestino From DetalleObrasDestinos dod
		Where IsNull(dod.InformacionAuxiliar,'-1')=IsNull(Articulos.NumeroManzana COLLATE Modern_Spanish_CI_AS,'-2'))
	Else Null
 End as [IdDetalleObraDestino],
 Case When Exists(Select Top 1 DetalleConjuntos.IdConjunto From DetalleConjuntos
			Left Outer Join Conjuntos ON DetalleConjuntos.IdConjunto = Conjuntos.IdConjunto
			Where Conjuntos.IdArticulo = @IdArticulo)
	Then 'SI'
	Else 'NO'
 End as [ConKit],
 IsNull((Select Sum(IsNull(A.CostoReposicion,0) * Det.Cantidad) From DetalleConjuntos Det 
	Left Outer Join Conjuntos C On C.IdConjunto=Det.IdConjunto
	Left Outer Join Articulos A On A.IdArticulo=Det.IdArticulo
	Where C.IdArticulo=Articulos.IdArticulo),0) as [CostoKit],
 (Select Top 1 C.Codigo From Cuentas C Where C.IdCuenta=Articulos.IdCuentaCompras) as [CodigoCuentaCompras],
  Case When Articulos.IdCuentaCompras is not null and @IdObra>0
	 Then IsNull((Select Top 1 c.IdCuenta From Cuentas c
			 Where c.IdObra=@IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and Articulos.IdCuentaCompras=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Articulos.IdCuentaCompras)
	When @RegistroContableComprasAlActivo='SI' and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and IsNull(Rubros.IdCuentaComprasActivo,0)<>0 and @IdObra>0
	 Then IsNull((Select Top 1 c.IdCuenta From Cuentas c
			 Where c.IdObra=@IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and Rubros.IdCuentaComprasActivo=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto)),Rubros.IdCuentaComprasActivo)
	 Else IsNull((Select Top 1 c.IdCuenta From Cuentas c
			 Where c.IdObra=@IdObra and Len(LTrim(IsNull(c.Descripcion,'')))>0 and 
				(Rubros.IdCuentaCompras=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras1,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras2,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras3,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras4,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras5,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras6,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras7,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras8,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras9,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto) or 
				 IsNull(Rubros.IdCuentaCompras10,0)=(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=c.IdCuentaGasto))),Rubros.IdCuentaCompras)
 End  as [IdCuentaCompras1],
 CurvasTalles.Codigo as [CodigoCurvaTalles],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Marcas ON Articulos.IdMarca = Marcas.IdMarca
LEFT OUTER JOIN Modelos ON Articulos.IdModelo = Modelos.IdModelo
LEFT OUTER JOIN Colores ON Articulos.IdColor = Colores.IdColor
LEFT OUTER JOIN ControlesCalidad ON  Articulos.Datos2 = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Relaciones ON Articulos.IdRelacion = Relaciones.IdRelacion
LEFT OUTER JOIN CurvasTalles ON CurvasTalles.IdCurvaTalle = Articulos.IdCurvaTalle 
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Articulos.IdUnidad
WHERE (@IdArticulo=-1 or Articulos.IdArticulo=@IdArticulo)
ORDER BY Articulos.Codigo