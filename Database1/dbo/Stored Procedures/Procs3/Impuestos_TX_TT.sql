CREATE  Procedure [dbo].[Impuestos_TX_TT]

@IdImpuesto int

AS 

DECLARE @vector_X varchar(30), @vector_T varchar(30), @IdTipoComprobante int

SET @IdTipoComprobante=IsNull((Select Top 1 IdTipoComprobante From Impuestos Where IdImpuesto=@IdImpuesto),0)
IF @IdTipoComprobante=110
   BEGIN
	SET @vector_X='01111111111133'
	SET @vector_T='01992E34255500'

	SELECT 
	 Impuestos.IdImpuesto,
	 Articulos.Codigo as [Ord.Perm.],
	 Impuestos.IdImpuesto as [IdAux1],
	 Null [IdAux2],
	 Articulos.NumeroPatente as [Patente],
	 Articulos.Descripcion as [Equipo imputado],
	 Modelos.Descripcion as [Modelo],
	 Impuestos.Fecha as [Fecha],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 Impuestos.EnUsoPor as [En uso por],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Impuestos
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	WHERE Impuestos.IdImpuesto=@IdImpuesto
   END
ELSE
   BEGIN
	SET @vector_X='01111111111133'
	SET @vector_T='05991512435500'

	SELECT 
	 Impuestos.IdImpuesto,
	 Impuestos.Detalle as [Detalle],
	 Impuestos.IdImpuesto as [IdAux1],
	 Null [IdAux2],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.TipoPlan as [Tipo Plan],
	 Impuestos.CodigoPlan as [Nro.Plan],
	 Impuestos.Agencia as [Agencia],
	 Impuestos.Fecha as [Fecha],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Impuestos
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	WHERE Impuestos.IdImpuesto=@IdImpuesto
   END