
CREATE Procedure [dbo].[Articulos_TX_Inactivos]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111111111111133'
Set @vector_T='0519113234344204600'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Codigo material],
 Articulos.Descripcion,
 Articulos.IdArticulo as [Identificador],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Articulos.NumeroInventario as [Nro.inv.],
 Articulos.AlicuotaIVA as [% IVA],
 Case When Articulos.CostoPPP=0 Then Null Else Articulos.CostoPPP End as [Costo PPP],
 Case When Articulos.CostoPPPDolar=0 Then Null Else Articulos.CostoPPPDolar End as [Costo PPP u$s],
 Case When Articulos.CostoReposicion=0 Then Null Else Articulos.CostoReposicion End as [Costo Rep.],
 Case When Articulos.CostoReposicionDolar=0 Then Null Else Articulos.CostoReposicionDolar End as [Costo Rep u$s],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades Where Articulos.IdUnidad=Unidades.IdUnidad) as [En],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Articulos.FechaAlta as [Fecha alta],
 Articulos.FechaUltimaModificacion as [Fecha ult.modif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE IsNull(Articulos.Activo,'')='NO'
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo
