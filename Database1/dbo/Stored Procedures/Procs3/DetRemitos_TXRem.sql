CREATE Procedure [dbo].[DetRemitos_TXRem]

@IdRemito int

AS 

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='0191EGF111952243200'
ELSE
	SET @vector_T='0191G99111952243200'

SELECT 
 dr.IdDetalleRemito,
 dr.NumeroItem as [Item],
 dr.IdDetalleRemito as [IdAux],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 dr.Talle as [Ta],
 Colores.Descripcion as [Color],
 dr.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad],
 dr.PorcentajeCertificacion as [% Cert.],
 dr.OrigenDescripcion,
 dr.Observaciones,
 Case When IsNull(dr.OrigenDescripcion,1)=1 Then 'Mat.'
	When IsNull(dr.OrigenDescripcion,1)=2 Then 'Obs.'
	Else 'Mat.+Obs.'
 End as [Texto],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 dr.Partida,
 dr.NumeroCaja as [Nro.Caja],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRemitos dr
LEFT OUTER JOIN Articulos ON dr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON dr.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON dr.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON dr.IdObra = Obras.IdObra
LEFT OUTER JOIN UnidadesEmpaque ON dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores ON IsNull(UnidadesEmpaque.IdColor,dr.IdColor) = Colores.IdColor
WHERE (dr.IdRemito = @IdRemito)
ORDER BY dr.NumeroItem