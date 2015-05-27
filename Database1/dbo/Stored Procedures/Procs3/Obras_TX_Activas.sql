CREATE Procedure [dbo].[Obras_TX_Activas]

@SoloConPresupuestoObra varchar(2) = Null,
@Estado varchar(2) = Null,
@IdUsuario int = Null

AS 

SET @SoloConPresupuestoObra=IsNull(@SoloConPresupuestoObra,'')
SET @Estado=IsNull(@Estado,'SI')
SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111133'
SET @vector_T='0793123457212541G00'

SELECT 
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 Obras.IdObra as [IdAux],
 Case When TipoObra=1 Then 'Taller' When TipoObra=2 Then 'Montaje' When TipoObra=3 Then 'Servicio' Else Null End as [Tipo obra],
 Obras.Descripcion as [Descripcion obra],
 Clientes.Codigo as [Codigo],
 Clientes.RazonSocial as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 Case When Convert(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' Then Obras.FechaFinalizacion Else Null End as [Fecha finalizacion],
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
WHERE IsNull(Obras.Activa,'SI')=@Estado and (@SoloConPresupuestoObra<>'SI' or (@SoloConPresupuestoObra='SI' and IsNull(Obras.ActivarPresupuestoObra,'NO')='SI')) and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Obras.IdObra))
ORDER BY Obras.NumeroObra