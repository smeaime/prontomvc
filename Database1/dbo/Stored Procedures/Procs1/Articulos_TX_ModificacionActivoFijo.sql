
CREATE Procedure [dbo].[Articulos_TX_ModificacionActivoFijo]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111116161111111133'
SET @vector_T='0339100541003554421132200'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Cod.material],
 Articulos.NumeroInventario as [Nro.Activo],
 Articulos.IdArticulo as [Identificador],
 Articulos.Descripcion,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 (Select Count(*) From DetalleArticulosActivosFijos
  Where DetalleArticulosActivosFijos.IdArticulo=Articulos.IdArticulo) as [Modificaciones],
 Articulos.FechaCompra as [Fec.Compra],
 GruposActivosFijos.Descripcion as [Grupo],
 Articulos.VidaUtilContable as [TT],
 Articulos.VidaUtilContableRestante as [TR],
 Articulos.ValorOrigenContable as [Valor orig.],
 Articulos.FechaPrimeraAmortizacionContable as [Fec.1ra.Amort.],
 Articulos.UltimoRevaluoContable as [Ult.Rev.Contable],
 Articulos.NumeroPatente as [Dominio],
 Articulos.NumeroMotor as [Nro.Motor],
 Articulos.NumeroChasis as [Nro.Chasis],
 Articulos.AñoFabricacion as [Año fab.],
 Articulos.EntidadOrigen as [Proveedor],
 Articulos.ComprobanteCompra as [Comp.Compra],
 Acabados.Descripcion as [Estado equipo],
 Articulos.UbicacionActivoFijo as [Ubicacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
LEFT OUTER JOIN Rubros ON  Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro left outer  JOIN Familias ON Articulos.IdFamilia = Familias.IdFamilia
LEFT OUTER JOIN GruposActivosFijos ON  Articulos.IdGrupoActivoFijo = GruposActivosFijos.IdGrupoActivoFijo 
LEFT OUTER JOIN Acabados ON  Articulos.IdAcabado = Acabados.IdAcabado
WHERE Articulos.ActivoFijo is not null and Articulos.ActivoFijo='SI'
ORDER by Rubros.Descripcion,Subrubros.Descripcion
