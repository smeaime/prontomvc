IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AjustesStock_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[AjustesStock]'))
ALTER TABLE [dbo].[AjustesStock] DROP CONSTRAINT [FK_AjustesStock_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AjustesStock_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[AjustesStock]'))
ALTER TABLE [dbo].[AjustesStock] DROP CONSTRAINT [FK_AjustesStock_Empleados1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AjustesStock_Empleados2]') AND parent_object_id = OBJECT_ID(N'[dbo].[AjustesStock]'))
ALTER TABLE [dbo].[AjustesStock] DROP CONSTRAINT [FK_AjustesStock_Empleados2]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AjustesStock_Empleados3]') AND parent_object_id = OBJECT_ID(N'[dbo].[AjustesStock]'))
ALTER TABLE [dbo].[AjustesStock] DROP CONSTRAINT [FK_AjustesStock_Empleados3]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AjustesStockSAT_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[AjustesStockSAT]'))
ALTER TABLE [dbo].[AjustesStockSAT] DROP CONSTRAINT [FK_AjustesStockSAT_Empleados]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_AnticiposAlPersonal_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnticiposAlPersonal]'))
ALTER TABLE [dbo].[AnticiposAlPersonal] DROP CONSTRAINT [FK_AnticiposAlPersonal_Empleados]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Biselados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Biselados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Calidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Calidades]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Cuentas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Cuentas1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Cuentas1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Cuentas2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Cuentas2]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Rubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Rubros]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Subrubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Subrubros]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_TiposRosca]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_TiposRosca]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Articulos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[Articulos]'))
ALTER TABLE [dbo].[Articulos] DROP CONSTRAINT [FK_Articulos_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asientos_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asientos]'))
ALTER TABLE [dbo].[Asientos] DROP CONSTRAINT [FK_Asientos_Cuentas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asientos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asientos]'))
ALTER TABLE [dbo].[Asientos] DROP CONSTRAINT [FK_Asientos_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Asientos_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Asientos]'))
ALTER TABLE [dbo].[Asientos] DROP CONSTRAINT [FK_Asientos_Empleados1]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BancoChequeras_Bancos]') AND parent_object_id = OBJECT_ID(N'[dbo].[BancoChequeras]'))
ALTER TABLE [dbo].[BancoChequeras] DROP CONSTRAINT [FK_BancoChequeras_Bancos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bancos_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bancos]'))
ALTER TABLE [dbo].[Bancos] DROP CONSTRAINT [FK_Bancos_Cuentas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bancos_Cuentas1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bancos]'))
ALTER TABLE [dbo].[Bancos] DROP CONSTRAINT [FK_Bancos_Cuentas1]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Cuentas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Empleados1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Localidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Localidades]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Paises]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Paises]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Clientes_Provincias]') AND parent_object_id = OBJECT_ID(N'[dbo].[Clientes]'))
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Provincias]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Comparativas_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Comparativas]'))
ALTER TABLE [dbo].[Comparativas] DROP CONSTRAINT [FK_Comparativas_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Comparativas_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Comparativas]'))
ALTER TABLE [dbo].[Comparativas] DROP CONSTRAINT [FK_Comparativas_Empleados1]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Condiciones Compra]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Condiciones Compra]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Empleados1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ComprobantesProveedores_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[ComprobantesProveedores]'))
ALTER TABLE [dbo].[ComprobantesProveedores] DROP CONSTRAINT [FK_ComprobantesProveedores_Proveedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conceptos_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conceptos]'))
ALTER TABLE [dbo].[Conceptos] DROP CONSTRAINT [FK_Conceptos_Cuentas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conciliaciones_CuentasBancarias]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conciliaciones]'))
ALTER TABLE [dbo].[Conciliaciones] DROP CONSTRAINT [FK_Conciliaciones_CuentasBancarias]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conciliaciones_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conciliaciones]'))
ALTER TABLE [dbo].[Conciliaciones] DROP CONSTRAINT [FK_Conciliaciones_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conciliaciones_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conciliaciones]'))
ALTER TABLE [dbo].[Conciliaciones] DROP CONSTRAINT [FK_Conciliaciones_Empleados1]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conjuntos_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conjuntos]'))
ALTER TABLE [dbo].[Conjuntos] DROP CONSTRAINT [FK_Conjuntos_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conjuntos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conjuntos]'))
ALTER TABLE [dbo].[Conjuntos] DROP CONSTRAINT [FK_Conjuntos_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Conjuntos_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[Conjuntos]'))
ALTER TABLE [dbo].[Conjuntos] DROP CONSTRAINT [FK_Conjuntos_Obras]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Cotizaciones_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Cotizaciones]'))
ALTER TABLE [dbo].[Cotizaciones] DROP CONSTRAINT [FK_Cotizaciones_Monedas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasBancarias_Bancos]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasBancarias]'))
ALTER TABLE [dbo].[CuentasBancarias] DROP CONSTRAINT [FK_CuentasBancarias_Bancos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasBancarias_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasBancarias]'))
ALTER TABLE [dbo].[CuentasBancarias] DROP CONSTRAINT [FK_CuentasBancarias_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasBancarias_Provincias]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasBancarias]'))
ALTER TABLE [dbo].[CuentasBancarias] DROP CONSTRAINT [FK_CuentasBancarias_Provincias]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasCorrientesAcreedores_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasCorrientesAcreedores]'))
ALTER TABLE [dbo].[CuentasCorrientesAcreedores] DROP CONSTRAINT [FK_CuentasCorrientesAcreedores_Proveedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CuentasCorrientesDeudores_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[CuentasCorrientesDeudores]'))
ALTER TABLE [dbo].[CuentasCorrientesDeudores] DROP CONSTRAINT [FK_CuentasCorrientesDeudores_Clientes]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DefinicionArticulos_Rubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[DefinicionArticulos]'))
ALTER TABLE [dbo].[DefinicionArticulos] DROP CONSTRAINT [FK_DefinicionArticulos_Rubros]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DefinicionArticulos_Subrubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[DefinicionArticulos]'))
ALTER TABLE [dbo].[DefinicionArticulos] DROP CONSTRAINT [FK_DefinicionArticulos_Subrubros]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleAjustesStock_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleAjustesStock]'))
ALTER TABLE [dbo].[DetalleAjustesStock] DROP CONSTRAINT [FK_DetalleAjustesStock_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleAjustesStock_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleAjustesStock]'))
ALTER TABLE [dbo].[DetalleAjustesStock] DROP CONSTRAINT [FK_DetalleAjustesStock_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleAjustesStock_Ubicaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleAjustesStock]'))
ALTER TABLE [dbo].[DetalleAjustesStock] DROP CONSTRAINT [FK_DetalleAjustesStock_Ubicaciones]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleAsientos_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleAsientos]'))
ALTER TABLE [dbo].[DetalleAsientos] DROP CONSTRAINT [FK_DetalleAsientos_Cuentas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleClientesLugaresEntrega_Localidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleClientesLugaresEntrega]'))
ALTER TABLE [dbo].[DetalleClientesLugaresEntrega] DROP CONSTRAINT [FK_DetalleClientesLugaresEntrega_Localidades]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleClientesLugaresEntrega_Provincias]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleClientesLugaresEntrega]'))
ALTER TABLE [dbo].[DetalleClientesLugaresEntrega] DROP CONSTRAINT [FK_DetalleClientesLugaresEntrega_Provincias]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleComparativas_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleComparativas]'))
ALTER TABLE [dbo].[DetalleComparativas] DROP CONSTRAINT [FK_DetalleComparativas_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleComparativas_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleComparativas]'))
ALTER TABLE [dbo].[DetalleComparativas] DROP CONSTRAINT [FK_DetalleComparativas_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleComparativas_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleComparativas]'))
ALTER TABLE [dbo].[DetalleComparativas] DROP CONSTRAINT [FK_DetalleComparativas_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleConjuntos_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleConjuntos]'))
ALTER TABLE [dbo].[DetalleConjuntos] DROP CONSTRAINT [FK_DetalleConjuntos_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleConjuntos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleConjuntos]'))
ALTER TABLE [dbo].[DetalleConjuntos] DROP CONSTRAINT [FK_DetalleConjuntos_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleCuentas_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleCuentas]'))
ALTER TABLE [dbo].[DetalleCuentas] DROP CONSTRAINT [FK_DetalleCuentas_Cuentas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleDevoluciones_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleDevoluciones]'))
ALTER TABLE [dbo].[DetalleDevoluciones] DROP CONSTRAINT [FK_DetalleDevoluciones_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleDevoluciones_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleDevoluciones]'))
ALTER TABLE [dbo].[DetalleDevoluciones] DROP CONSTRAINT [FK_DetalleDevoluciones_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleFacturas_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleFacturas]'))
ALTER TABLE [dbo].[DetalleFacturas] DROP CONSTRAINT [FK_DetalleFacturas_Articulos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasCredito_Conceptos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasCredito]'))
ALTER TABLE [dbo].[DetalleNotasCredito] DROP CONSTRAINT [FK_DetalleNotasCredito_Conceptos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotasDebito_Conceptos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotasDebito]'))
ALTER TABLE [dbo].[DetalleNotasDebito] DROP CONSTRAINT [FK_DetalleNotasDebito_Conceptos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesCompra_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesCompra]'))
ALTER TABLE [dbo].[DetalleOrdenesCompra] DROP CONSTRAINT [FK_DetalleOrdenesCompra_Articulos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoRubrosContables_RubrosContables]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoRubrosContables]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables] DROP CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_RubrosContables]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOrdenesPagoValores_BancoChequeras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenesPagoValores]'))
ALTER TABLE [dbo].[DetalleOrdenesPagoValores] DROP CONSTRAINT [FK_DetalleOrdenesPagoValores_BancoChequeras]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOtrosIngresosAlmacen_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOtrosIngresosAlmacen]'))
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] DROP CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOtrosIngresosAlmacen_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOtrosIngresosAlmacen]'))
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] DROP CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOtrosIngresosAlmacen_Ubicaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOtrosIngresosAlmacen]'))
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] DROP CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Ubicaciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleOtrosIngresosAlmacen_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleOtrosIngresosAlmacen]'))
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] DROP CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePedidos_Pedidos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePedidos]'))
ALTER TABLE [dbo].[DetallePedidos] DROP CONSTRAINT [FK_DetallePedidos_Pedidos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePedidos_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePedidos]'))
ALTER TABLE [dbo].[DetallePedidos] DROP CONSTRAINT [FK_DetallePedidos_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePedidos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePedidos]'))
ALTER TABLE [dbo].[DetallePedidos] DROP CONSTRAINT [FK_DetallePedidos_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePresupuestos_Presupuestos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePresupuestos]'))
ALTER TABLE [dbo].[DetallePresupuestos] DROP CONSTRAINT [FK_DetallePresupuestos_Presupuestos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePresupuestos_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePresupuestos]'))
ALTER TABLE [dbo].[DetallePresupuestos] DROP CONSTRAINT [FK_DetallePresupuestos_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePresupuestos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePresupuestos]'))
ALTER TABLE [dbo].[DetallePresupuestos] DROP CONSTRAINT [FK_DetallePresupuestos_Unidades]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetallePresupuestos_DetalleRequerimientos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetallePresupuestos]'))
ALTER TABLE [dbo].[DetallePresupuestos] DROP CONSTRAINT [FK_DetallePresupuestos_DetalleRequerimientos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedores_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedores]'))
ALTER TABLE [dbo].[DetalleProveedores] DROP CONSTRAINT [FK_DetalleProveedores_Proveedores]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedoresIB_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedoresIB]'))
ALTER TABLE [dbo].[DetalleProveedoresIB] DROP CONSTRAINT [FK_DetalleProveedoresIB_Proveedores]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedoresIB_IBCondiciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedoresIB]'))
ALTER TABLE [dbo].[DetalleProveedoresIB] DROP CONSTRAINT [FK_DetalleProveedoresIB_IBCondiciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedoresRubros_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedoresRubros]'))
ALTER TABLE [dbo].[DetalleProveedoresRubros] DROP CONSTRAINT [FK_DetalleProveedoresRubros_Proveedores]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedoresRubros_Rubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedoresRubros]'))
ALTER TABLE [dbo].[DetalleProveedoresRubros] DROP CONSTRAINT [FK_DetalleProveedoresRubros_Rubros]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleProveedoresRubros_Subrubros]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleProveedoresRubros]'))
ALTER TABLE [dbo].[DetalleProveedoresRubros] DROP CONSTRAINT [FK_DetalleProveedoresRubros_Subrubros]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRecepciones_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRecepciones]'))
ALTER TABLE [dbo].[DetalleRecepciones] DROP CONSTRAINT [FK_DetalleRecepciones_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRecepciones_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRecepciones]'))
ALTER TABLE [dbo].[DetalleRecepciones] DROP CONSTRAINT [FK_DetalleRecepciones_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRecepciones_Ubicaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRecepciones]'))
ALTER TABLE [dbo].[DetalleRecepciones] DROP CONSTRAINT [FK_DetalleRecepciones_Ubicaciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRecepciones_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRecepciones]'))
ALTER TABLE [dbo].[DetalleRecepciones] DROP CONSTRAINT [FK_DetalleRecepciones_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRemitos_Articulos1]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRemitos]'))
ALTER TABLE [dbo].[DetalleRemitos] DROP CONSTRAINT [FK_DetalleRemitos_Articulos1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRemitos_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRemitos]'))
ALTER TABLE [dbo].[DetalleRemitos] DROP CONSTRAINT [FK_DetalleRemitos_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRemitos_Ubicaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRemitos]'))
ALTER TABLE [dbo].[DetalleRemitos] DROP CONSTRAINT [FK_DetalleRemitos_Ubicaciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRemitos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRemitos]'))
ALTER TABLE [dbo].[DetalleRemitos] DROP CONSTRAINT [FK_DetalleRemitos_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRequerimientos_Requerimientos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRequerimientos]'))
ALTER TABLE [dbo].[DetalleRequerimientos] DROP CONSTRAINT [FK_DetalleRequerimientos_Requerimientos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRequerimientos_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRequerimientos]'))
ALTER TABLE [dbo].[DetalleRequerimientos] DROP CONSTRAINT [FK_DetalleRequerimientos_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRequerimientos_ControlesCalidad]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRequerimientos]'))
ALTER TABLE [dbo].[DetalleRequerimientos] DROP CONSTRAINT [FK_DetalleRequerimientos_ControlesCalidad]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleRequerimientos_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleRequerimientos]'))
ALTER TABLE [dbo].[DetalleRequerimientos] DROP CONSTRAINT [FK_DetalleRequerimientos_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleSalidasMateriales_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleSalidasMateriales]'))
ALTER TABLE [dbo].[DetalleSalidasMateriales] DROP CONSTRAINT [FK_DetalleSalidasMateriales_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleSalidasMateriales_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleSalidasMateriales]'))
ALTER TABLE [dbo].[DetalleSalidasMateriales] DROP CONSTRAINT [FK_DetalleSalidasMateriales_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleSalidasMateriales_Ubicaciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleSalidasMateriales]'))
ALTER TABLE [dbo].[DetalleSalidasMateriales] DROP CONSTRAINT [FK_DetalleSalidasMateriales_Ubicaciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleSalidasMateriales_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleSalidasMateriales]'))
ALTER TABLE [dbo].[DetalleSalidasMateriales] DROP CONSTRAINT [FK_DetalleSalidasMateriales_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleValesSalida_Articulos]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleValesSalida]'))
ALTER TABLE [dbo].[DetalleValesSalida] DROP CONSTRAINT [FK_DetalleValesSalida_Articulos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleValesSalida_Unidades]') AND parent_object_id = OBJECT_ID(N'[dbo].[DetalleValesSalida]'))
ALTER TABLE [dbo].[DetalleValesSalida] DROP CONSTRAINT [FK_DetalleValesSalida_Unidades]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Devoluciones_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Devoluciones]'))
ALTER TABLE [dbo].[Devoluciones] DROP CONSTRAINT [FK_Devoluciones_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Devoluciones_Vendedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Devoluciones]'))
ALTER TABLE [dbo].[Devoluciones] DROP CONSTRAINT [FK_Devoluciones_Vendedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleados_Cargos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleados]'))
ALTER TABLE [dbo].[Empleados] DROP CONSTRAINT [FK_Empleados_Cargos]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleados_Sectores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleados]'))
ALTER TABLE [dbo].[Empleados] DROP CONSTRAINT [FK_Empleados_Sectores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [FK_Facturas_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [FK_Facturas_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [FK_Facturas_Monedas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FondosFijos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[FondosFijos]'))
ALTER TABLE [dbo].[FondosFijos] DROP CONSTRAINT [FK_FondosFijos_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FondosFijos_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[FondosFijos]'))
ALTER TABLE [dbo].[FondosFijos] DROP CONSTRAINT [FK_FondosFijos_Proveedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ganancias_TiposRetencionGanancia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ganancias]'))
ALTER TABLE [dbo].[Ganancias] DROP CONSTRAINT [FK_Ganancias_TiposRetencionGanancia]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasCredito_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasCredito]'))
ALTER TABLE [dbo].[NotasCredito] DROP CONSTRAINT [FK_NotasCredito_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasCredito_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasCredito]'))
ALTER TABLE [dbo].[NotasCredito] DROP CONSTRAINT [FK_NotasCredito_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasCredito_IBCondiciones]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasCredito]'))
ALTER TABLE [dbo].[NotasCredito] DROP CONSTRAINT [FK_NotasCredito_IBCondiciones]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasCredito_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasCredito]'))
ALTER TABLE [dbo].[NotasCredito] DROP CONSTRAINT [FK_NotasCredito_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasCredito_PuntosVenta]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasCredito]'))
ALTER TABLE [dbo].[NotasCredito] DROP CONSTRAINT [FK_NotasCredito_PuntosVenta]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasDebito_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasDebito]'))
ALTER TABLE [dbo].[NotasDebito] DROP CONSTRAINT [FK_NotasDebito_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasDebito_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasDebito]'))
ALTER TABLE [dbo].[NotasDebito] DROP CONSTRAINT [FK_NotasDebito_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasDebito_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasDebito]'))
ALTER TABLE [dbo].[NotasDebito] DROP CONSTRAINT [FK_NotasDebito_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotasDebito_PuntosVenta]') AND parent_object_id = OBJECT_ID(N'[dbo].[NotasDebito]'))
ALTER TABLE [dbo].[NotasDebito] DROP CONSTRAINT [FK_NotasDebito_PuntosVenta]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrdenesCompra_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrdenesCompra]'))
ALTER TABLE [dbo].[OrdenesCompra] DROP CONSTRAINT [FK_OrdenesCompra_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrdenesCompra_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrdenesCompra]'))
ALTER TABLE [dbo].[OrdenesCompra] DROP CONSTRAINT [FK_OrdenesCompra_Monedas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pedidos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Pedidos]'))
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK_Pedidos_Empleados]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pedidos_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Pedidos]'))
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK_Pedidos_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Pedidos_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Pedidos]'))
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK_Pedidos_Proveedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PlazosFijos_Bancos]') AND parent_object_id = OBJECT_ID(N'[dbo].[PlazosFijos]'))
ALTER TABLE [dbo].[PlazosFijos] DROP CONSTRAINT [FK_PlazosFijos_Bancos]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Condiciones Compra]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Condiciones Compra]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Monedas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Monedas]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Proveedores]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_PlazosEntrega]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_PlazosEntrega]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Empleados1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Presupuestos_Empleados2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Presupuestos]'))
ALTER TABLE [dbo].[Presupuestos] DROP CONSTRAINT [FK_Presupuestos_Empleados2]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Provincias_Paises]') AND parent_object_id = OBJECT_ID(N'[dbo].[Provincias]'))
ALTER TABLE [dbo].[Provincias] DROP CONSTRAINT [FK_Provincias_Paises]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Recepciones_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Recepciones]'))
ALTER TABLE [dbo].[Recepciones] DROP CONSTRAINT [FK_Recepciones_Proveedores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Recibos_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Recibos]'))
ALTER TABLE [dbo].[Recibos] DROP CONSTRAINT [FK_Recibos_Clientes]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Remitos_Clientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Remitos]'))
ALTER TABLE [dbo].[Remitos] DROP CONSTRAINT [FK_Remitos_Clientes]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Remitos_Proveedores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Remitos]'))
ALTER TABLE [dbo].[Remitos] DROP CONSTRAINT [FK_Remitos_Proveedores]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Remitos_PuntosVenta]') AND parent_object_id = OBJECT_ID(N'[dbo].[Remitos]'))
ALTER TABLE [dbo].[Remitos] DROP CONSTRAINT [FK_Remitos_PuntosVenta]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Obras]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Obras]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Empleados2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Empleados2]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Requerimientos_Sectores]') AND parent_object_id = OBJECT_ID(N'[dbo].[Requerimientos]'))
ALTER TABLE [dbo].[Requerimientos] DROP CONSTRAINT [FK_Requerimientos_Sectores]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Rubros_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Rubros]'))
ALTER TABLE [dbo].[Rubros] DROP CONSTRAINT [FK_Rubros_Cuentas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Subdiarios_Cuentas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Subdiarios]'))
ALTER TABLE [dbo].[Subdiarios] DROP CONSTRAINT [FK_Subdiarios_Cuentas]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ubicaciones_Depositos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ubicaciones]'))
ALTER TABLE [dbo].[Ubicaciones] DROP CONSTRAINT [FK_Ubicaciones_Depositos]
GO
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Vendedores_LocalidadID]') AND type = 'D')
ALTER TABLE [dbo].[Vendedores] DROP CONSTRAINT [DF_Vendedores_LocalidadID]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Vendedores_IdProvincia]') AND type = 'D')
ALTER TABLE [dbo].[Vendedores] DROP CONSTRAINT [DF_Vendedores_IdProvincia]
GO


ALTER TABLE [dbo].[AjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_AjustesStock_Empleados] FOREIGN KEY([IdAprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AjustesStock] CHECK CONSTRAINT [FK_AjustesStock_Empleados]
GO

ALTER TABLE [dbo].[AjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_AjustesStock_Empleados1] FOREIGN KEY([IdRealizo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AjustesStock] CHECK CONSTRAINT [FK_AjustesStock_Empleados1]
GO

ALTER TABLE [dbo].[AjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_AjustesStock_Empleados2] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AjustesStock] CHECK CONSTRAINT [FK_AjustesStock_Empleados2]
GO

ALTER TABLE [dbo].[AjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_AjustesStock_Empleados3] FOREIGN KEY([IdUsuarioModifico])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AjustesStock] CHECK CONSTRAINT [FK_AjustesStock_Empleados3]
GO


ALTER TABLE [dbo].[AjustesStockSAT]  WITH NOCHECK ADD  CONSTRAINT [FK_AjustesStockSAT_Empleados] FOREIGN KEY([IdAprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AjustesStockSAT] CHECK CONSTRAINT [FK_AjustesStockSAT_Empleados]
GO


ALTER TABLE [dbo].[AnticiposAlPersonal]  WITH NOCHECK ADD  CONSTRAINT [FK_AnticiposAlPersonal_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[AnticiposAlPersonal] CHECK CONSTRAINT [FK_AnticiposAlPersonal_Empleados]
GO


ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Cuentas]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Cuentas1] FOREIGN KEY([IdCuentaAmortizacion])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Cuentas1]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Cuentas2] FOREIGN KEY([IdCuentaCompras])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Cuentas2]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Rubros] FOREIGN KEY([IdRubro])
REFERENCES [dbo].[Rubros] ([IdRubro])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Rubros]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Subrubros] FOREIGN KEY([IdSubrubro])
REFERENCES [dbo].[Subrubros] ([IdSubrubro])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Subrubros]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_TiposRosca] FOREIGN KEY([IdTipoRosca])
REFERENCES [dbo].[TiposRosca] ([IdTipoRosca])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_TiposRosca]
GO

