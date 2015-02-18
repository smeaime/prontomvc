-- DetalleEmpleados->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleados_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleados]'))
ALTER TABLE [dbo].[DetalleEmpleados] DROP CONSTRAINT [FK_DetalleEmpleados_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleados]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleados_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleados] CHECK CONSTRAINT [FK_DetalleEmpleados_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleEmpleadosSectores->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleadosSectores_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleadosSectores]'))
ALTER TABLE [dbo].[DetalleEmpleadosSectores] DROP CONSTRAINT [FK_DetalleEmpleadosSectores_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleadosSectores]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleadosSectores_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleadosSectores] CHECK CONSTRAINT [FK_DetalleEmpleadosSectores_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleEmpleadosCuentasBancarias->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleadosCuentasBancarias_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleadosCuentasBancarias]'))
ALTER TABLE [dbo].[DetalleEmpleadosCuentasBancarias] DROP CONSTRAINT [FK_DetalleEmpleadosCuentasBancarias_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleadosCuentasBancarias]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleadosCuentasBancarias_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleadosCuentasBancarias] CHECK CONSTRAINT [FK_DetalleEmpleadosCuentasBancarias_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleEmpleadosJornadas->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleadosJornadas_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleadosJornadas]'))
ALTER TABLE [dbo].[DetalleEmpleadosJornadas] DROP CONSTRAINT [FK_DetalleEmpleadosJornadas_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleadosJornadas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleadosJornadas_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleadosJornadas] CHECK CONSTRAINT [FK_DetalleEmpleadosJornadas_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleEmpleadosObras->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleadosObras_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleadosObras]'))
ALTER TABLE [dbo].[DetalleEmpleadosObras] DROP CONSTRAINT [FK_DetalleEmpleadosObras_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleadosObras]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleadosObras_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleadosObras] CHECK CONSTRAINT [FK_DetalleEmpleadosObras_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleEmpleadosUbicaciones->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleEmpleadosUbicaciones_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleEmpleadosUbicaciones]'))
ALTER TABLE [dbo].[DetalleEmpleadosUbicaciones] DROP CONSTRAINT [FK_DetalleEmpleadosUbicaciones_Empleados]
GO
ALTER TABLE [dbo].[DetalleEmpleadosUbicaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleEmpleadosUbicaciones_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleEmpleadosUbicaciones] CHECK CONSTRAINT [FK_DetalleEmpleadosUbicaciones_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- EmpleadosAccesos->Empleados [IdEmpleado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EmpleadosAccesos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmpleadosAccesos]'))
ALTER TABLE [dbo].[EmpleadosAccesos] DROP CONSTRAINT [FK_EmpleadosAccesos_Empleados]
GO
ALTER TABLE [dbo].[EmpleadosAccesos]  WITH NOCHECK ADD  CONSTRAINT [FK_EmpleadosAccesos_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[EmpleadosAccesos] CHECK CONSTRAINT [FK_EmpleadosAccesos_Empleados]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Presupuestos->Empleados [IdComprador]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Empleados_IdComprador]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Empleados_IdComprador]
GO
ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Empleados_IdComprador] FOREIGN KEY([IdComprador])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Empleados_IdComprador]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Presupuestos->Empleados [Aprobo]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Empleados_Aprobo]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Empleados_Aprobo]
GO
ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Empleados_Aprobo] FOREIGN KEY([Aprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Empleados_Aprobo]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Requerimientos->Empleados [IdSolicito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados_IdSolicito]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados_IdSolicito]
GO
ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados_IdSolicito] FOREIGN KEY([IdSolicito])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados_IdSolicito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Requerimientos->Empleados [Aprobo]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados_Aprobo]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados_Aprobo]
GO
ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados_Aprobo] FOREIGN KEY([Aprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados_Aprobo]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Requerimientos->Empleados [IdComprador]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados_IdComprador]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados_IdComprador]
GO
ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados_IdComprador] FOREIGN KEY([IdComprador])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados_IdComprador]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Requerimientos->Empleados [IdAutorizoCumplido]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados_IdAutorizoCumplido]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados_IdAutorizoCumplido]
GO
ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados_IdAutorizoCumplido] FOREIGN KEY([IdAutorizoCumplido])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados_IdAutorizoCumplido]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Requerimientos->Empleados [IdDioPorCumplido]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados_IdDioPorCumplido]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados_IdDioPorCumplido]
GO
ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados_IdDioPorCumplido] FOREIGN KEY([IdDioPorCumplido])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados_IdDioPorCumplido]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Valores->TiposComprobante [IdTipoValor]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Valores_TiposComprobante_IdTipoValor]') AND parent_object_id = OBJECT_ID(N'[dbo].[Valores]'))
ALTER TABLE [dbo].[Valores] DROP CONSTRAINT [FK_Valores_TiposComprobante_IdTipoValor]
GO
ALTER TABLE [dbo].[Valores]  WITH NOCHECK ADD  CONSTRAINT [FK_Valores_TiposComprobante_IdTipoValor] FOREIGN KEY([IdTipoValor])
REFERENCES [dbo].[TiposComprobante] ([IdTipoComprobante])
GO
ALTER TABLE [dbo].[Valores] CHECK CONSTRAINT [FK_Valores_TiposComprobante_IdTipoValor]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Valores->TiposComprobante [IdTipoComprobante]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Valores_TiposComprobante_IdTipoComprobante]') AND parent_object_id = OBJECT_ID(N'[dbo].[Valores]'))
ALTER TABLE [dbo].[Valores] DROP CONSTRAINT [FK_Valores_TiposComprobante_IdTipoComprobante]
GO
ALTER TABLE [dbo].[Valores]  WITH NOCHECK ADD  CONSTRAINT [FK_Valores_TiposComprobante_IdTipoComprobante] FOREIGN KEY([IdTipoComprobante])
REFERENCES [dbo].[TiposComprobante] ([IdTipoComprobante])
GO
ALTER TABLE [dbo].[Valores] CHECK CONSTRAINT [FK_Valores_TiposComprobante_IdTipoComprobante]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Valores->Monedas [IdMoneda]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Valores_Monedas_IdMoneda]') AND parent_object_id = OBJECT_ID(N'[dbo].[Valores]'))
ALTER TABLE [dbo].[Valores] DROP CONSTRAINT [FK_Valores_Monedas_IdMoneda]
GO
ALTER TABLE [dbo].[Valores]  WITH NOCHECK ADD  CONSTRAINT [FK_Valores_Monedas_IdMoneda] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Valores] CHECK CONSTRAINT [FK_Valores_Monedas_IdMoneda]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesPago->OrdenesPago [IdOrdenPago]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPago_OrdenesPago]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPago]'))
ALTER TABLE [dbo].[DetalleOrdenesPago] DROP CONSTRAINT [FK_DetalleOrdenesPago_OrdenesPago]
GO
ALTER TABLE [dbo].[DetalleOrdenesPago]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPago_OrdenesPago] FOREIGN KEY([IdOrdenPago])
REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
GO
ALTER TABLE [dbo].[DetalleOrdenesPago] CHECK CONSTRAINT [FK_DetalleOrdenesPago_OrdenesPago]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesPagoCuentas->OrdenesPago [IdOrdenPago]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoCuentas_OrdenesPago]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoCuentas]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoCuentas] DROP CONSTRAINT [FK_DetalleOrdenesPagoCuentas_OrdenesPago]
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoCuentas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoCuentas_OrdenesPago] FOREIGN KEY([IdOrdenPago])
REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoCuentas] CHECK CONSTRAINT [FK_DetalleOrdenesPagoCuentas_OrdenesPago]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesPagoImpuestos->OrdenesPago [IdOrdenPago]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoImpuestos_OrdenesPago]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoImpuestos]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoImpuestos] DROP CONSTRAINT [FK_DetalleOrdenesPagoImpuestos_OrdenesPago]
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoImpuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoImpuestos_OrdenesPago] FOREIGN KEY([IdOrdenPago])
REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoImpuestos] CHECK CONSTRAINT [FK_DetalleOrdenesPagoImpuestos_OrdenesPago]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesPagoRubrosContables->OrdenesPago [IdOrdenPago]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoRubrosContables_OrdenesPago]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoRubrosContables]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables] DROP CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_OrdenesPago]
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_OrdenesPago] FOREIGN KEY([IdOrdenPago])
REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables] CHECK CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_OrdenesPago]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesPagoValores->OrdenesPago [IdOrdenPago]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoValores_OrdenesPago]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoValores]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoValores] DROP CONSTRAINT [FK_DetalleOrdenesPagoValores_OrdenesPago]
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoValores]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoValores_OrdenesPago] FOREIGN KEY([IdOrdenPago])
REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoValores] CHECK CONSTRAINT [FK_DetalleOrdenesPagoValores_OrdenesPago]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleAsientos->Asientos [IdAsiento]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleAsientos_Asientos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleAsientos]'))
ALTER TABLE [dbo].[DetalleAsientos] DROP CONSTRAINT [FK_DetalleAsientos_Asientos]
GO
ALTER TABLE [dbo].[DetalleAsientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleAsientos_Asientos] FOREIGN KEY([IdAsiento])
REFERENCES [dbo].[Asientos] ([IdAsiento])
GO
ALTER TABLE [dbo].[DetalleAsientos] CHECK CONSTRAINT [FK_DetalleAsientos_Asientos]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleConciliaciones->Conciliaciones [IdConciliacion]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleConciliaciones_Conciliaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleConciliaciones]'))
ALTER TABLE [dbo].[DetalleConciliaciones] DROP CONSTRAINT [FK_DetalleConciliaciones_Conciliaciones]
GO
ALTER TABLE [dbo].[DetalleConciliaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleConciliaciones_Conciliaciones] FOREIGN KEY([IdConciliacion])
REFERENCES [dbo].[Conciliaciones] ([IdConciliacion])
GO
ALTER TABLE [dbo].[DetalleConciliaciones] CHECK CONSTRAINT [FK_DetalleConciliaciones_Conciliaciones]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleConciliacionesNoContables->Conciliaciones [IdConciliacion]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleConciliacionesNoContables_Conciliaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleConciliacionesNoContables]'))
ALTER TABLE [dbo].[DetalleConciliacionesNoContables] DROP CONSTRAINT [FK_DetalleConciliacionesNoContables_Conciliaciones]
GO
ALTER TABLE [dbo].[DetalleConciliacionesNoContables]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleConciliacionesNoContables_Conciliaciones] FOREIGN KEY([IdConciliacion])
REFERENCES [dbo].[Conciliaciones] ([IdConciliacion])
GO
ALTER TABLE [dbo].[DetalleConciliacionesNoContables] CHECK CONSTRAINT [FK_DetalleConciliacionesNoContables_Conciliaciones]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- OrdenesPago->Proveedores [IdProveedor]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrdenesPago_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrdenesPago]'))
ALTER TABLE [dbo].[OrdenesPago] DROP CONSTRAINT [FK_OrdenesPago_Proveedores]
GO
ALTER TABLE [dbo].[OrdenesPago]  WITH NOCHECK ADD  CONSTRAINT [FK_OrdenesPago_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[OrdenesPago] CHECK CONSTRAINT [FK_OrdenesPago_Proveedores]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- OrdenesPago->Cuentas [IdCuenta]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrdenesPago_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrdenesPago]'))
ALTER TABLE [dbo].[OrdenesPago] DROP CONSTRAINT [FK_OrdenesPago_Cuentas]
GO
ALTER TABLE [dbo].[OrdenesPago]  WITH NOCHECK ADD  CONSTRAINT [FK_OrdenesPago_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[OrdenesPago] CHECK CONSTRAINT [FK_OrdenesPago_Cuentas]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleClientesDirecciones->Clientes [IdCliente]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleClientesDirecciones_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleClientesDirecciones]'))
ALTER TABLE [dbo].[DetalleClientesDirecciones] DROP CONSTRAINT [FK_DetalleClientesDirecciones_Clientes]
GO
ALTER TABLE [dbo].[DetalleClientesDirecciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleClientesDirecciones_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[DetalleClientesDirecciones] CHECK CONSTRAINT [FK_DetalleClientesDirecciones_Clientes]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleClientesTelefonos->Clientes [IdCliente]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleClientesTelefonos_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleClientesTelefonos]'))
ALTER TABLE [dbo].[DetalleClientesTelefonos] DROP CONSTRAINT [FK_DetalleClientesTelefonos_Clientes]
GO
ALTER TABLE [dbo].[DetalleClientesTelefonos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleClientesTelefonos_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[DetalleClientesTelefonos] CHECK CONSTRAINT [FK_DetalleClientesTelefonos_Clientes]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleObrasPolizas->Obras [IdObra]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleObrasPolizas_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleObrasPolizas]'))
ALTER TABLE [dbo].[DetalleObrasPolizas] DROP CONSTRAINT [FK_DetalleObrasPolizas_Obras]
GO
ALTER TABLE [dbo].[DetalleObrasPolizas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleObrasPolizas_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleObrasPolizas] CHECK CONSTRAINT [FK_DetalleObrasPolizas_Obras]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleObrasEquiposInstalados->Obras [IdObra]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleObrasEquiposInstalados_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleObrasEquiposInstalados]'))
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados] DROP CONSTRAINT [FK_DetalleObrasEquiposInstalados_Obras]
GO
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleObrasEquiposInstalados_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados] CHECK CONSTRAINT [FK_DetalleObrasEquiposInstalados_Obras]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleObrasEquiposInstalados2->Obras [IdObra]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleObrasEquiposInstalados2_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleObrasEquiposInstalados2]'))
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados2] DROP CONSTRAINT [FK_DetalleObrasEquiposInstalados2_Obras]
GO
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados2]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleObrasEquiposInstalados2_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleObrasEquiposInstalados2] CHECK CONSTRAINT [FK_DetalleObrasEquiposInstalados2_Obras]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasDebito->NotasDebito [IdNotaDebito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasDebito_NotasDebito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasDebito]'))
ALTER TABLE [dbo].[DetalleNotasDebito] DROP CONSTRAINT [FK_DetalleNotasDebito_NotasDebito]
GO
ALTER TABLE [dbo].[DetalleNotasDebito]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasDebito_NotasDebito] FOREIGN KEY([IdNotaDebito])
REFERENCES [dbo].[NotasDebito] ([IdNotaDebito])
GO
ALTER TABLE [dbo].[DetalleNotasDebito] CHECK CONSTRAINT [FK_DetalleNotasDebito_NotasDebito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasDebitoProvincias->NotasDebito [IdNotaDebito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasDebitoProvincias_NotasDebito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasDebitoProvincias]'))
ALTER TABLE [dbo].[DetalleNotasDebitoProvincias] DROP CONSTRAINT [FK_DetalleNotasDebitoProvincias_NotasDebito]
GO
ALTER TABLE [dbo].[DetalleNotasDebitoProvincias]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasDebitoProvincias_NotasDebito] FOREIGN KEY([IdNotaDebito])
REFERENCES [dbo].[NotasDebito] ([IdNotaDebito])
GO
ALTER TABLE [dbo].[DetalleNotasDebitoProvincias] CHECK CONSTRAINT [FK_DetalleNotasDebitoProvincias_NotasDebito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasCredito->NotasCredito [IdNotaCredito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasCredito_NotasCredito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasCredito]'))
ALTER TABLE [dbo].[DetalleNotasCredito] DROP CONSTRAINT [FK_DetalleNotasCredito_NotasCredito]
GO
ALTER TABLE [dbo].[DetalleNotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasCredito_NotasCredito] FOREIGN KEY([IdNotaCredito])
REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
GO
ALTER TABLE [dbo].[DetalleNotasCredito] CHECK CONSTRAINT [FK_DetalleNotasCredito_NotasCredito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasCreditoImputaciones->NotasCredito [IdNotaCredito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasCreditoImputaciones_NotasCredito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasCreditoImputaciones]'))
ALTER TABLE [dbo].[DetalleNotasCreditoImputaciones] DROP CONSTRAINT [FK_DetalleNotasCreditoImputaciones_NotasCredito]
GO
ALTER TABLE [dbo].[DetalleNotasCreditoImputaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasCreditoImputaciones_NotasCredito] FOREIGN KEY([IdNotaCredito])
REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
GO
ALTER TABLE [dbo].[DetalleNotasCreditoImputaciones] CHECK CONSTRAINT [FK_DetalleNotasCreditoImputaciones_NotasCredito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasCreditoOrdenesCompra->NotasCredito [IdNotaCredito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasCreditoOrdenesCompra_NotasCredito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasCreditoOrdenesCompra]'))
ALTER TABLE [dbo].[DetalleNotasCreditoOrdenesCompra] DROP CONSTRAINT [FK_DetalleNotasCreditoOrdenesCompra_NotasCredito]
GO
ALTER TABLE [dbo].[DetalleNotasCreditoOrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasCreditoOrdenesCompra_NotasCredito] FOREIGN KEY([IdNotaCredito])
REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
GO
ALTER TABLE [dbo].[DetalleNotasCreditoOrdenesCompra] CHECK CONSTRAINT [FK_DetalleNotasCreditoOrdenesCompra_NotasCredito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleNotasCreditoProvincias->NotasCredito [IdNotaCredito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasCreditoProvincias_NotasCredito]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasCreditoProvincias]'))
ALTER TABLE [dbo].[DetalleNotasCreditoProvincias] DROP CONSTRAINT [FK_DetalleNotasCreditoProvincias_NotasCredito]
GO
ALTER TABLE [dbo].[DetalleNotasCreditoProvincias]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasCreditoProvincias_NotasCredito] FOREIGN KEY([IdNotaCredito])
REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
GO
ALTER TABLE [dbo].[DetalleNotasCreditoProvincias] CHECK CONSTRAINT [FK_DetalleNotasCreditoProvincias_NotasCredito]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleDevoluciones->Devoluciones [IdDevolucion]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleDevoluciones_Devoluciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleDevoluciones]'))
ALTER TABLE [dbo].[DetalleDevoluciones] DROP CONSTRAINT [FK_DetalleDevoluciones_Devoluciones]
GO
ALTER TABLE [dbo].[DetalleDevoluciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleDevoluciones_Devoluciones] FOREIGN KEY([IdDevolucion])
REFERENCES [dbo].[Devoluciones] ([IdDevolucion])
GO
ALTER TABLE [dbo].[DetalleDevoluciones] CHECK CONSTRAINT [FK_DetalleDevoluciones_Devoluciones]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleOrdenesCompra->OrdenesCompra [IdOrdenCompra]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesCompra_OrdenesCompra]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesCompra]'))
ALTER TABLE [dbo].[DetalleOrdenesCompra] DROP CONSTRAINT [FK_DetalleOrdenesCompra_OrdenesCompra]
GO
ALTER TABLE [dbo].[DetalleOrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesCompra_OrdenesCompra] FOREIGN KEY([IdOrdenCompra])
REFERENCES [dbo].[OrdenesCompra] ([IdOrdenCompra])
GO
ALTER TABLE [dbo].[DetalleOrdenesCompra] CHECK CONSTRAINT [FK_DetalleOrdenesCompra_OrdenesCompra]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Ubicaciones->Depositos [IdDeposito]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ubicaciones_Depositos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ubicaciones]'))
ALTER TABLE [dbo].[Ubicaciones] DROP CONSTRAINT [FK_Ubicaciones_Depositos]
GO
ALTER TABLE [dbo].[Ubicaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Ubicaciones_Depositos] FOREIGN KEY([IdDeposito])
REFERENCES [dbo].[Depositos] ([IdDeposito])
GO
ALTER TABLE [dbo].[Ubicaciones] CHECK CONSTRAINT [FK_Ubicaciones_Depositos]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- Proveedores->Estados Proveedores [IdEstado]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Proveedores_EstadosProveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Estados Proveedores]'))
ALTER TABLE [dbo].[Proveedores] DROP CONSTRAINT [FK_Proveedores_EstadosProveedores]
GO
ALTER TABLE [dbo].[Proveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_Proveedores_EstadosProveedores] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estados Proveedores] ([IdEstado])
GO
ALTER TABLE [dbo].[Proveedores] CHECK CONSTRAINT [FK_Proveedores_EstadosProveedores]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleConjuntos->Conjuntos [IdConjunto]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleConjuntos_Conjuntos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleConjuntos]'))
ALTER TABLE [dbo].[DetalleConjuntos] DROP CONSTRAINT [FK_DetalleConjuntos_Conjuntos]
GO
ALTER TABLE [dbo].[DetalleConjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleConjuntos_Conjuntos] FOREIGN KEY([IdConjunto])
REFERENCES [dbo].[Conjuntos] ([IdConjunto])
GO
ALTER TABLE [dbo].[DetalleConjuntos] CHECK CONSTRAINT [FK_DetalleConjuntos_Conjuntos]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleFacturas->Facturas [IdFactura]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleFacturas_Facturas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleFacturas]'))
ALTER TABLE [dbo].[DetalleFacturas] DROP CONSTRAINT [FK_DetalleFacturas_Facturas]
GO
ALTER TABLE [dbo].[DetalleFacturas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleFacturas_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[DetalleFacturas] CHECK CONSTRAINT [FK_DetalleFacturas_Facturas]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleFacturasOrdenesCompra->Facturas [IdFactura]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleFacturasOrdenesCompra_Facturas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleFacturasOrdenesCompra]'))
ALTER TABLE [dbo].[DetalleFacturasOrdenesCompra] DROP CONSTRAINT [FK_DetalleFacturasOrdenesCompra_Facturas]
GO
ALTER TABLE [dbo].[DetalleFacturasOrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleFacturasOrdenesCompra_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[DetalleFacturasOrdenesCompra] CHECK CONSTRAINT [FK_DetalleFacturasOrdenesCompra_Facturas]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleFacturasRemitos->Facturas [IdFactura]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleFacturasRemitos_Facturas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleFacturasRemitos]'))
ALTER TABLE [dbo].[DetalleFacturasRemitos] DROP CONSTRAINT [FK_DetalleFacturasRemitos_Facturas]
GO
ALTER TABLE [dbo].[DetalleFacturasRemitos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleFacturasRemitos_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[DetalleFacturasRemitos] CHECK CONSTRAINT [FK_DetalleFacturasRemitos_Facturas]
GO
------------------------------------------------------------------------------------------------------------------------------------------

-- DetalleFacturasProvincias->Facturas [IdFactura]
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleFacturasProvincias_Facturas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleFacturasProvincias]'))
ALTER TABLE [dbo].[DetalleFacturasProvincias] DROP CONSTRAINT [FK_DetalleFacturasProvincias_Facturas]
GO
ALTER TABLE [dbo].[DetalleFacturasProvincias]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleFacturasProvincias_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[DetalleFacturasProvincias] CHECK CONSTRAINT [FK_DetalleFacturasProvincias_Facturas]
GO
------------------------------------------------------------------------------------------------------------------------------------------
