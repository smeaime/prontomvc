CREATE Procedure [dbo].[Obras_TX_TT]

@IdObra int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111111111111133'
set @vector_T='0793123457212541G00'

SELECT 
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 Obras.IdObra as [IdAux],
 CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [Tipo obra],
 Obras.Descripcion as [Descripcion obra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion],
 UnidadesOperativas.Descripcion as [Unidad operativa],
 Empleados.Nombre as [Jefe de obra],
 Obras.Activa as [Activa?],
 Obras.Jerarquia as [Jerarquia contable],
 Obras.ParaInformes as [Para informes],
 CASE WHEN EXISTS((Select Top 1 * From DetalleObrasPolizas dop Where dop.IdObra=Obras.IdObra))
	THEN 'Con Poliza'
	ELSE Null
 END as [Poliza],
 Convert(varchar,IsNull(Obras.ValorObra,0))+' '+IsNull(Monedas.Abreviatura,'') as [Valor obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
LEFT OUTER JOIN Monedas ON Obras.IdMonedaValorObra = Monedas.IdMoneda
WHERE (IdObra=@IdObra)