ALTER TABLE [dbo].[Articulos]  WITH NOCHECK ADD  CONSTRAINT [FK_Articulos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_Articulos_Unidades]
GO


ALTER TABLE [dbo].[Asientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Asientos_Cuentas] FOREIGN KEY([IdCuentaSubdiario])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Asientos] CHECK CONSTRAINT [FK_Asientos_Cuentas]
GO


ALTER TABLE [dbo].[BancoChequeras]  WITH NOCHECK ADD  CONSTRAINT [FK_BancoChequeras_Bancos] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Bancos] ([IdBanco])
GO
ALTER TABLE [dbo].[BancoChequeras] CHECK CONSTRAINT [FK_BancoChequeras_Bancos]
GO


ALTER TABLE [dbo].[Bancos]  WITH NOCHECK ADD  CONSTRAINT [FK_Bancos_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Bancos] CHECK CONSTRAINT [FK_Bancos_Cuentas]
GO

ALTER TABLE [dbo].[Bancos]  WITH NOCHECK ADD  CONSTRAINT [FK_Bancos_Cuentas1] FOREIGN KEY([IdCuentaParaChequesDiferidos])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Bancos] CHECK CONSTRAINT [FK_Bancos_Cuentas1]
GO


ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Cuentas]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Empleados]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Empleados1] FOREIGN KEY([IdUsuarioModifico])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Empleados1]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Localidades] FOREIGN KEY([IdLocalidad])
REFERENCES [dbo].[Localidades] ([IdLocalidad])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Localidades]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Monedas]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Paises] FOREIGN KEY([IdPais])
REFERENCES [dbo].[Paises] ([IdPais])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Paises]
GO

ALTER TABLE [dbo].[Clientes]  WITH NOCHECK ADD  CONSTRAINT [FK_Clientes_Provincias] FOREIGN KEY([IdProvincia])
REFERENCES [dbo].[Provincias] ([IdProvincia])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Provincias]
GO


ALTER TABLE [dbo].[Comparativas]  WITH NOCHECK ADD  CONSTRAINT [FK_Comparativas_Empleados] FOREIGN KEY([IdConfecciono])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Comparativas] CHECK CONSTRAINT [FK_Comparativas_Empleados]
GO

ALTER TABLE [dbo].[Comparativas]  WITH NOCHECK ADD  CONSTRAINT [FK_Comparativas_Empleados1] FOREIGN KEY([IdAprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Comparativas] CHECK CONSTRAINT [FK_Comparativas_Empleados1]
GO


ALTER TABLE [dbo].[ComprobantesProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_ComprobantesProveedores_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[ComprobantesProveedores] CHECK CONSTRAINT [FK_ComprobantesProveedores_Empleados]
GO

ALTER TABLE [dbo].[ComprobantesProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_ComprobantesProveedores_Empleados1] FOREIGN KEY([IdUsuarioModifico])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[ComprobantesProveedores] CHECK CONSTRAINT [FK_ComprobantesProveedores_Empleados1]
GO

ALTER TABLE [dbo].[ComprobantesProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_ComprobantesProveedores_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[ComprobantesProveedores] CHECK CONSTRAINT [FK_ComprobantesProveedores_Monedas]
GO

ALTER TABLE [dbo].[ComprobantesProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_ComprobantesProveedores_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[ComprobantesProveedores] CHECK CONSTRAINT [FK_ComprobantesProveedores_Obras]
GO

ALTER TABLE [dbo].[ComprobantesProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_ComprobantesProveedores_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[ComprobantesProveedores] CHECK CONSTRAINT [FK_ComprobantesProveedores_Proveedores]
GO


ALTER TABLE [dbo].[Conceptos]  WITH NOCHECK ADD  CONSTRAINT [FK_Conceptos_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Conceptos] CHECK CONSTRAINT [FK_Conceptos_Cuentas]
GO


ALTER TABLE [dbo].[Conciliaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Conciliaciones_CuentasBancarias] FOREIGN KEY([IdCuentaBancaria])
REFERENCES [dbo].[CuentasBancarias] ([IdCuentaBancaria])
GO
ALTER TABLE [dbo].[Conciliaciones] CHECK CONSTRAINT [FK_Conciliaciones_CuentasBancarias]
GO

ALTER TABLE [dbo].[Conciliaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Conciliaciones_Empleados] FOREIGN KEY([IdRealizo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Conciliaciones] CHECK CONSTRAINT [FK_Conciliaciones_Empleados]
GO

ALTER TABLE [dbo].[Conciliaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Conciliaciones_Empleados1] FOREIGN KEY([IdAprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Conciliaciones] CHECK CONSTRAINT [FK_Conciliaciones_Empleados1]
GO


ALTER TABLE [dbo].[Conjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_Conjuntos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[Conjuntos] CHECK CONSTRAINT [FK_Conjuntos_Articulos]
GO

ALTER TABLE [dbo].[Conjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_Conjuntos_Empleados] FOREIGN KEY([IdRealizo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Conjuntos] CHECK CONSTRAINT [FK_Conjuntos_Empleados]
GO

ALTER TABLE [dbo].[Conjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_Conjuntos_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[Conjuntos] CHECK CONSTRAINT [FK_Conjuntos_Obras]
GO


ALTER TABLE [dbo].[Cotizaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotizaciones_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Cotizaciones] CHECK CONSTRAINT [FK_Cotizaciones_Monedas]
GO


ALTER TABLE [dbo].[CuentasBancarias]  WITH NOCHECK ADD  CONSTRAINT [FK_CuentasBancarias_Bancos] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Bancos] ([IdBanco])
GO
ALTER TABLE [dbo].[CuentasBancarias] CHECK CONSTRAINT [FK_CuentasBancarias_Bancos]
GO

ALTER TABLE [dbo].[CuentasBancarias]  WITH NOCHECK ADD  CONSTRAINT [FK_CuentasBancarias_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[CuentasBancarias] CHECK CONSTRAINT [FK_CuentasBancarias_Monedas]
GO

ALTER TABLE [dbo].[CuentasBancarias]  WITH NOCHECK ADD  CONSTRAINT [FK_CuentasBancarias_Provincias] FOREIGN KEY([IdProvincia])
REFERENCES [dbo].[Provincias] ([IdProvincia])
GO
ALTER TABLE [dbo].[CuentasBancarias] CHECK CONSTRAINT [FK_CuentasBancarias_Provincias]
GO


ALTER TABLE [dbo].[CuentasCorrientesAcreedores]  WITH NOCHECK ADD  CONSTRAINT [FK_CuentasCorrientesAcreedores_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[CuentasCorrientesAcreedores] CHECK CONSTRAINT [FK_CuentasCorrientesAcreedores_Proveedores]
GO


ALTER TABLE [dbo].[CuentasCorrientesDeudores]  WITH NOCHECK ADD  CONSTRAINT [FK_CuentasCorrientesDeudores_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[CuentasCorrientesDeudores] CHECK CONSTRAINT [FK_CuentasCorrientesDeudores_Clientes]
GO


ALTER TABLE [dbo].[DefinicionArticulos]  WITH NOCHECK ADD  CONSTRAINT [FK_DefinicionArticulos_Rubros] FOREIGN KEY([IdRubro])
REFERENCES [dbo].[Rubros] ([IdRubro])
GO
ALTER TABLE [dbo].[DefinicionArticulos] CHECK CONSTRAINT [FK_DefinicionArticulos_Rubros]
GO

ALTER TABLE [dbo].[DefinicionArticulos]  WITH NOCHECK ADD  CONSTRAINT [FK_DefinicionArticulos_Subrubros] FOREIGN KEY([IdSubrubro])
REFERENCES [dbo].[Subrubros] ([IdSubrubro])
GO
ALTER TABLE [dbo].[DefinicionArticulos] CHECK CONSTRAINT [FK_DefinicionArticulos_Subrubros]
GO


ALTER TABLE [dbo].[DetalleAjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleAjustesStock_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleAjustesStock] CHECK CONSTRAINT [FK_DetalleAjustesStock_Articulos]
GO

ALTER TABLE [dbo].[DetalleAjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleAjustesStock_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleAjustesStock] CHECK CONSTRAINT [FK_DetalleAjustesStock_Obras]
GO

ALTER TABLE [dbo].[DetalleAjustesStock]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleAjustesStock_Ubicaciones] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
GO
ALTER TABLE [dbo].[DetalleAjustesStock] CHECK CONSTRAINT [FK_DetalleAjustesStock_Ubicaciones]
GO


ALTER TABLE [dbo].[DetalleAsientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleAsientos_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[DetalleAsientos] CHECK CONSTRAINT [FK_DetalleAsientos_Cuentas]
GO


ALTER TABLE [dbo].[DetalleClientesLugaresEntrega]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleClientesLugaresEntrega_Localidades] FOREIGN KEY([IdLocalidadEntrega])
REFERENCES [dbo].[Localidades] ([IdLocalidad])
GO
ALTER TABLE [dbo].[DetalleClientesLugaresEntrega] CHECK CONSTRAINT [FK_DetalleClientesLugaresEntrega_Localidades]
GO

ALTER TABLE [dbo].[DetalleClientesLugaresEntrega]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleClientesLugaresEntrega_Provincias] FOREIGN KEY([IdProvinciaEntrega])
REFERENCES [dbo].[Provincias] ([IdProvincia])
GO
ALTER TABLE [dbo].[DetalleClientesLugaresEntrega] CHECK CONSTRAINT [FK_DetalleClientesLugaresEntrega_Provincias]
GO


ALTER TABLE [dbo].[DetalleComparativas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleComparativas_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleComparativas] CHECK CONSTRAINT [FK_DetalleComparativas_Articulos]
GO

ALTER TABLE [dbo].[DetalleComparativas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleComparativas_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[DetalleComparativas] CHECK CONSTRAINT [FK_DetalleComparativas_Monedas]
GO

ALTER TABLE [dbo].[DetalleComparativas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleComparativas_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleComparativas] CHECK CONSTRAINT [FK_DetalleComparativas_Unidades]
GO


ALTER TABLE [dbo].[DetalleConjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleConjuntos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleConjuntos] CHECK CONSTRAINT [FK_DetalleConjuntos_Articulos]
GO

ALTER TABLE [dbo].[DetalleConjuntos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleConjuntos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleConjuntos] CHECK CONSTRAINT [FK_DetalleConjuntos_Unidades]
GO


ALTER TABLE [dbo].[DetalleCuentas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleCuentas_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[DetalleCuentas] CHECK CONSTRAINT [FK_DetalleCuentas_Cuentas]
GO


ALTER TABLE [dbo].[DetalleDevoluciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleDevoluciones_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleDevoluciones] CHECK CONSTRAINT [FK_DetalleDevoluciones_Articulos]
GO

ALTER TABLE [dbo].[DetalleDevoluciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleDevoluciones_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleDevoluciones] CHECK CONSTRAINT [FK_DetalleDevoluciones_Unidades]
GO


ALTER TABLE [dbo].[DetalleFacturas]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleFacturas_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleFacturas] CHECK CONSTRAINT [FK_DetalleFacturas_Articulos]
GO


ALTER TABLE [dbo].[DetalleNotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasCredito_Conceptos] FOREIGN KEY([IdConcepto])
REFERENCES [dbo].[Conceptos] ([IdConcepto])
GO
ALTER TABLE [dbo].[DetalleNotasCredito] CHECK CONSTRAINT [FK_DetalleNotasCredito_Conceptos]
GO


ALTER TABLE [dbo].[DetalleNotasDebito]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleNotasDebito_Conceptos] FOREIGN KEY([IdConcepto])
REFERENCES [dbo].[Conceptos] ([IdConcepto])
GO
ALTER TABLE [dbo].[DetalleNotasDebito] CHECK CONSTRAINT [FK_DetalleNotasDebito_Conceptos]
GO


ALTER TABLE [dbo].[DetalleOrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesCompra_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleOrdenesCompra] CHECK CONSTRAINT [FK_DetalleOrdenesCompra_Articulos]
GO


ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_RubrosContables] FOREIGN KEY([IdRubroContable])
REFERENCES [dbo].[RubrosContables] ([IdRubroContable])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoRubrosContables] CHECK CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_RubrosContables]
GO


ALTER TABLE [dbo].[DetalleOrdenesPagoValores]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOrdenesPagoValores_BancoChequeras] FOREIGN KEY([IdBancoChequera])
REFERENCES [dbo].[BancoChequeras] ([IdBancoChequera])
GO
ALTER TABLE [dbo].[DetalleOrdenesPagoValores] CHECK CONSTRAINT [FK_DetalleOrdenesPagoValores_BancoChequeras]
GO


ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] CHECK CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Articulos]
GO

ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] CHECK CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Obras]
GO

ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Ubicaciones] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
GO
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] CHECK CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Ubicaciones]
GO

ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] CHECK CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_Unidades]
GO


ALTER TABLE [dbo].[DetallePedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePedidos_Pedidos] FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedidos] ([IdPedido])
GO
ALTER TABLE [dbo].[DetallePedidos] CHECK CONSTRAINT [FK_DetallePedidos_Pedidos]
GO

ALTER TABLE [dbo].[DetallePedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePedidos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetallePedidos] CHECK CONSTRAINT [FK_DetallePedidos_Articulos]
GO

ALTER TABLE [dbo].[DetallePedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePedidos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetallePedidos] CHECK CONSTRAINT [FK_DetallePedidos_Unidades]
GO


ALTER TABLE [dbo].[DetallePresupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePresupuestos_Presupuestos] FOREIGN KEY([IdPresupuesto])
REFERENCES [dbo].[Presupuestos] ([IdPresupuesto])
GO
ALTER TABLE [dbo].[DetallePresupuestos] CHECK CONSTRAINT [FK_DetallePresupuestos_Presupuestos]
GO

ALTER TABLE [dbo].[DetallePresupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePresupuestos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetallePresupuestos] CHECK CONSTRAINT [FK_DetallePresupuestos_Articulos]
GO

ALTER TABLE [dbo].[DetallePresupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePresupuestos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetallePresupuestos] CHECK CONSTRAINT [FK_DetallePresupuestos_Unidades]
GO

ALTER TABLE [dbo].[DetallePresupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetallePresupuestos_DetalleRequerimientos] FOREIGN KEY([IdDetalleRequerimiento])
REFERENCES [dbo].[DetalleRequerimientos] ([IdDetalleRequerimiento])
GO
ALTER TABLE [dbo].[DetallePresupuestos] CHECK CONSTRAINT [FK_DetallePresupuestos_DetalleRequerimientos]
GO


ALTER TABLE [dbo].[DetalleProveedores]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedores_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[DetalleProveedores] CHECK CONSTRAINT [FK_DetalleProveedores_Proveedores]
GO

ALTER TABLE [dbo].[DetalleProveedoresIB]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedoresIB_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[DetalleProveedoresIB] CHECK CONSTRAINT [FK_DetalleProveedoresIB_Proveedores]
GO

ALTER TABLE [dbo].[DetalleProveedoresIB]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedoresIB_IBCondiciones] FOREIGN KEY([IdIBCondicion])
REFERENCES [dbo].[IBCondiciones] ([IdIBCondicion])
GO
ALTER TABLE [dbo].[DetalleProveedoresIB] CHECK CONSTRAINT [FK_DetalleProveedoresIB_IBCondiciones]
GO

ALTER TABLE [dbo].[DetalleProveedoresRubros]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedoresRubros_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[DetalleProveedoresRubros] CHECK CONSTRAINT [FK_DetalleProveedoresRubros_Proveedores]
GO

ALTER TABLE [dbo].[DetalleProveedoresRubros]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedoresRubros_Rubros] FOREIGN KEY([IdRubro])
REFERENCES [dbo].[Rubros] ([IdRubro])
GO
ALTER TABLE [dbo].[DetalleProveedoresRubros] CHECK CONSTRAINT [FK_DetalleProveedoresRubros_Rubros]
GO

ALTER TABLE [dbo].[DetalleProveedoresRubros]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleProveedoresRubros_Subrubros] FOREIGN KEY([IdSubrubro])
REFERENCES [dbo].[Subrubros] ([IdSubrubro])
GO
ALTER TABLE [dbo].[DetalleProveedoresRubros] CHECK CONSTRAINT [FK_DetalleProveedoresRubros_Subrubros]
GO


ALTER TABLE [dbo].[DetalleRecepciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRecepciones_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleRecepciones] CHECK CONSTRAINT [FK_DetalleRecepciones_Articulos]
GO

ALTER TABLE [dbo].[DetalleRecepciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRecepciones_Empleados] FOREIGN KEY([IdRealizo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[DetalleRecepciones] CHECK CONSTRAINT [FK_DetalleRecepciones_Empleados]
GO

ALTER TABLE [dbo].[DetalleRecepciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRecepciones_Ubicaciones] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
GO
ALTER TABLE [dbo].[DetalleRecepciones] CHECK CONSTRAINT [FK_DetalleRecepciones_Ubicaciones]
GO

ALTER TABLE [dbo].[DetalleRecepciones]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRecepciones_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleRecepciones] CHECK CONSTRAINT [FK_DetalleRecepciones_Unidades]
GO


ALTER TABLE [dbo].[DetalleRemitos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRemitos_Articulos1] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleRemitos] CHECK CONSTRAINT [FK_DetalleRemitos_Articulos1]
GO

ALTER TABLE [dbo].[DetalleRemitos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRemitos_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleRemitos] CHECK CONSTRAINT [FK_DetalleRemitos_Obras]
GO

ALTER TABLE [dbo].[DetalleRemitos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRemitos_Ubicaciones] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
GO
ALTER TABLE [dbo].[DetalleRemitos] CHECK CONSTRAINT [FK_DetalleRemitos_Ubicaciones]
GO

ALTER TABLE [dbo].[DetalleRemitos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRemitos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleRemitos] CHECK CONSTRAINT [FK_DetalleRemitos_Unidades]
GO


ALTER TABLE [dbo].[DetalleRequerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRequerimientos_Requerimientos] FOREIGN KEY([IdRequerimiento])
REFERENCES [dbo].[Requerimientos] ([IdRequerimiento])
GO
ALTER TABLE [dbo].[DetalleRequerimientos] CHECK CONSTRAINT [FK_DetalleRequerimientos_Requerimientos]
GO

ALTER TABLE [dbo].[DetalleRequerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRequerimientos_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleRequerimientos] CHECK CONSTRAINT [FK_DetalleRequerimientos_Articulos]
GO

ALTER TABLE [dbo].[DetalleRequerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRequerimientos_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleRequerimientos] CHECK CONSTRAINT [FK_DetalleRequerimientos_Unidades]
GO

ALTER TABLE [dbo].[DetalleRequerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleRequerimientos_ControlesCalidad] FOREIGN KEY([IdControlCalidad])
REFERENCES [dbo].[ControlesCalidad] ([IdControlCalidad])
GO
ALTER TABLE [dbo].[DetalleRequerimientos] CHECK CONSTRAINT [FK_DetalleRequerimientos_Unidades]
GO


ALTER TABLE [dbo].[DetalleSalidasMateriales]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleSalidasMateriales_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleSalidasMateriales] CHECK CONSTRAINT [FK_DetalleSalidasMateriales_Articulos]
GO

ALTER TABLE [dbo].[DetalleSalidasMateriales]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleSalidasMateriales_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[DetalleSalidasMateriales] CHECK CONSTRAINT [FK_DetalleSalidasMateriales_Obras]
GO

ALTER TABLE [dbo].[DetalleSalidasMateriales]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleSalidasMateriales_Ubicaciones] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
GO
ALTER TABLE [dbo].[DetalleSalidasMateriales] CHECK CONSTRAINT [FK_DetalleSalidasMateriales_Ubicaciones]
GO

ALTER TABLE [dbo].[DetalleSalidasMateriales]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleSalidasMateriales_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleSalidasMateriales] CHECK CONSTRAINT [FK_DetalleSalidasMateriales_Unidades]
GO


ALTER TABLE [dbo].[DetalleValesSalida]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleValesSalida_Articulos] FOREIGN KEY([IdArticulo])
REFERENCES [dbo].[Articulos] ([IdArticulo])
GO
ALTER TABLE [dbo].[DetalleValesSalida] CHECK CONSTRAINT [FK_DetalleValesSalida_Articulos]
GO

ALTER TABLE [dbo].[DetalleValesSalida]  WITH NOCHECK ADD  CONSTRAINT [FK_DetalleValesSalida_Unidades] FOREIGN KEY([IdUnidad])
REFERENCES [dbo].[Unidades] ([IdUnidad])
GO
ALTER TABLE [dbo].[DetalleValesSalida] CHECK CONSTRAINT [FK_DetalleValesSalida_Unidades]
GO


ALTER TABLE [dbo].[Devoluciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Devoluciones_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Devoluciones] CHECK CONSTRAINT [FK_Devoluciones_Clientes]
GO

ALTER TABLE [dbo].[Devoluciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Devoluciones_Vendedores] FOREIGN KEY([IdVendedor])
REFERENCES [dbo].[Vendedores] ([IdVendedor])
GO
ALTER TABLE [dbo].[Devoluciones] CHECK CONSTRAINT [FK_Devoluciones_Vendedores]
GO


ALTER TABLE [dbo].[Empleados]  WITH NOCHECK ADD  CONSTRAINT [FK_Empleados_Cargos] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[Cargos] ([IdCargo])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleados_Cargos]
GO

ALTER TABLE [dbo].[Empleados]  WITH NOCHECK ADD  CONSTRAINT [FK_Empleados_Sectores] FOREIGN KEY([IdSector])
REFERENCES [dbo].[Sectores] ([IdSector])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleados_Sectores]
GO


ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO

ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Empleados]
GO

ALTER TABLE [dbo].[Facturas]  WITH NOCHECK ADD  CONSTRAINT [FK_Facturas_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Monedas]
GO


