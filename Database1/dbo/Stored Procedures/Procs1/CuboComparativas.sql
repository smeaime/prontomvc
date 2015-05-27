CREATE Procedure [dbo].[CuboComparativas]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200)

AS 

SET NOCOUNT ON

TRUNCATE TABLE _TempCuboComparativa
INSERT INTO _TempCuboComparativa
 SELECT 
  IsNull(Rubros.Descripcion,'_S/D'),
  Case 	When IsNull(DetPre.OrigenDescripcion,1)=1
	 Then Articulos.Descripcion
	When IsNull(DetPre.OrigenDescripcion,1)=2
	 Then Convert(varchar(5000),IsNull(DetPre.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS,''))
	When IsNull(DetPre.OrigenDescripcion,1)=3
	 Then Articulos.Descripcion+' '+Convert(varchar(5000),IsNull(DetPre.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS,''))
	Else ''
  End,
  Convert(varchar,Presupuestos.FechaIngreso,103)+' '+
	Substring('00000000',1,8-Len(Convert(varchar,Presupuestos.Numero)))+
		Convert(varchar,Presupuestos.Numero)+' / '+
		Convert(varchar,IsNull(Presupuestos.Subnumero,''))+' - '+
	'Proveedor : '+IsNull(Proveedores.RazonSocial,''),
  DetPre.Cantidad,
  IsNull(DetPre.Precio,0)
 FROM DetallePresupuestos DetPre
 LEFT OUTER JOIN Presupuestos ON DetPre.IdPresupuesto = Presupuestos.IdPresupuesto
 LEFT OUTER JOIN Proveedores ON Presupuestos.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPre.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 WHERE Presupuestos.FechaIngreso between @FechaDesde and DATEADD(n,1439,@FechaHasta) 

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF