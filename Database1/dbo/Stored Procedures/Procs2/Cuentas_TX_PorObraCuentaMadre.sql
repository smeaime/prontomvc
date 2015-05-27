CREATE Procedure [dbo].[Cuentas_TX_PorObraCuentaMadre]

@IdObra int,
@IdCuentaMadre int,
@IdArticulo int = Null,
@FechaConsulta datetime = Null

AS 

SET NOCOUNT ON

SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

DECLARE @IdCuentaMadre1 int, @IdCuentaMadre2 int, @IdCuentaMadre3 int, @IdCuentaMadre4 int, @IdCuentaMadre5 int, @IdCuentaMadre6 int, @IdCuentaMadre7 int, 
		@IdCuentaMadre8 int, @IdCuentaMadre9 int, @IdCuentaMadre10 int, @ModeloContableSinApertura varchar(2)

SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'')

SET @IdCuentaMadre1=0
SET @IdCuentaMadre2=0
SET @IdCuentaMadre3=0
SET @IdCuentaMadre4=0
SET @IdCuentaMadre5=0
SET @IdCuentaMadre6=0
SET @IdCuentaMadre7=0
SET @IdCuentaMadre8=0
SET @IdCuentaMadre9=0
SET @IdCuentaMadre10=0

IF @IdArticulo>0 and @IdCuentaMadre=0
	SET @IdCuentaMadre=IsNull((Select Top 1 Rubros.IdCuentaCompras From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
IF @IdArticulo>0 
   BEGIN
	SET @IdCuentaMadre1=IsNull((Select Top 1 Rubros.IdCuentaCompras1 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre2=IsNull((Select Top 1 Rubros.IdCuentaCompras2 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre3=IsNull((Select Top 1 Rubros.IdCuentaCompras3 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre4=IsNull((Select Top 1 Rubros.IdCuentaCompras4 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre5=IsNull((Select Top 1 Rubros.IdCuentaCompras5 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre6=IsNull((Select Top 1 Rubros.IdCuentaCompras6 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre7=IsNull((Select Top 1 Rubros.IdCuentaCompras7 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre8=IsNull((Select Top 1 Rubros.IdCuentaCompras8 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre9=IsNull((Select Top 1 Rubros.IdCuentaCompras9 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
	SET @IdCuentaMadre10=IsNull((Select Top 1 Rubros.IdCuentaCompras10 From Articulos Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro Where Articulos.IdArticulo=@IdArticulo),0)
   END

SET NOCOUNT OFF

SELECT *
FROM Cuentas
WHERE Cuentas.IdTipoCuenta=2 and 
	(
	 (@ModeloContableSinApertura='SI' and Cuentas.IdCuenta=@IdCuentaMadre) or
	 (@ModeloContableSinApertura<>'SI' and Cuentas.IdObra=@IdObra and 
		(IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre1  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre2  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre3  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre4  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre5  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre6  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre7  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre8  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre9  or 
		 IsNull((Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaGasto=Cuentas.IdCuentaGasto),-1)=@IdCuentaMadre10))
	) and 

	Not (Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),'S/D'))=0) and 
	(Len(IsNull(Cuentas.Descripcion,''))>0 or 
	 (Len(IsNull(Cuentas.Descripcion,''))=0 and 
	  Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),''))>0))