ALTER TABLE [dbo].[FondosFijos]  WITH NOCHECK ADD  CONSTRAINT [FK_FondosFijos_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[FondosFijos] CHECK CONSTRAINT [FK_FondosFijos_Empleados]
GO

ALTER TABLE [dbo].[FondosFijos]  WITH NOCHECK ADD  CONSTRAINT [FK_FondosFijos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[FondosFijos] CHECK CONSTRAINT [FK_FondosFijos_Proveedores]
GO


ALTER TABLE [dbo].[Ganancias]  WITH NOCHECK ADD  CONSTRAINT [FK_Ganancias_TiposRetencionGanancia] FOREIGN KEY([IdTipoRetencionGanancia])
REFERENCES [dbo].[TiposRetencionGanancia] ([IdTipoRetencionGanancia])
GO
ALTER TABLE [dbo].[Ganancias] CHECK CONSTRAINT [FK_Ganancias_TiposRetencionGanancia]
GO


ALTER TABLE [dbo].[NotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasCredito_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[NotasCredito] CHECK CONSTRAINT [FK_NotasCredito_Clientes]
GO

ALTER TABLE [dbo].[NotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasCredito_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[NotasCredito] CHECK CONSTRAINT [FK_NotasCredito_Empleados]
GO

ALTER TABLE [dbo].[NotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasCredito_IBCondiciones] FOREIGN KEY([IdIBCondicion])
REFERENCES [dbo].[IBCondiciones] ([IdIBCondicion])
GO
ALTER TABLE [dbo].[NotasCredito] CHECK CONSTRAINT [FK_NotasCredito_IBCondiciones]
GO

ALTER TABLE [dbo].[NotasCredito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasCredito_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[NotasCredito] CHECK CONSTRAINT [FK_NotasCredito_Monedas]
GO


ALTER TABLE [dbo].[NotasDebito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasDebito_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[NotasDebito] CHECK CONSTRAINT [FK_NotasDebito_Clientes]
GO

ALTER TABLE [dbo].[NotasDebito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasDebito_Empleados] FOREIGN KEY([IdUsuarioIngreso])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[NotasDebito] CHECK CONSTRAINT [FK_NotasDebito_Empleados]
GO

ALTER TABLE [dbo].[NotasDebito]  WITH NOCHECK ADD  CONSTRAINT [FK_NotasDebito_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[NotasDebito] CHECK CONSTRAINT [FK_NotasDebito_Monedas]
GO


ALTER TABLE [dbo].[OrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_OrdenesCompra_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[OrdenesCompra] CHECK CONSTRAINT [FK_OrdenesCompra_Clientes]
GO

ALTER TABLE [dbo].[OrdenesCompra]  WITH NOCHECK ADD  CONSTRAINT [FK_OrdenesCompra_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[OrdenesCompra] CHECK CONSTRAINT [FK_OrdenesCompra_Monedas]
GO


ALTER TABLE [dbo].[Pedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_Pedidos_Empleados] FOREIGN KEY([IdComprador])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Empleados]
GO

ALTER TABLE [dbo].[Pedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_Pedidos_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Monedas]
GO

ALTER TABLE [dbo].[Pedidos]  WITH NOCHECK ADD  CONSTRAINT [FK_Pedidos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Proveedores]
GO


ALTER TABLE [dbo].[PlazosFijos]  WITH NOCHECK ADD  CONSTRAINT [FK_PlazosFijos_Bancos] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Bancos] ([IdBanco])
GO
ALTER TABLE [dbo].[PlazosFijos] CHECK CONSTRAINT [FK_PlazosFijos_Bancos]
GO


ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Condiciones Compra] FOREIGN KEY([IdCondicionCompra])
REFERENCES [dbo].[Condiciones Compra] ([IdCondicionCompra])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Condiciones Compra]
GO

ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Monedas] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Monedas] ([IdMoneda])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Monedas]
GO

ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Proveedores]
GO

ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_PlazosEntrega] FOREIGN KEY([IdPlazoEntrega])
REFERENCES [dbo].[PlazosEntrega] ([IdPlazoEntrega])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_PlazosEntrega]
GO

ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Empleados1] FOREIGN KEY([IdComprador])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Empleados1]
GO

ALTER TABLE [dbo].[Presupuestos]  WITH NOCHECK ADD  CONSTRAINT [FK_Presupuestos_Empleados2] FOREIGN KEY([Aprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Empleados2]
GO


ALTER TABLE [dbo].[Provincias]  WITH NOCHECK ADD  CONSTRAINT [FK_Provincias_Paises] FOREIGN KEY([IdPais])
REFERENCES [dbo].[Paises] ([IdPais])
GO
ALTER TABLE [dbo].[Provincias] CHECK CONSTRAINT [FK_Provincias_Paises]
GO


ALTER TABLE [dbo].[Recepciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Recepciones_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Recepciones] CHECK CONSTRAINT [FK_Recepciones_Proveedores]
GO


ALTER TABLE [dbo].[Recibos]  WITH NOCHECK ADD  CONSTRAINT [FK_Recibos_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Recibos] CHECK CONSTRAINT [FK_Recibos_Clientes]
GO


ALTER TABLE [dbo].[Remitos]  WITH NOCHECK ADD  CONSTRAINT [FK_Remitos_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Remitos] CHECK CONSTRAINT [FK_Remitos_Clientes]
GO

ALTER TABLE [dbo].[Remitos]  WITH NOCHECK ADD  CONSTRAINT [FK_Remitos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Remitos] CHECK CONSTRAINT [FK_Remitos_Proveedores]
GO

ALTER TABLE [dbo].[Remitos]  WITH NOCHECK ADD  CONSTRAINT [FK_Remitos_PuntosVenta] FOREIGN KEY([IdPuntoVenta])
REFERENCES [dbo].[PuntosVenta] ([IdPuntoVenta])
GO
ALTER TABLE [dbo].[Remitos] CHECK CONSTRAINT [FK_Remitos_PuntosVenta]
GO


ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados1] FOREIGN KEY([Aprobo])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados1]
GO

ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Empleados2] FOREIGN KEY([IdSolicito])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Empleados2]
GO

ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Obras] FOREIGN KEY([IdObra])
REFERENCES [dbo].[Obras] ([IdObra])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Obras]
GO

ALTER TABLE [dbo].[Requerimientos]  WITH NOCHECK ADD  CONSTRAINT [FK_Requerimientos_Sectores] FOREIGN KEY([IdSector])
REFERENCES [dbo].[Sectores] ([IdSector])
GO
ALTER TABLE [dbo].[Requerimientos] CHECK CONSTRAINT [FK_Requerimientos_Sectores]
GO


ALTER TABLE [dbo].[Rubros]  WITH NOCHECK ADD  CONSTRAINT [FK_Rubros_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Rubros] CHECK CONSTRAINT [FK_Rubros_Cuentas]
GO


ALTER TABLE [dbo].[Subdiarios]  WITH NOCHECK ADD  CONSTRAINT [FK_Subdiarios_Cuentas] FOREIGN KEY([IdCuenta])
REFERENCES [dbo].[Cuentas] ([IdCuenta])
GO
ALTER TABLE [dbo].[Subdiarios] CHECK CONSTRAINT [FK_Subdiarios_Cuentas]
GO


ALTER TABLE [dbo].[Ubicaciones]  WITH NOCHECK ADD  CONSTRAINT [FK_Ubicaciones_Depositos] FOREIGN KEY([IdDeposito])
REFERENCES [dbo].[Depositos] ([IdDeposito])
GO
ALTER TABLE [dbo].[Ubicaciones] CHECK CONSTRAINT [FK_Ubicaciones_Depositos]
GO


