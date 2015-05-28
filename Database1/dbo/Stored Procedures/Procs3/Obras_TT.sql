CREATE Procedure [dbo].[Obras_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111133'
SET @vector_T='079383457212541G00'

SELECT 
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 Obras.IdObra as [IdAux],
 Case When TipoObra=1 Then 'Taller' When TipoObra=2 Then 'Montaje' When TipoObra=3 Then 'Servicio' Else Null End as [Tipo obra],
 Obras.Descripcion as [Descripcion obra],
 Clientes.RazonSocial as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 Case When CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' Then Obras.FechaFinalizacion Else Null End as [Fecha finalizacion],
 UnidadesOperativas.Descripcion as [Unidad operativa],
 Empleados.Nombre as [Jefe de obra],
 Case When IsNull(Obras.Activa,'SI')='SI' Then 'SI' When IsNull(Obras.Activa,'SI')='NO' Then 'NO' Else 'SUSP.' End as [Activa?],
 Obras.Jerarquia as [Jerarquia contable],
 Obras.ParaInformes as [Para informes],
 Case When EXISTS((Select Top 1 * From DetalleObrasPolizas dop Where dop.IdObra=Obras.IdObra)) Then 'Con Poliza' Else Null End as [Poliza],
 Convert(varchar,IsNull(Obras.ValorObra,0))+' '+IsNull(Monedas.Abreviatura,'') as [Valor obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
LEFT OUTER JOIN Monedas ON Obras.IdMonedaValorObra = Monedas.IdMoneda
ORDER BY Obras.NumeroObra