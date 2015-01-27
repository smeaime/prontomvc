---<<<<<<<<<<<<<<<<<<<<<<<<<<<<<AlterTable 2007>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>---
/*
  PROCEDIMIENTO QUE SE AGREGARA PARA PODER VALIDAR EXISTENCIA DE CAMPOS
  EN LAS TABLAS RESPECTIVAS
*/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_AlterTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[_AlterTable]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure _AlterTable

@tabla Varchar(100),
@campo varchar(100),
@esta int output

AS
set nocount on

CREATE TABLE [dbo].[#Auxiliar] (
	[table_name] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL ,
	[table_owner] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL ,
	[table_qualifier] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL ,
	[Columna] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL 
) ON [PRIMARY]

insert into #Auxiliar exec BD_TX_Campos @tabla
set @esta =0
if exists (select Columna from #Auxiliar where Columna = @campo)
set @esta =1

drop table #Auxiliar
set nocount off
Return (@esta)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BD_TX_Campos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BD_TX_Campos]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE BD_TX_Campos 

(
				 @table_name		nvarchar(384),
				 @table_owner		nvarchar(384) = null,
				 @table_qualifier	sysname = null,
				 @column_name		nvarchar(384) = null,
				 @ODBCVer			int = 2)
AS

    DECLARE @full_table_name	nvarchar(769)
    DECLARE @table_id int
	if @ODBCVer <> 3
		select @ODBCVer = 2
	if @column_name is null /*	If column name not supplied, match all */
		select @column_name = '%'
	if @table_qualifier is not null
    begin
		if db_name() <> @table_qualifier
		begin	/* If qualifier doesn't match current database */
			raiserror (15250, -1,-1)
			return
		end
    end
	if @table_name is null
	begin	/*	If table name not supplied, match all */
		select @table_name = '%'
	end
	if @table_owner is null
	begin	/* If unqualified table name */
		SELECT @full_table_name = quotename(@table_name)
    end
    else
	begin	/* Qualified table name */
		if @table_owner = ''
		begin	/* If empty owner name */
			SELECT @full_table_name = quotename(@table_owner)
		end
		else
		begin
			SELECT @full_table_name = quotename(@table_owner) +
				'.' + quotename(@table_name)
		end
    end
	/*	Get Object ID */
	SELECT @table_id = object_id(@full_table_name)
	if ((isnull(charindex('%', @full_table_name),0) = 0) and
		(isnull(charindex('[', @table_name),0) = 0) and
		(isnull(charindex('[', @table_owner),0) = 0) and
		(isnull(charindex('_', @full_table_name),0) = 0) and
		@table_id <> 0)
    begin
		/* this block is for the case where there is no pattern
			matching required for the table name */
		SELECT
			TABLE_QUALIFIER = convert(sysname,DB_NAME()),
			TABLE_OWNER = convert(sysname,USER_NAME(o.uid)),
			TABLE_NAME = convert(sysname,o.name),
			COLUMN_NAME = convert(sysname,c.name)
		FROM
			sysobjects o,
			systypes t,
			syscolumns c
			LEFT OUTER JOIN syscomments m on c.cdefault = m.id
				AND m.colid = 1
		WHERE
			o.id = @table_id
			AND c.id = o.id
			AND o.type <> 'P'
			AND c.xusertype = t.xusertype
			AND c.name like @column_name
		ORDER BY COLUMN_NAME
	end
	else
    begin
		/* this block is for the case where there IS pattern
			matching done on the table name */
		if @table_owner is null /*	If owner not supplied, match all */
			select @table_owner = '%'
		SELECT
			TABLE_QUALIFIER = convert(sysname,DB_NAME()),
			TABLE_OWNER = convert(sysname,USER_NAME(o.uid)),
			TABLE_NAME = convert(sysname,o.name),
			COLUMN_NAME = convert(sysname,c.name)
		FROM
			sysobjects o,
			systypes t,
			syscolumns c
			LEFT OUTER JOIN syscomments m on c.cdefault = m.id
				AND m.colid = 1
		WHERE
			o.name like @table_name
			AND user_name(o.uid) like @table_owner
			AND o.id = c.id
			AND o.type <> 'P'
			AND c.xusertype = t.xusertype
			AND c.name like @column_name
		ORDER BY COLUMN_NAME
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
---<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>---

-->> se eliminan los campos calculados de la tabla CuentasCorrientesdeudores
ALTER TABLE [dbo].[CuentasCorrientesDeudores] drop column
  [Saldotrs]
GO
ALTER TABLE [dbo].[CuentasCorrientesDeudores] drop column
  [Marca]
GO

/* se sigue con el alter table comun, el final de este archivo se volveran a generar los campos enteriormente
   eliminados
*/

-- Declaro una variable para usarla en el EXCEC
declare @esta1 int
GO
-------------------<< 02/01/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacen','Anulado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacen] ADD
    [Anulado] [varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'OtrosIngresosAlmacen', N'column', N'Anulado'
end
GO
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacen','IdAutorizaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacen] ADD
    [IdAutorizaAnulacion] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'OtrosIngresosAlmacen', N'OtrosIngresosAlmacen', N'IdAutorizaAnulacion'
end
go
----------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacen','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacen] ADD
    [FechaAnulacion] [datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'OtrosIngresosAlmacen', N'column', N'FechaAnulacion'
end


go
-------------------<< 06/02/2007 >>---------------------------
----------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','CostoUnitario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [CostoUnitario] [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/02/07', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'CostoUnitario'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdMoneda', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdMoneda] [int] NULL
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdOrdenTrabajo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdOrdenTrabajo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/02/07', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdOrdenTrabajo'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','DestinoPago', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [DestinoPago] [varchar] (1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/02/07', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'DestinoPago'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Obras','IdCuentaContableFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [IdCuentaContableFF] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/02/07', N'user', N'dbo', N'table', N'Obras', N'column', N'IdCuentaContableFF'
end
GO
-------------------<< 19/02/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdDetalleObraDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-07', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdDetalleObraDestino'
end
GO
-------------------<< 20/02/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Valores','CertificadoRetencion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [CertificadoRetencion] [varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-02-07', N'user', N'dbo', N'table', N'Valores', N'column', N'CertificadoRetencion'
end
GO
-------------------<< 20/02/2007 >>---------------------------
-------------------<< NUEVAS TABLAS !! >>---------------------
/*

1) _ImportacionCobranzas

2) _ImportacionCobranzas_Historico

*/
-------------------<< 26/02/2007 >>---------------------------
-------------------<< NUEVAS TABLAS !! >>---------------------
/*
1) Parametros2
*/
-------------------<< 26/02/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdRecepcionSAT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdRecepcionSAT] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-07', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdRecepcionSAT'
end
GO
-------------------<< 02/03/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Obras','ValorObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [ValorObra] [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02-03-07', N'user', N'dbo', N'table', N'Obras', N'column', N'ValorObra'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Obras','IdMonedaValorObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [IdMonedaValorObra] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02-03-07', N'user', N'dbo', N'table', N'Obras', N'column', N'IdMonedaValorObra'
end
GO
-------------------<< 17/03/2007 >>---------------------------
-------------------<< NUEVAS TABLAS !! >>---------------------
/*
1) _TempCuboStock
*/

-------------------<< 17/03/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Empleados','IdCuentaFondoFijo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [IdCuentaFondoFijo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17-03-07', N'user', N'dbo', N'table', N'Empleados', N'column', N'IdCuentaFondoFijo'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Empleados','IdObraAsignada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [IdObraAsignada] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17-03-07', N'user', N'dbo', N'table', N'Empleados', N'column', N'IdObraAsignada'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','NumeroRendicionFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [NumeroRendicionFF] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17-03-07', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'NumeroRendicionFF'
end
GO
-------------------<< 21/03/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','PorcentajeBonificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [PorcentajeBonificacion] [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21-03-07', N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'PorcentajeBonificacion'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'OrdenesCompra','PorcentajeBonificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [PorcentajeBonificacion] [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'PorcentajeBonificacion'
end
GO
-------------------<< 23/03/2007 >>---------------------------
-------------------<< NUEVAS TABLAS !! >>---------------------
/*
1) DetalleArticulosUnidades
*/
-------------------<< 24/03/2007 >>---------------------------
-------------------<< NUEVAS TABLAS !! >>---------------------
/*
1) _TempCuboStock
*/
-------------------<< 26/03/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Facturas','DevolucionAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [DevolucionAnticipo] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-03-07',
	N'user', N'dbo', N'table', N'Facturas', N'column', N'DevolucionAnticipo'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeDevolucionAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [PorcentajeDevolucionAnticipo] [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-03-07', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeDevolucionAnticipo'
end
GO
-------------------<< 01/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','ClaveTipoSalida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [ClaveTipoSalida] [varchar] (30) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01-04-07', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'ClaveTipoSalida'
end
GO
-------------------<< 10/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Recepciones','Libero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [Libero] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-04-07', N'user', N'dbo', N'table', N'Recepciones', N'column', N'Libero'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'Recepciones','FechaLiberacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [FechaLiberacion] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-04-07', N'user', N'dbo', N'table', N'Recepciones', N'column', N'FechaLiberacion'
end
GO
-------------------<< 11/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','Aprobo2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [Aprobo2] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-04-07', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Aprobo2'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'Requerimientos','FechaAprobacion2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [FechaAprobacion2] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-04-07', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'FechaAprobacion2'
end
GO
-------------------<< 18/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'AjustesStock','IdUsuarioIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [IdUsuarioIngreso] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-04-07', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'IdUsuarioIngreso'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'AjustesStock','FechaIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [FechaIngreso] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-04-07', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'FechaIngreso'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'AjustesStock','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [IdUsuarioModifico] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-04-07', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'IdUsuarioModifico'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'AjustesStock','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [FechaModifico] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-04-07', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'FechaModifico'
end
GO
-------------------<< 20/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdControlCalidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdControlCalidad] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdControlCalidad'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','Controlado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [Controlado] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'Controlado'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','CantidadCC', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [CantidadCC] [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'CantidadCC'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','CantidadRechazadaCC', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [CantidadRechazadaCC] [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'CantidadRechazadaCC'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleControlesCalidad','IdDetalleOtroIngresoAlmacen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleControlesCalidad] ADD
    [IdDetalleOtroIngresoAlmacen] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleControlesCalidad', N'column', N'IdDetalleOtroIngresoAlmacen'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleControlesCalidad','NumeroRemitoRechazo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleControlesCalidad] ADD
    [NumeroRemitoRechazo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleControlesCalidad', N'column', N'NumeroRemitoRechazo'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleControlesCalidad','FechaRemitoRechazo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleControlesCalidad] ADD
    [FechaRemitoRechazo] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleControlesCalidad', N'column', N'FechaRemitoRechazo'
end
----------------
exec _AlterTable 'DetalleControlesCalidad','IdProveedorRechazo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleControlesCalidad] ADD
    [IdProveedorRechazo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20-04-07', N'user', N'dbo', N'table', N'DetalleControlesCalidad', N'column', N'IdProveedorRechazo'
end
GO
-------------------<< 25/04/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Articulos','StockReposicion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [StockReposicion] [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 25-04-07',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'StockReposicion'
end
GO
-------------------<< 30/04/2007 >>---------------------------

-- alter colum:
ALTER TABLE [dbo].[NovedadesUsuarios]
       ALTER COLUMN [Detalle] varchar (200)


ALTER TABLE [dbo].[detallerequerimientos]
       ALTER COLUMN [CodigoDistribucion] varchar (3)



----------------
declare @esta1 int
exec _AlterTable 'NovedadesUsuarios','IdElemento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NovedadesUsuarios] ADD
    [IdElemento] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30-04-07',
     N'user', N'dbo', N'table', N'NovedadesUsuarios', N'column', N'IdElemento'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'NovedadesUsuarios','TipoElemento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NovedadesUsuarios] ADD
    [TipoElemento] [varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30-04-07',
     N'user', N'dbo', N'table', N'NovedadesUsuarios', N'column', N'TipoElemento'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Articulos','MarcaStock', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [MarcaStock] [varchar] (1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30-04-07',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'MarcaStock'
end
GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'Empleados','Activo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [Activo] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30-04-07',
     N'user', N'dbo', N'table', N'Empleados', N'column', N'Activo'
end
GO
----------------------------------------------------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleAjustesStock]
         ALTER COLUMN [Partida] varchar (20)
---------------------
-- Alter Column

  ALTER TABLE [dbo].[_TempCuboStock]
         ALTER COLUMN [Partida] varchar (20)
---------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleDevoluciones]
         ALTER COLUMN [Partida] varchar (20)
----------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen]
         ALTER COLUMN [Partida] varchar (20)
------------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleRecepciones]
         ALTER COLUMN [Partida] varchar (20)
---------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleRecepcionesSAT]
         ALTER COLUMN [Partida] varchar (20)
----------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleRemitos]
         ALTER COLUMN [Partida] varchar (20)
-----------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleReservas]
         ALTER COLUMN [Partida] varchar (20)
----------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleSalidasMateriales]
         ALTER COLUMN [Partida] varchar (20)
---------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleValesSalida]
         ALTER COLUMN [Partida] varchar (20)
--------------------
-- Alter Column
  ALTER TABLE [dbo].[Stock]
         ALTER COLUMN [Partida] varchar (20)
GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleCuentas','CodigoAnterior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleCuentas] ADD
    [CodigoAnterior] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-05-07',
     N'user', N'dbo', N'table', N'DetalleCuentas', N'column', N'CodigoAnterior'
end
GO
----------------------------------------------------------------
-- Alter Column
  ALTER TABLE [dbo].[DetalleCuentas]
         ALTER COLUMN  [CodigoAnterior] [int]
GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'TiposCuentaGrupos','AjustarDiferenciasEnSubdiarios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TiposCuentaGrupos] ADD
    [AjustarDiferenciasEnSubdiarios] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-05-07',
     N'user', N'dbo', N'table', N'TiposCuentaGrupos', N'column', N'AjustarDiferenciasEnSubdiarios'
end
GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleCuentas','JerarquiaAnterior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleCuentas] ADD
    [JerarquiaAnterior] [varchar] (20)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-05-07',
     N'user', N'dbo', N'table', N'DetalleCuentas', N'column', N'JerarquiaAnterior'
end

GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'TiposCuentaGrupos','AjustarDiferenciasEnSubdiarios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TiposCuentaGrupos] ADD
    [AjustarDiferenciasEnSubdiarios] [varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-06-07',
     N'user', N'dbo', N'table', N'TiposCuentaGrupos', N'column', N'AjustarDiferenciasEnSubdiarios'
end
GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleCuentas','JerarquiaAnterior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleCuentas] ADD
    [JerarquiaAnterior] [varchar] (20)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-06-07',
     N'user', N'dbo', N'table', N'DetalleCuentas', N'column', N'JerarquiaAnterior'
end

GO
----------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'Articulos','CostoInicial', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [CostoInicial] [Numeric] (18,3)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-06-07',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'CostoInicial'
end
GO
-------------------<< 11/06/2007 >>---------------------------
declare @esta1 int
exec _AlterTable 'Provincias','PlantillaRetencionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Provincias] ADD
    [PlantillaRetencionIIBB] [Varchar](50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-06-07',
     N'user', N'dbo', N'table', N'Provincias', N'column', N'PlantillaRetencionIIBB'
end
GO
-------------------<< 14/06/2007 >>---------------------------
-- Alter Column
ALTER TABLE [dbo].[Log]
         ALTER COLUMN [Detalle] varchar (100)
-------------------<< 15/06/2007 >>---------------------------
--Alter Column
ALTER TABLE [dbo].[Facturas]
       ALTER COLUMN [FechaVencimiento] datetime
GO
--------------------<<   25/06/07     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','SalidaADepositoEnTransito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [SalidaADepositoEnTransito] [varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-06-07',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'SalidaADepositoEnTransito'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdDetalleSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdDetalleSalidaMateriales] [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-06-07',
     N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdDetalleSalidaMateriales'
end
GO

declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacen','IdSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacen] ADD
    [IdSalidaMateriales] [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-06-07',
     N'user', N'dbo', N'table', N'OtrosIngresosAlmacen', N'column', N'IdSalidaMateriales'
end
GO
--------------------<<   27/06/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Lmateriales','Embalo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Lmateriales] ADD
    [Embalo] [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-06-07',
     N'user', N'dbo', N'table', N'Lmateriales', N'column', N'Embalo'
end
GO
--------------------<<   28/06/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','Calificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [Calificacion] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-06-07',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'Calificacion'
end
GO
--------------------<<   11/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRecepcionesSAT','IdDetalleSalidaMaterialesPRONTO', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepcionesSAT] ADD
    [IdDetalleSalidaMaterialesPRONTO] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'DetalleRecepcionesSAT', N'column', N'IdDetalleSalidaMaterialesPRONTO'
end
GO
--------------------<<   12/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdDetalleSalidaMaterialesPRONTOaSAT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdDetalleSalidaMaterialesPRONTOaSAT] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdDetalleSalidaMaterialesPRONTOaSAT'
end
GO
--------------------<<   13/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','ValorDeclarado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [ValorDeclarado] [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'ValorDeclarado'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','Bultos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [Bultos] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Bultos'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdColor] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdColor'
end
GO
--------------------<<   16/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','IdDetalleSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAjustesStock] ADD
    [IdDetalleSalidaMateriales] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'IdDetalleSalidaMateriales'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'AjustesStock','IdRecepcionSAT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [IdRecepcionSAT] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-07-07',
     N'user', N'dbo', N'table', N'AjustesStock', N'column', N'IdRecepcionSAT'
end
GO
--------------------<<   18/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'CuentasBancarias','InformacionAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasBancarias] ADD
    [InformacionAuxiliar] [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-07-07',
     N'user', N'dbo', N'table', N'CuentasBancarias', N'column', N'InformacionAuxiliar'
end

--------------------<<   23/07/07     >>----------------------

GO

declare @esta1 int
exec _AlterTable 'Clientes','IdUsuarioIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [IdUsuarioIngreso] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'IdUsuarioIngreso'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','FechaIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaIngreso] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaIngreso'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [IdUsuarioModifico] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'IdUsuarioModifico'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaModifico] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaModifico'
end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','IdUsuarioIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IdUsuarioIngreso] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdUsuarioIngreso'
end

GO

declare @esta1 int
exec _AlterTable 'Proveedores','FechaIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaIngreso] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaIngreso'
end

GO

declare @esta1 int
exec _AlterTable 'Proveedores','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IdUsuarioModifico] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdUsuarioModifico'
end

GO

declare @esta1 int
exec _AlterTable 'Proveedores','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaModifico] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-07-07',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaModifico'
end
GO
--------------------<<   27/07/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','IdTipoCompra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [IdTipoCompra] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27-07-07',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'IdTipoCompra'
end
GO
--------------------<<   06/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','Exterior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [Exterior] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06082007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'Exterior'
end
GO
---------------------
declare @esta1 int
exec _AlterTable 'Cuentas','NumeroAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Cuentas] ADD
    [NumeroAuxiliar] [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06082007',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'NumeroAuxiliar'
end
GO
--------------------<<   07/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','NumeroRendicionFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [NumeroRendicionFF] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07082007',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'NumeroRendicionFF'
end
GO
---------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','ConfirmacionAcreditacionFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [ConfirmacionAcreditacionFF] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07082007',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'ConfirmacionAcreditacionFF'
end
GO
--------------------<<   14/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','ConsumirPorOT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [ConsumirPorOT] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14082007',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'ConsumirPorOT'
end
GO
--------------------<<   27/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','IdImporto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [IdImporto] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27082007',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'IdImporto'
end
GO
-------------
declare @esta1 int
exec _AlterTable 'Requerimientos','FechaLlegadaImportacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [FechaLlegadaImportacion] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27082007',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'FechaLlegadaImportacion'
end
GO
--------------------<<   28/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'CuentasGastos','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasGastos] ADD
    [Codigo] [Varchar]  (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28082007',
     N'user', N'dbo', N'table', N'CuentasGastos', N'column', N'Codigo'
end
GO
-------------
declare @esta1 int
exec _AlterTable 'CuentasGastos','CodigoDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasGastos] ADD
    [CodigoDestino] [Varchar]  (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28082007',
     N'user', N'dbo', N'table', N'CuentasGastos', N'column', N'CodigoDestino'
end
GO
--------------------<<   29/08/07     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','Embalo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [Embalo] [Varchar]  (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29082007',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Embalo'
end
GO
--------------------<<   07/09/07     >>----------------------
-------------- 1
declare @esta1 int
exec _AlterTable 'Lmateriales','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Lmateriales] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Lmateriales', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 2
declare @esta1 int
exec _AlterTable 'Requerimientos','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 3
declare @esta1 int
exec _AlterTable 'Pedidos','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 4
declare @esta1 int
exec _AlterTable 'Comparativas','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Comparativas', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 5
declare @esta1 int
exec _AlterTable 'AjustesStock','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[AjustesStock] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'AjustesStock', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 6
declare @esta1 int
exec _AlterTable 'Presupuestos','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 7
declare @esta1 int
exec _AlterTable 'ValesSalida','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ValesSalida] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'ValesSalida', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 8
declare @esta1 int
exec _AlterTable 'SalidasMateriales','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 9
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacen','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacen] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'OtrosIngresosAlmacen', N'column', N'CircuitoFirmasCompleto'
end
GO
-------------- 10
declare @esta1 int
exec _AlterTable 'Recepciones','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [CircuitoFirmasCompleto] [Varchar]  (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07092007',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'CircuitoFirmasCompleto'
end
--------------------<<   12/09/07     >>----------------------
GO
-------------- 1
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra1] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra1'
end
GO
-------------- 2
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra2] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra2'
end
GO
-------------- 3
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra3] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra3'
end
GO
-------------- 4
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra4] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra4'
end
GO
-------------- 5
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra5] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra5'
end
GO
-------------- 6
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','PersonalObra6', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    [PersonalObra6] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'PersonalObra6'
end
GO
--------------
declare @esta1 int
exec _AlterTable 'Obras','IdJefeRegional', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [IdJefeRegional] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12092007',
     N'user', N'dbo', N'table', N'Obras', N'column', N'IdJefeRegional'
end
GO
--------------------<<   14/09/07     >>----------------------
declare @esta1 int
exec _AlterTable 'TiposComprobante','ExigirCAI', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TiposComprobante] ADD
    [ExigirCAI] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14092007',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'ExigirCAI'
end
GO
--------------------<<   01/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Recepciones','IdComprador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdComprador] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01102007',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdComprador'
end
GO
--------------------<<   02/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Valores','AsientoManual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [AsientoManual] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02102007',
     N'user', N'dbo', N'table', N'Valores', N'column', N'AsientoManual'
end
GO
--------------------<<   02/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'TiposComprobante','NumeradorAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TiposComprobante] ADD
    [NumeradorAuxiliar] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02102007',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'NumeradorAuxiliar'
end
GO
--------------------<<   02/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','SUSSFechaCaducidadExencion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [SUSSFechaCaducidadExencion] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05102007',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'SUSSFechaCaducidadExencion'
end

GO
--------------------<<   22/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','SujetoEmbargado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [SujetoEmbargado] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22102007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'SujetoEmbargado'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Proveedores','SaldoEmbargo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [SaldoEmbargo] [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22102007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'SaldoEmbargo'
end
GO
---------------
declare @esta1 int
exec _AlterTable 'Proveedores','DetalleEmbargo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [DetalleEmbargo] [varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22102007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'DetalleEmbargo'
end
GO
--------------------<<   23/10/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Empresa','IdCodigoIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [IdCodigoIva] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23102007',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'IdCodigoIva'
end
GO
--------------------<<   01/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','PorcentajeIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [PorcentajeIBDirecto] [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'PorcentajeIBDirecto'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Clientes','FechaInicioVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaInicioVigenciaIBDirecto] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaInicioVigenciaIBDirecto'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Clientes','FechaFinVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaFinVigenciaIBDirecto] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaFinVigenciaIBDirecto'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Proveedores','PorcentajeIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [PorcentajeIBDirecto] [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'PorcentajeIBDirecto'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Proveedores','FechaInicioVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaInicioVigenciaIBDirecto] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaInicioVigenciaIBDirecto'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Proveedores','FechaFinVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaFinVigenciaIBDirecto] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03112007',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaFinVigenciaIBDirecto'
end
GO
--------------------<<   08/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','CAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [CAE] [varchar] (14) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08112007',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'CAE'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Facturas','RechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [RechazoCAE] [varchar] (11) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08112007',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'RechazoCAE'
end
GO
-----------------
declare @esta1 int
exec _AlterTable 'Facturas','FechaVencimientoORechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [FechaVencimientoORechazoCAE] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08112007',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'FechaVencimientoORechazoCAE'
end
--------------------<<   09/11/07     >>----------------------
-- Facturas  - Alter Column !! 
-- alter colum:
ALTER TABLE [dbo].[Facturas]
       ALTER COLUMN [PorcentajeDevolucionAnticipo] Numeric (12,6)

GO
--------------------<<   21/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Remitos','Patente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [Patente] [varchar] (25) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'Patente'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Remitos','Chofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [Chofer] [varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'Chofer'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Remitos','NumeroDocumento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [NumeroDocumento] [varchar] (30) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'NumeroDocumento'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Remitos','OrdenCarga', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [OrdenCarga] [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'OrdenCarga'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Remitos','OrdenCompra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [OrdenCompra] [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'OrdenCompra'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Remitos','COT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [COT] [varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'COT'
end
GO
--------------------<<   22/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdPuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdPuntoVenta] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdPuntoVenta'
end

GO
--------------------
declare @esta1 int
exec _AlterTable 'Estados Proveedores','Activo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Estados Proveedores] ADD
    [Activo] [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Estados Proveedores', N'column', N'Activo'
end
GO
--------------------<<   23/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','GrupoIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [GrupoIIBB] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'GrupoIIBB'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'Clientes','GrupoIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [GrupoIIBB] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'GrupoIIBB'
end

GO
--------------------<<   26/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','PorcentajeIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [PorcentajeIBDirecto] [numeric](6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'PorcentajeIBDirecto'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','FechaInicioVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [FechaInicioVigenciaIBDirecto] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'FechaInicioVigenciaIBDirecto'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','FechaFinVigenciaIBDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [FechaFinVigenciaIBDirecto] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'FechaFinVigenciaIBDirecto'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','GrupoIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [GrupoIIBB] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'GrupoIIBB'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'LogImpuestos','IdCliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LogImpuestos] ADD
    [IdCliente] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 261107',
     N'user', N'dbo', N'table', N'LogImpuestos', N'column', N'IdCliente'
end
GO
--------------------<<   28/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacenSAT','Anulado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacenSAT] ADD
    [Anulado] [varchar](2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 281107',
     N'user', N'dbo', N'table', N'OtrosIngresosAlmacenSAT', N'column', N'Anulado'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacenSAT','IdAutorizaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacenSAT] ADD
    [IdAutorizaAnulacion] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 281107',
     N'user', N'dbo', N'table', N'OtrosIngresosAlmacenSAT', N'column', N'Anulado'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'OtrosIngresosAlmacenSAT','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OtrosIngresosAlmacenSAT] ADD
    [FechaAnulacion] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 281107',
     N'user', N'dbo', N'table', N'OtrosIngresosAlmacenSAT', N'column', N'FechaAnulacion'
end
GO
--------------------<<   29/11/07     >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','OPInicialFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [OPInicialFF] [varchar](2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 291107',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'OPInicialFF'
end
--------------------<<   03/12/07     >>----------------------
-- DetalleComprobantesProveedores  - Alter Column !! 
-- alter colum:
ALTER TABLE [dbo].[DetalleComprobantesProveedores]
       ALTER COLUMN [PrestoConcepto] varchar (50)
-- LogImpuestos  - Alter Column !! 
-- alter colum:
ALTER TABLE [dbo].[LogImpuestos]
       ALTER COLUMN [ArchivoProcesado] varchar (12)
GO
--------------------<<   04/12/07     >>----------------------
declare @esta1 int
exec _AlterTable 'IBcondiciones','IdProvinciaReal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[IBcondiciones] ADD
    [IdProvinciaReal] [varchar](2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 041207',
     N'user', N'dbo', N'table', N'IBcondiciones', N'column', N'IdProvinciaReal'
end
GO
--------------------<<   17/12/07     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','Cantidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [Cantidad] [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 171207',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'Cantidad'
end

GO
--------------------<<   07/01/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','MoP', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [MoP] [varchar](1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 171207',
     N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'MoP'
end

GO
--------------------<<   25/01/08     >>----------------------
declare @esta1 int
exec _AlterTable 'ImpuestosDirectos','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ImpuestosDirectos] ADD
    [Codigo] [Varchar](3) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250108',
     N'user', N'dbo', N'table', N'ImpuestosDirectos', N'column', N'Codigo'
end
GO
--------------------<<   15/02/08     >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','Cuit', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [Cuit] [Varchar](13) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15028',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'Cuit'
end
GO
--------------------<<   19/02/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [IdDetalleObraDestino] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19028',
     N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'IdDetalleObraDestino'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdDetalleObraDestino] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19028',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdDetalleObraDestino'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'DetalleAsientos','IdDetalleComprobanteProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAsientos] ADD
    [IdDetalleComprobanteProveedor] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19028',
     N'user', N'dbo', N'table', N'DetalleAsientos', N'column', N'IdDetalleComprobanteProveedor'
end
GO
--------------------
declare @esta1 int
exec _AlterTable 'DetalleObrasDestinos','ADistribuir', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleObrasDestinos] ADD
    [ADistribuir] [Varchar](2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19028',
     N'user', N'dbo', N'table', N'DetalleObrasDestinos', N'column', N'ADistribuir'
end

GO
--------------------<<   21/02/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','IvaFechaInicioExencion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IvaFechaInicioExencion] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 220208',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IvaFechaInicioExencion'
end

GO
--------------------<<   25/02/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','IdTransportista', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [IdTransportista] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'IdTransportista'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Proveedores','IdTransportista', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IdTransportista] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdTransportista'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroRecepcionOrigen1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroRecepcionOrigen1] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroRecepcionOrigen1'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroRecepcionOrigen2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroRecepcionOrigen2] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroRecepcionOrigen2'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Recepciones','Chofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [Chofer] [varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'Chofer'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroDocumentoChofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroDocumentoChofer] [varchar] (30) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroDocumentoChofer'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Recepciones','IdEquipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdEquipo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdEquipo'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','CantidadEnOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    [CantidadEnOrigen] [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250208',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'CantidadEnOrigen'
end
GO
--------------------<<   28/02/08     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroRemitoTransporte', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [NumeroRemitoTransporte] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 280208',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroRemitoTransporte'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Cuentas','IdRubroFinanciero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Cuentas] ADD
    [IdRubroFinanciero] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 280208',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'IdRubroFinanciero'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Cuentas','IdPresupuestoObraRubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Cuentas] ADD
    [IdPresupuestoObraRubro] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 280208',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'IdPresupuestoObraRubro'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdPresupuestoObraRubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdPresupuestoObraRubro] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 280208',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdPresupuestoObraRubro'
end
GO
--------------------<<   03/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdEquipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdEquipo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 030308',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdEquipo'
end
GO
----------------
declare @esta1 int
exec _AlterTable 'Remitos','IdEquipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [IdEquipo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 030308',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdEquipo'
end
GO
--------------------<<   07/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','FechaAsignacionPresupuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [FechaAsignacionPresupuesto] [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070308',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'FechaAsignacionPresupuesto'
end
----------------
GO
--------------------<<   11/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','IdTipoEquipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [IdTipoEquipo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 100308',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'IdTipoEquipo'
end
GO
--------------------<<   11/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','Replica', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [Replica] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 100308',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'Replica'
end
GO
--------------------<<   11/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Transportistas','IdProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Transportistas] ADD
    [IdProveedor] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 100308',
     N'user', N'dbo', N'table', N'Transportistas', N'column', N'IdProveedor'
end
GO
--------------------<<   18/03/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Asientos','AsignarAPresupuestoObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Asientos] ADD
    [AsignarAPresupuestoObra] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180308',
     N'user', N'dbo', N'table', N'Asientos', N'column', N'AsignarAPresupuestoObra'
end
--------------------<<   18/03/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasConsumos','Detalle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasConsumos] ADD
    [Detalle] [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180308',
     N'user', N'dbo', N'table', N'PresupuestoObrasConsumos', N'column', N'Detalle'
end
--------------------<<   18/03/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Recepciones','Patente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [Patente] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180308',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'Patente'
end
--------------------<<   26/03/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Articulos','IdPresupuestoObraRubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [IdPresupuestoObraRubro] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 260308',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'IdPresupuestoObraRubro'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','IdPresupuestoObraRubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [IdPresupuestoObraRubro] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 260308',
     N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'IdPresupuestoObraRubro'
end
--------------------<<   01/04/08    >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Valores','Anulado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [Anulado] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 010408',
     N'user', N'dbo', N'table', N'Valores', N'column', N'Anulado'
end
GO
declare @esta1 int
exec _AlterTable 'Valores','IdUsuarioAnulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [IdUsuarioAnulo] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 010408',
     N'user', N'dbo', N'table', N'Valores', N'column', N'IdUsuarioAnulo'
end
GO

declare @esta1 int
exec _AlterTable 'Valores','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [FechaAnulacion] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 010408',
     N'user', N'dbo', N'table', N'Valores', N'column', N'FechaAnulacion'
end
GO

declare @esta1 int
exec _AlterTable 'Valores','MotivoAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [MotivoAnulacion] [Varchar] (30) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 010408',
     N'user', N'dbo', N'table', N'Valores', N'column', N'MotivoAnulacion'
end
--------------------<<   07/04/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Remitos','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [IdObra] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070408',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'IdObra'
end
--------------------<<   09/04/08     >>----------------------
GO

declare @esta1 int
exec _AlterTable 'Conceptos','Grupo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Conceptos] ADD
    [Grupo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070408',
     N'user', N'dbo', N'table', N'Conceptos', N'column', N'Grupo'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesPago','IdConcepto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [IdConcepto] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070408',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'IdConcepto'
end
GO

declare @esta1 int
exec _AlterTable 'Parametros','ProximaOrdenPagoFF', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Parametros] ADD
    [ProximaOrdenPagoFF] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070408',
     N'user', N'dbo', N'table', N'Parametros', N'column', N'ProximaOrdenPagoFF'
end
--------------------<<   15/04/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Tipos','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Tipos] ADD
    [Codigo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'Tipos', N'column', N'Codigo'
end
GO
declare @esta1 int
exec _AlterTable 'Tipos','Grupo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Tipos] ADD
    [Grupo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'Tipos', N'column', N'Grupo'
end
GO
declare @esta1 int
exec _AlterTable 'Articulos','IdTipoArticulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [IdTipoArticulo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'IdTipoArticulo'
end
--------------------<<   15/04/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdPedidoAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdPedidoAnticipo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdPedidoAnticipo'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','PorcentajeAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [PorcentajeAnticipo] [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'PorcentajeAnticipo'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','PorcentajeCertificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [PorcentajeCertificacion] [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 150408',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'PorcentajeCertificacion'
end
GO
--------------------<<   17/04/08     >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObras','IdUnidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObras] ADD
    [IdUnidad] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 170408',
     N'user', N'dbo', N'table', N'PresupuestoObras', N'column', N'IdUnidad'
end
--------------------<<   18/04/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdDepositoOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdDepositoOrigen] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180408',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdDepositoOrigen'
end
--------------------<<   02/05/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Provincias','IdCuentaSIRCREB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Provincias] ADD
    [IdCuentaSIRCREB] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 020508',
     N'user', N'dbo', N'table', N'Provincias', N'column', N'IdCuentaSIRCREB'
end
--------------------<<   08/05/08     >>----------------------
GO

declare @esta1 int
exec _AlterTable 'PuntosVenta','ProximoNumero1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [ProximoNumero1] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 020508',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'ProximoNumero1'
end
GO
declare @esta1 int
exec _AlterTable 'PuntosVenta','ProximoNumero2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [ProximoNumero2] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 020508',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'ProximoNumero2'
end
--------------------<<   22/05/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdEquipoDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdEquipoDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 220508',
     N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdEquipoDestino'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdOrdenTrabajo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdOrdenTrabajo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 220508',
     N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdOrdenTrabajo'
end
--------------------<<   27/05/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'CuentasBancarias','CaracteresBeneficiario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasBancarias] ADD
    [CaracteresBeneficiario] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 270508',
     N'user', N'dbo', N'table', N'CuentasBancarias', N'column', N'CaracteresBeneficiario'
end
GO
--------------------<<   28/05/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Recibos','IdProvinciaDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recibos] ADD
    [IdProvinciaDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 280508',
     N'user', N'dbo', N'table', N'Recibos', N'column', N'IdProvinciaDestino'
end

Update articulos
set Idrubro = (select top 1 idrubro from rubros)
where idrubro is null
--------------------<<   29/05/08     >>----------------------
GO
declare @esta1 int
exec _AlterTable 'Articulos','IdRubro', @esta = @esta1 output
if @esta1 = 1
begin
Update articulos
set IdRubro = (select top 1 IdRubro from Rubros)
where IdRubro is null

ALTER TABLE [dbo].[Articulos] 
  ALTER COLUMN  [IdRubro]   [int] Not NULL 
end
--------------------<<   29/05/08     >>----------------------
GO

declare @esta1 int
exec _AlterTable 'Articulos','IdSubRubro', @esta = @esta1 output
if @esta1 = 1
begin
Update articulos
set IdSubRubro = (select top 1 IdSubRubro from SubRubros)
where IdSubRubro is null

ALTER TABLE [dbo].[Articulos] 
  ALTER COLUMN  [IdSubRubro]   [int] Not NULL 
end

GO
--------------------<<   30/05/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Condiciones Compra','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Condiciones Compra] ADD
    [Codigo] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 290508',
     N'user', N'dbo', N'table', N'Condiciones Compra', N'column', N'Codigo'
end

GO
--------------------<<   02/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','CodigoRetencionIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [CodigoRetencionIVA] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 290508',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'CodigoRetencionIVA'
end

--------------------<<   02/05/08     >>----------------------

ALTER TABLE [dbo].[ImpuestosDirectos] 
  ALTER COLUMN  [Codigo]   [Varchar] (10)
  
GO
--------------------<<   05/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleLMateriales','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLMateriales] ADD
    [IdDetalleObraDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'DetalleLMateriales', N'column', N'IdDetalleObraDestino'
end
GO
--------------------<<   06/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleObrasDestinos','InformacionAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleObrasDestinos] ADD
    [InformacionAuxiliar] [Varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'DetalleObrasDestinos', N'column', N'InformacionAuxiliar'
end

GO
--------------------<<   10/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','FechaUltimoCostoReposicion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [FechaUltimoCostoReposicion] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 100608',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'FechaUltimoCostoReposicion'
end
GO
--------------------<<   18/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleObrasDestinos','TipoConsumo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleObrasDestinos] ADD
    [TipoConsumo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180608',
     N'user', N'dbo', N'table', N'DetalleObrasDestinos', N'column', N'TipoConsumo'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasRubros','TipoConsumo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasRubros] ADD
    [TipoConsumo] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180608',
     N'user', N'dbo', N'table', N'PresupuestoObrasRubros', N'column', N'TipoConsumo'
end
GO
--------------------<<   19/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Articulos','ADistribuirEnPresupuestoDeObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [ADistribuirEnPresupuestoDeObra] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 190608',
     N'user', N'dbo', N'table', N'Articulos', N'column', N'ADistribuirEnPresupuestoDeObra'
end

GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdPresupuestoObraRubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdPresupuestoObraRubro] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 190608',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdPresupuestoObraRubro'
end
GO
--------------------<<   25/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoValores','Anulado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoValores] ADD
    [Anulado] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250608',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoValores', N'column', N'Anulado'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoValores','IdUsuarioAnulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoValores] ADD
    [IdUsuarioAnulo]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250608',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoValores', N'column', N'IdUsuarioAnulo'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoValores','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoValores] ADD
    [FechaAnulacion] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250608',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoValores', N'column', N'FechaAnulacion'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoValores','MotivoAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoValores] ADD
    [MotivoAnulacion] [Varchar] (30) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 250608',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoValores', N'column', N'MotivoAnulacion'
end
---------------------------------------------------------------
-- Alter Column
  ALTER TABLE [dbo].[Articulos]
         ALTER COLUMN [NumeroManzana] varchar (20)

GO
--------------------<<   27/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOtrosIngresosAlmacen] ADD
    [IdDetalleObraDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 270608',
     N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdDetalleObraDestino'
end
GO
--------------------<<   30/06/08     >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObras','CodigoPresupuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObras] ADD
    [CodigoPresupuesto] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 300608',
     N'user', N'dbo', N'table', N'PresupuestoObras', N'column', N'CodigoPresupuesto'
end


--------------------<<   02/07/08     >>----------------------
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje1] [numeric](6, 2) NULL
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje2] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje3] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje4] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje5] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje6] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje7] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje8] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje9] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje10] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje11] [numeric](6, 2) NULL 
ALTER TABLE [dbo].[Condiciones Compra]
  ALTER COLUMN  [Porcentaje12] [numeric](6, 2) NULL 
  
GO
--------------------<<   04/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasConsumos','IdUnidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasConsumos] ADD
    [IdUnidad] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040708',
     N'user', N'dbo', N'table', N'PresupuestoObrasConsumos', N'column', N'IdUnidad'
end


GO
--------------------<<   16/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','Dolarizada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [Dolarizada] [varchar](2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040708',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'Dolarizada'
end
GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','IdConcepto2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [IdConcepto2] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'IdConcepto2'
end
GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','FormaAnulacionCheques', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [FormaAnulacionCheques] [Varchar] (1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'FormaAnulacionCheques'
end
GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','IdCuentaPresupuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [IdCuentaPresupuesto] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'IdCuentaPresupuesto'
end
GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','MesPresupuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [MesPresupuesto] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'MesPresupuesto'
end

GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','RequisitosSeguridad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [RequisitosSeguridad] [ntext] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'RequisitosSeguridad'
end
GO
--------------------<<   21/07/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','Adjuntos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [Adjuntos] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 210708',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Adjuntos'
end

GO
--------------------<<   04/08/08     >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','OtrosConceptos1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [OtrosConceptos1]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040808',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'OtrosConceptos1'
end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','OtrosConceptos2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [OtrosConceptos2]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040808',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'OtrosConceptos2'
end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','OtrosConceptos3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [OtrosConceptos3]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040808',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'OtrosConceptos3'
end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','OtrosConceptos4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [OtrosConceptos4]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040808',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'OtrosConceptos4'
end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','OtrosConceptos5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [OtrosConceptos5]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 040808',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'OtrosConceptos5'
end


GO
--------------------<<   07/08/08 OJO no aparece en doc de Edu!    >>----------------------
declare @esta1 int
exec _AlterTable 'ProntoIniClaves','Descripcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProntoIniClaves] ADD
    [Descripcion]  [ntext] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070808',
     N'user', N'dbo', N'table', N'ProntoIniClaves', N'column', N'Descripcion'
end
GO

declare @esta1 int
exec _AlterTable 'ProntoIniClaves','ValorPorDefecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProntoIniClaves] ADD
    [ValorPorDefecto]  [varchar](150) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070808',
     N'user', N'dbo', N'table', N'ProntoIniClaves', N'column', N'ValorPorDefecto'
end
GO
--------------------<<   21/08/08  >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdDetalleSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    [IdDetalleSalidaMateriales]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 070808',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdDetalleSalidaMateriales'
end

GO
--------------------<<   08/09/08  >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','Detalle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [Detalle]  [varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 080908',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'Detalle'
end

ALTER TABLE [dbo].[OrdenesTrabajo] 
  ALTER COLUMN  [NumeroOrdenTrabajo]   [varchar] (20)  COLLATE Modern_Spanish_CI_AS NOT NULL
  
GO
--------------------<<   09/09/08  >>----------------------
declare @esta1 int
exec _AlterTable 'PuntosVenta','ProximoNumero3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [ProximoNumero3]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 090908',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'ProximoNumero3'
end
GO

declare @esta1 int
exec _AlterTable 'PuntosVenta','ProximoNumero4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [ProximoNumero4]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 090908',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'ProximoNumero4'
end
GO

declare @esta1 int
exec _AlterTable 'PuntosVenta','ProximoNumero5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [ProximoNumero5]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 090908',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'ProximoNumero5'
end
GO

--------------------<<   11/09/08  >>----------------------
-- alter colum:
ALTER TABLE [dbo].[Asientos] 
  ALTER COLUMN  [ArchivoImportacion]   [varchar] (200) NULL 
  
--------------------<<   16/09/08  >>----------------------
GO
-- alter colum:
ALTER TABLE [dbo].[ProntoIni]
       ALTER COLUMN [Valor] varchar (1000)

GO
ALTER TABLE [dbo].[ProntoIniClaves]
       ALTER COLUMN [Clave] varchar (1000)
GO       
ALTER TABLE [dbo].[ProntoIniClaves]
       ALTER COLUMN [ValorPorDefecto] varchar (1000)
  
GO
--------------------<<   18/09/08  >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','NumeroOrdenPagoFondoReparo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [NumeroOrdenPagoFondoReparo]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 180908',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'NumeroOrdenPagoFondoReparo'
end


GO
--------------------<<   23/09/08  >>----------------------
declare @esta1 int
exec _AlterTable 'Empleados','Idioma', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [Idioma]  [varchar] (3) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 230908',
     N'user', N'dbo', N'table', N'Empleados', N'column', N'Idioma'
end

GO
--------------------<<   10/10/08  >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','IdDetalleObraDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [IdDetalleObraDestino]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011008',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'IdDetalleObraDestino'
end
    
ALTER TABLE [dbo].[Obras]
       ALTER COLUMN [Descripcion] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS
       
GO
--------------------<<   15/10/08  >>----------------------
declare @esta1 int
exec _AlterTable 'PuntosVenta','Descripcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [Descripcion]  [varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151008',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'Descripcion'
end
GO

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaComprasActivo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaComprasActivo]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151008',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaComprasActivo'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdCuenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdCuenta]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151008',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdCuenta'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdCuentaGasto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdCuentaGasto]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151008',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdCuentaGasto'
end
--------------------<< 22/10/2008 >>----------------------
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','FechaNecesidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [FechaNecesidad]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22-10-08',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'FechaNecesidad'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','FechaEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [FechaEntrega]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22-10-08',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'FechaEntrega'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdPresupuestoObrasNodo]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22-10-08',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdPresupuestoObrasNodo'
end
--------------------<< 23/10/2008>>----------------------
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdPresupuestoObrasNodo]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-10-08',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdPresupuestoObrasNodo'
end

--------------------<< 29/10/2008>>----------------------
GO
declare @esta1 int
exec _AlterTable 'Facturas','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [IdListaPrecios]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-10-08',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'IdListaPrecios'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [IdListaPrecios]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-10-08',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdListaPrecios'
end
GO

declare @esta1 int
exec _AlterTable 'NotasDebito','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [IdListaPrecios]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23-10-08',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdListaPrecios'
end
GO
--------------------<< 31/10/2008>>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasConsumos','Origen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasConsumos] ADD
    [Origen]  [varchar] (5) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'PresupuestoObrasConsumos', N'column', N'Origen'
end

GO
--------------------<< 06/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'CalidadesClad','Abreviatura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CalidadesClad] ADD
    [Abreviatura]  [varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'CalidadesClad', N'column', N'Abreviatura'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [IdListaPrecios]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'IdListaPrecios'
end
GO
declare @esta1 int
exec _AlterTable 'Remitos','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [IdListaPrecios]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'IdListaPrecios'
end

GO
--------------------<< 11/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'Recibos','ServicioCobro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recibos] ADD
    [ServicioCobro]  [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'Recibos', N'column', N'ServicioCobro'
end
GO
declare @esta1 int
exec _AlterTable 'Recibos','LoteServicioCobro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recibos] ADD
    [LoteServicioCobro]  [varchar] (15) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 311008',
     N'user', N'dbo', N'table', N'Recibos', N'column', N'LoteServicioCobro'
end
GO
--------------------<< 13/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdListaPrecios]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 131108',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdListaPrecios'
end
GO
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdComprobanteProveedorOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdComprobanteProveedorOriginal]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 131108',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdComprobanteProveedorOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'Proveedores','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IdListaPrecios]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 131108',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdListaPrecios'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdDetalleComprobanteProveedorOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdDetalleComprobanteProveedorOriginal]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 131108',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdDetalleComprobanteProveedorOriginal'
end
--------------------<< 18/11/2008>>----------------------
ALTER TABLE [dbo].[Articulos]
       ALTER COLUMN [Caracteristicas] varchar (70)
       
GO
--------------------<< 21/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','IdClausula', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [IdClausula]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 211108',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdClausula'
end
GO
--------------------<< 25/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'Stock','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Stock] ADD
    [NumeroCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 251108',
     N'user', N'dbo', N'table', N'Stock', N'column', N'NumeroCaja'
end
GO
declare @esta1 int
exec _AlterTable 'Stock','FechaAlta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Stock] ADD
    [FechaAlta]  [Datetime]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 251108',
     N'user', N'dbo', N'table', N'Stock', N'column', N'FechaAlta'
end
GO
declare @esta1 int
exec _AlterTable 'Unidades','UnidadesPorPack', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Unidades] ADD
    [UnidadesPorPack]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 251108',
     N'user', N'dbo', N'table', N'Unidades', N'column', N'UnidadesPorPack'
end
GO

declare @esta1 int
exec _AlterTable 'Unidades','TaraEnKg', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Unidades] ADD
    [TaraEnKg]  [Numeric] (18,4)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 251108',
     N'user', N'dbo', N'table', N'Unidades', N'column', N'TaraEnKg'
end
GO
--------------------<< 28/11/2008>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRemitos','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRemitos] ADD
    [NumeroCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 281108',
     N'user', N'dbo', N'table', N'DetalleRemitos', N'column', N'NumeroCaja'
end
GO
--------------------<< 01/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesTrabajo','IdEquipoDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesTrabajo] ADD
    [IdEquipoDestino]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'OrdenesTrabajo', N'column', N'IdEquipoDestino'
end
GO

declare @esta1 int
exec _AlterTable 'Devoluciones','IdListaPrecios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Devoluciones] ADD
    [IdListaPrecios]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdListaPrecios'
end
GO
declare @esta1 int
exec _AlterTable 'OrdenesCompra','IdUsuarioIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [IdUsuarioIngreso]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'IdUsuarioIngreso'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','FechaIngreso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [FechaIngreso] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'FechaIngreso'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [IdUsuarioModifico]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'IdUsuarioModifico'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [FechaModifico] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 011208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'FechaModifico'
end
GO
--------------------<< 02/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [NumeroCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 021208',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'NumeroCaja'
end
GO
declare @esta1 int
exec _AlterTable 'Vendedores','IdEmpleado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Vendedores] ADD
    [IdEmpleado]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 021208',
     N'user', N'dbo', N'table', N'Vendedores', N'column', N'IdEmpleado'
end
GO
--------------------<< 02/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesCompra','Aprobo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [Aprobo]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 031208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'Aprobo'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','FechaAprobacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [FechaAprobacion] [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 031208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'FechaAprobacion'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [CircuitoFirmasCompleto]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 031208',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'CircuitoFirmasCompleto'
end
GO
--------------------<< 15/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'Colores','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [Codigo]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'Codigo'
end
GO

declare @esta1 int
exec _AlterTable 'Colores','Codigo1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [Codigo1]  [varchar] (1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'Codigo1'
end
GO
declare @esta1 int
exec _AlterTable 'Colores','IdArticulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [IdArticulo]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'IdArticulo'
end
GO

declare @esta1 int
exec _AlterTable 'Colores','IdCliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [IdCliente]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'IdCliente'
end
GO

declare @esta1 int
exec _AlterTable 'Colores','IdVendedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [IdVendedor]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'IdVendedor'
end
GO
declare @esta1 int
exec _AlterTable 'Colores','IdUsuarioAlta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [IdUsuarioAlta]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'IdUsuarioAlta'
end
GO
declare @esta1 int
exec _AlterTable 'Colores','FechaAlta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Colores] ADD
    [FechaAlta]  [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Colores', N'column', N'FechaAlta'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','IdBancoDebito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [IdBancoDebito]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'IdBancoDebito'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','CBU', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [CBU]  [varchar] (22) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 151208',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaAlta'
end
GO
--------------------<< 16/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [IdColor]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 161208',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'IdColor'
end
GO
declare @esta1 int
exec _AlterTable 'Valores','Rechazado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [Rechazado]  [varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 161208',
     N'user', N'dbo', N'table', N'Valores', N'column', N'Rechazado'
end
GO
--------------------<< 29/12/2008>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAjustesStock] ADD
    [NumeroCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 161208',
     N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'NumeroCaja'
end

GO
--------------------<< 06/01/2009>>----------------------
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','IdUbicacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[UnidadesEmpaque] ADD
    [IdUbicacion]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'IdUbicacion'
end
GO

declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[UnidadesEmpaque] ADD
    [IdColor]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'IdColor'
end

GO
--------------------<< 15/01/2009>>----------------------
declare @esta1 int
exec _AlterTable 'CertificacionesObras','NumeroCertificado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObras] ADD
    [NumeroCertificado]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'CertificacionesObras', N'column', N'NumeroCertificado'
end
GO
declare @esta1 int
exec _AlterTable 'CertificacionesObras','Item', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObras] ADD
    [Item]  [Varchar] (10)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'CertificacionesObras', N'column', N'Item'
end
GO

declare @esta1 int
exec _AlterTable 'CertificacionesObras','Adjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObras] ADD
    [Adjunto1]  [Varchar] (100)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'CertificacionesObras', N'column', N'Adjunto1'
end
GO

declare @esta1 int
exec _AlterTable 'Subcontratos','Adjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Subcontratos] ADD
    [Adjunto1]  [Varchar] (100)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'Subcontratos', N'column', N'Adjunto1'
end
GO
--------------------<< 21/01/2009>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','IdDioPorCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [IdDioPorCumplido]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'IdDioPorCumplido'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','FechaDadoPorCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [FechaDadoPorCumplido]  [DateTime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'FechaDadoPorCumplido'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','ObservacionesCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [ObservacionesCumplido] [ntext] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'ObservacionesCumplido'
end

GO
--------------------<< 23/01/2009>>----------------------
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','IdUnidadTipoCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[UnidadesEmpaque] ADD
    [IdUnidadTipoCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'IdUnidadTipoCaja'
end

GO
--------------------<< 03/02/2009>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleDevoluciones] ADD
    [NumeroCaja]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'NumeroCaja'
end
GO
--------------------<< 23/02/2009>>----------------------
declare @esta1 int
exec _AlterTable 'Subcontratos','IdObra', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Subcontratos] Drop COLUMN  [IdObra]  
end
GO
declare @esta1 int
exec _AlterTable 'Subcontratos','IdProveedor', @esta = @esta1 output

if @esta1 = 1
begin
  ALTER TABLE [dbo].[Subcontratos] Drop COLUMN  [IdProveedor]  
end
GO

declare @esta1 int
exec _AlterTable 'Subcontratos','Fecha', @esta = @esta1 output

if @esta1 = 1
begin
  ALTER TABLE [dbo].[Subcontratos] Drop COLUMN  [Fecha]  
end
GO

declare @esta1 int
exec _AlterTable 'Subcontratos','Adjunto1', @esta = @esta1 output

if @esta1 = 1
begin
  ALTER TABLE [dbo].[Subcontratos] Drop COLUMN  [Adjunto1]  
end

GO
--------------------<< 25/02/2009>>----------------------
declare @esta1 int
exec _AlterTable 'TiposRetencionGanancia','BienesOServicios', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TiposRetencionGanancia] ADD
    [BienesOServicios]  [varchar] (1)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-01-09',
     N'user', N'dbo', N'table', N'TiposRetencionGanancia', N'column', N'BienesOServicios'
end
GO

--------------------<< 26/02/2009>>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','PorcentajeIVAParaMonotributistas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [PorcentajeIVAParaMonotributistas]  [Numeric] (6,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'PorcentajeIVAParaMonotributistas'
end
GO

declare @esta1 int
exec _AlterTable 'CertificacionesObras','Importe', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObras] ADD
    [Importe]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'CertificacionesObras', N'column', N'Importe'
end
GO

declare @esta1 int
exec _AlterTable 'CertificacionesObrasPxQ','Importe', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObrasPxQ] ADD
    [Importe]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'CertificacionesObrasPxQ', N'column', N'Importe'
end
GO
declare @esta1 int
exec _AlterTable 'CertificacionesObrasPxQ','ImporteAvance', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObrasPxQ] ADD
    [ImporteAvance]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'CertificacionesObrasPxQ', N'column', N'ImporteAvance'
end
GO
--------------------<< 27/02/2009>>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesCompra','IdDetalleClienteLugarEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [IdDetalleClienteLugarEntrega]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'IdDetalleClienteLugarEntrega'
end
GO
declare @esta1 int
exec _AlterTable 'Remitos','IdDetalleClienteLugarEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [IdDetalleClienteLugarEntrega]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-02-09',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'IdDetalleClienteLugarEntrega'
end
GO
--------------------<< 04/03/2009>>----------------------
declare @esta1 int
exec _AlterTable 'Clausulas','Orden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clausulas] ADD
    [Orden]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-03-09',
     N'user', N'dbo', N'table', N'Clausulas', N'column', N'Orden'
end
GO
declare @esta1 int
exec _AlterTable 'Pedidos','IncluirObservacionesRM', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [IncluirObservacionesRM]  [Varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-03-09',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'IncluirObservacionesRM'
end
GO
--------------------<< 09/03/2009>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','IdDetalleFactura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleDevoluciones] ADD
    [IdDetalleFactura]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-03-09',
     N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'IdDetalleFactura'
end
GO
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdDiferenciaCambio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    IdDiferenciaCambio  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-03-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdDiferenciaCambio'
end
GO

--------------------<< 13/04/2009>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoValores','IdTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoValores] ADD
    [IdTarjetaCredito]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 13-04-09',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoValores', N'column', N'IdTarjetaCredito'
end
GO
declare @esta1 int
exec _AlterTable 'Valores','IdTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [IdTarjetaCredito]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 13-04-09',
     N'user', N'dbo', N'table', N'Valores', N'column', N'IdTarjetaCredito'
end
GO
declare @esta1 int
exec _AlterTable 'TarjetasCredito','IdMoneda', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TarjetasCredito] ADD
    [IdMoneda]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 13-04-09',
     N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'IdMoneda'
end
GO


--------------------<< 14/04/2009>>----------------------

declare @esta1 int
exec _AlterTable 'Provincias','EsAgenteRetencionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Provincias] ADD
    [EsAgenteRetencionIIBB]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14-04-09',
     N'user', N'dbo', N'table', N'Provincias', N'column', N'EsAgenteRetencionIIBB'
end
GO
--------------------<< 19/05/2009>>----------------------

declare @esta1 int
exec _AlterTable 'DetallePedidos','ImpuestosInternos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetallePedidos] ADD
    [ImpuestosInternos]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-05-09',
     N'user', N'dbo', N'table', N'DetallePedidos', N'column', N'ImpuestosInternos'
end
GO

--------------------<< 26/05/2009>>----------------------

declare @esta1 int
exec _AlterTable 'PatronesGPS','Activa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PatronesGPS] ADD
    [Activa]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-05-09',
     N'user', N'dbo', N'table', N'PatronesGPS', N'column', N'Activa'
end
GO

--------------------<< 26/05/2009>>----------------------

declare @esta1 int
exec _AlterTable 'MovimientosFletes','FechaUltimaModificacionManual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[MovimientosFletes] ADD
    [FechaUltimaModificacionManual]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-05-09',
     N'user', N'dbo', N'table', N'MovimientosFletes', N'column', N'FechaUltimaModificacionManual'
end
GO
declare @esta1 int
exec _AlterTable 'MovimientosFletes','FechaLecturaArchivoMovimiento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[MovimientosFletes] ADD
    [FechaLecturaArchivoMovimiento]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-05-09',
     N'user', N'dbo', N'table', N'MovimientosFletes', N'column', N'FechaLecturaArchivoMovimiento'
end
GO

--------------------<< 04/06/2009>>----------------------
declare @esta1 int
exec _AlterTable 'DetalleArticulosUnidades','EnviarEmail', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleArticulosUnidades] ADD
    [EnviarEmail]  [tinyint] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-06-09',
     N'user', N'dbo', N'table', N'DetalleArticulosUnidades', N'column', N'EnviarEmail'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleArticulosUnidades','IdArticuloOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleArticulosUnidades] ADD
    [IdArticuloOriginal]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-06-09',
     N'user', N'dbo', N'table', N'DetalleArticulosUnidades', N'column', N'IdArticuloOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleArticulosUnidades','IdDetalleArticuloUnidadesOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleArticulosUnidades] ADD
    [IdDetalleArticuloUnidadesOriginal]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-06-09',
     N'user', N'dbo', N'table', N'DetalleArticulosUnidades', N'column', N'IdDetalleArticuloUnidadesOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleArticulosUnidades','IdOrigenTransmision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleArticulosUnidades] ADD
    [IdOrigenTransmision]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04-06-09',
     N'user', N'dbo', N'table', N'DetalleArticulosUnidades', N'column', N'IdOrigenTransmision'
end
GO
--------------------<< 09/06/2009>>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','RegimenEspecialConstruccionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [RegimenEspecialConstruccionIIBB]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'RegimenEspecialConstruccionIIBB'
end
GO
------------------NotasDebito
declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [IdIBCondicion3]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion3'
end
GO

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [RetencionIBrutos3]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos3'
end
GO

declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [PorcentajeIBrutos3]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos3'
end
GO
-------------NotasCredito
declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [IdIBCondicion3]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion3'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [RetencionIBrutos3]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos3'
end
GO

declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [PorcentajeIBrutos3]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 09-06-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos3'
end
GO
--------------------<< 18/06/2009>>----------------------
declare @esta1 int
exec _AlterTable 'Subcontratos','Item', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Subcontratos] ADD
    [Item]  [Varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-06-09',
     N'user', N'dbo', N'table', N'Subcontratos', N'column', N'Item'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','NumeroSubcontrato', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [NumeroSubcontrato]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-06-09',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'NumeroSubcontrato'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdSubcontrato', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdSubcontrato]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18-06-09',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdSubcontrato'
end
GO
--------------------<< 24/06/2009>>----------------------
declare @esta1 int
exec _AlterTable 'Recepciones','IdRecepcionSAT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdRecepcionSAT]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdRecepcionSAT'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdSalidaMaterialesSAT', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdSalidaMaterialesSAT]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdSalidaMaterialesSAT'
end
GO
declare @esta1 int
exec _AlterTable 'Pedidos','NumeroSubcontrato', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [NumeroSubcontrato]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'NumeroSubcontrato'
end
GO
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','CondicionPago', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [CondicionPago]  [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'CondicionPago'
end
GO

declare @esta1 int
exec _AlterTable 'SubcontratosDatos','AnticipoFinanciero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [AnticipoFinanciero]  [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'AnticipoFinanciero'
end
GO

declare @esta1 int
exec _AlterTable 'SubcontratosDatos','Acopio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [Acopio]  [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'Acopio'
end
GO

declare @esta1 int
exec _AlterTable 'SubcontratosDatos','FondoReparo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [FondoReparo]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'FondoReparo'
end
GO
--------------------<< 09-07-09 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','AmpliacionSubcontrato', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [AmpliacionSubcontrato]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-06-09',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'AmpliacionSubcontrato'
end
GO
--------------------<< 24-07-09 >>----------------------
declare @esta1 int
exec _AlterTable 'Vendedores','Cuit', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Vendedores] ADD
    [Cuit]  [Varchar] (13) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-07-09',
     N'user', N'dbo', N'table', N'Vendedores', N'column', N'Cuit'
end
GO

--------------------<< 28-07-09 >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','TomarEnCuboDeGastos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [TomarEnCuboDeGastos]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-07-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'TomarEnCuboDeGastos'
end
GO
--------------------<< 29-07-09 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoCuentas','IdTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoCuentas] ADD
    [IdTarjetaCredito]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-07-09',
     N'user', N'dbo', N'table', N'DetalleOrdenesPagoCuentas', N'column', N'IdTarjetaCredito'
end
GO
--------------------<< 29-07-09 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleFacturas','PorcentajeCertificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
	ALTER TABLE [dbo].[DetalleFacturas]
		ALTER COLUMN  [PorcentajeCertificacion] [numeric](18,10) NULL
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeDevolucionAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
	ALTER TABLE [dbo].[Facturas]
		ALTER COLUMN  [PorcentajeDevolucionAnticipo] [numeric](18,10) NULL
end
GO
--------------------<< 06-08-09 >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','IdPuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [IdPuntoVenta]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdPuntoVenta'
end
GO
declare @esta1 int
exec _AlterTable 'Pedidos','PuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [PuntoVenta]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'PuntoVenta'
end
GO
--------------------<< 14-08-09 >>----------------------
declare @esta1 int
exec _AlterTable 'PuntosVenta','WebService', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [WebService]  [Varchar] (5) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'WebService'
end
GO
declare @esta1 int
exec _AlterTable 'PuntosVenta','WebServiceModoTest', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [WebServiceModoTest]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'WebServiceModoTest'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','IdIdentificacionCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [IdIdentificacionCAE]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIdentificacionCAE'
end
GO
declare @esta1 int
exec _AlterTable 'Empresa','ArchivoAFIP', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [ArchivoAFIP]  [Varchar] (50) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'ArchivoAFIP'
end
GO
declare @esta1 int
exec _AlterTable 'NotasDebito','CAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [CAE]  [Varchar] (14) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'CAE'
end
GO
declare @esta1 int
exec _AlterTable 'NotasDebito','RechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [RechazoCAE]  [Varchar] (11) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RechazoCAE'
end
GO

declare @esta1 int
exec _AlterTable 'NotasDebito','FechaVencimientoORechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [FechaVencimientoORechazoCAE]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'FechaVencimientoORechazoCAE'
end
GO
declare @esta1 int
exec _AlterTable 'NotasDebito','IdIdentificacionCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [IdIdentificacionCAE]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIdentificacionCAE'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','CAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [CAE]  [Varchar] (14) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CAE'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','RechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [RechazoCAE]  [Varchar] (11) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RechazoCAE'
end
GO

declare @esta1 int
exec _AlterTable 'NotasCredito','FechaVencimientoORechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [FechaVencimientoORechazoCAE]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'FechaVencimientoORechazoCAE'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','IdIdentificacionCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [IdIdentificacionCAE]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIdentificacionCAE'
end
GO
declare @esta1 int
exec _AlterTable 'Conceptos','CodigoAFIP', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Conceptos] ADD
    [CodigoAFIP]  [Varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Conceptos', N'column', N'CodigoAFIP'
end
GO
--------------------<< 25-09-09 >>----------------------
declare @esta1 int
exec _AlterTable 'CuentasGastos','Titulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasGastos] ADD
    [Titulo]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'CuentasGastos', N'column', N'Titulo'
end
GO
declare @esta1 int
exec _AlterTable 'CuentasGastos','Nivel', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasGastos] ADD
    [Nivel]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'CuentasGastos', N'column', N'Nivel'
end
GO
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','EsDevolucion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[UnidadesEmpaque] ADD
    [EsDevolucion]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'EsDevolucion'
end
GO

--------------------<< 07/10/2009 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosConsumos','IdEntidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodosConsumos] ADD
    [IdEntidad]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodosConsumos', N'column', N'IdEntidad'
end
GO
--------------------<< 09/10/2009 >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [ConfirmadoPorWeb]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ConfirmadoPorWeb'
end
GO

--------------------<< 09/10/2009 >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [ConfirmadoPorWeb]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ConfirmadoPorWeb'
end
GO

declare @esta1 int
exec _AlterTable 'Presupuestos','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [ConfirmadoPorWeb]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'ConfirmadoPorWeb'
end
GO
declare @esta1 int
exec _AlterTable 'Presupuestos','FechaCierreCompulsa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [FechaCierreCompulsa]  [datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06-08-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'FechaCierreCompulsa'
end
GO
--------------------<< 10/11/09 >>----------------------
declare @esta1 int
exec _AlterTable 'Recepciones','TipoRecepcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [TipoRecepcion]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'TipoRecepcion'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdObra]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdObra'
end
GO


--------------------<< 16/11/09 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    [IdPresupuestoObrasNodo]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdPresupuestoObrasNodo'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdUbicacionDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdUbicacionDestino]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdUbicacionDestino'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdObraOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdObraOrigen]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdObraOrigen'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroRemitoPreimpreso1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [NumeroRemitoPreimpreso1]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroRemitoPreimpreso1'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroRemitoPreimpreso2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [NumeroRemitoPreimpreso2]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroRemitoPreimpreso2'
end
GO
--------------------<< 03/12/09 >>----------------------
declare @esta1 int
exec _AlterTable 'ImpuestosDirectos','TopeAnual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ImpuestosDirectos] ADD
    [TopeAnual]  [numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-11-09',
     N'user', N'dbo', N'table', N'ImpuestosDirectos', N'column', N'TopeAnual'
end
GO
--------------------<< 24/12/09 >>----------------------ESTE CAMPO NO APARECE EN NOVEDADES
declare @esta1 int
exec _AlterTable 'OrdenesPago','RecalculoRetencionesUltimaModificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [RecalculoRetencionesUltimaModificacion]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'RecalculoRetencionesUltimaModificacion'
end
GO

--------------------<< 24/12/09 >>----------------------ESTE CAMPO NO APARECE EN NOVEDADES
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [ConfirmadoPorWeb]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ConfirmadoPorWeb'
end
GO
declare @esta1 int
exec _AlterTable 'Presupuestos','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [ConfirmadoPorWeb]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'ConfirmadoPorWeb'
end
GO
declare @esta1 int
exec _AlterTable 'Presupuestos','FechaCierreCompulsa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [FechaCierreCompulsa]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'FechaCierreCompulsa'
end
GO

declare @esta1 int
exec _AlterTable 'Presupuestos','NombreUsuarioWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [NombreUsuarioWeb]  [NVarchar] (256) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'NombreUsuarioWeb'
end
GO
declare @esta1 int
exec _AlterTable 'Presupuestos','FechaRespuestaweb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Presupuestos] ADD
    [FechaRespuestaweb]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'Presupuestos', N'column', N'FechaRespuestaweb'
end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [ConfirmadoPorWeb]  [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24-12-09',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'ConfirmadoPorWeb'
end
GO
--------------------<< 05/01/10 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosPxQ','NumeroCertificado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosPxQ] ADD
    [NumeroCertificado]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-01-10',
     N'user', N'dbo', N'table', N'SubcontratosPxQ', N'column', N'NumeroCertificado'
end
GO
--------------------<< 08/01/10 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdDetalleSubcontratoDatos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleComprobantesProveedores] ADD
    [IdDetalleSubcontratoDatos]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdDetalleSubcontratoDatos'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','PorcentajeCertificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [PorcentajeCertificacion]  [Numeric](6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'PorcentajeCertificacion'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','PorcentajeFondoReparo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [PorcentajeFondoReparo]  [Numeric](6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'PorcentajeFondoReparo'
end
GO
--------------------<< 12/01/10 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','OtrosDescuentos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [OtrosDescuentos]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'OtrosDescuentos'
end
GO
declare @esta1 int
exec _AlterTable 'SubcontratosPxQ','CantidadAvanceAcumulada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosPxQ] ADD
    [CantidadAvanceAcumulada]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'SubcontratosPxQ', N'column', N'CantidadAvanceAcumulada'
end
GO
----------------------<<15-01-2010>>-----------------------------
declare @esta1 int
exec _AlterTable 'Proveedores','PorcentajeIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [PorcentajeIBDirectoCapital]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'PorcentajeIBDirectoCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Proveedores','FechaInicioVigenciaIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaInicioVigenciaIBDirectoCapital]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaInicioVigenciaIBDirectoCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Proveedores','FechaFinVigenciaIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [FechaFinVigenciaIBDirectoCapital]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaFinVigenciaIBDirectoCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Proveedores','GrupoIIBBCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [GrupoIIBBCapital]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'GrupoIIBBCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','PorcentajeIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [PorcentajeIBDirectoCapital]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'PorcentajeIBDirectoCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','FechaInicioVigenciaIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaInicioVigenciaIBDirectoCapital]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaInicioVigenciaIBDirectoCapital'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','FechaFinVigenciaIBDirectoCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [FechaFinVigenciaIBDirectoCapital]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaFinVigenciaIBDirectoCapital'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','GrupoIIBBCapital', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [GrupoIIBBCapital]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'GrupoIIBBCapital'
end
GO
--------------------<< 02-02-10 >>----------------------
ALTER TABLE [dbo].[Articulos]
       ALTER COLUMN [CostoPPP] numeric (18,4)

Go
ALTER TABLE [dbo].[Articulos]
       ALTER COLUMN [CostoPPPDolar] numeric (18,4)

Go
ALTER TABLE [dbo].[DetalleRecepciones]
       ALTER COLUMN [CostoUnitario] numeric (18,4)
declare @esta1 int
exec _AlterTable 'OrdenesPago','IdImpuestoDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [IdImpuestoDirecto]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'IdImpuestoDirecto'
end
GO
--------------------<< 11/02/10 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatosPedidos','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatosPedidos] ADD
    [ArchivoAdjunto1]  [varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatosPedidos', N'column', N'ArchivoAdjunto1'
end
GO
--------------------<< 12/02/10 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','PorcentajeAnticipoFinanciero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [PorcentajeAnticipoFinanciero]  [numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08-01-10',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'PorcentajeAnticipoFinanciero'
end
GO

--------------------<< 19/02/10 >>----------------------
declare @esta1 int
exec _AlterTable 'Comparativas','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [ArchivoAdjunto1]  [varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'Comparativas', N'column', N'ArchivoAdjunto1'
end
GO
declare @esta1 int
exec _AlterTable 'Comparativas','ArchivoAdjunto2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [ArchivoAdjunto2]  [varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'Comparativas', N'column', N'ArchivoAdjunto2'
end
GO
--------------------<< 05/03/10 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosPxQ','ImporteDescuento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosPxQ] ADD
    [ImporteDescuento]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'SubcontratosPxQ', N'column', N'ImporteDescuento'
end
GO
declare @esta1 int
exec _AlterTable 'SubcontratosPxQ','ImporteTotal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosPxQ] ADD
    [ImporteTotal]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'SubcontratosPxQ', N'column', N'ImporteTotal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','PorcentajeIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [PorcentajeIVA]  [Numeric] (6,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'PorcentajeIVA'
end
GO
--------------------<< 08/03/10 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','IdMoneda', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [IdMoneda]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-02-10',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'IdMoneda'
end
GO
--------------------<< 31/03/10 >>----------------------
declare @esta1 int
exec _AlterTable 'Bancos','CodigoResumen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Bancos] ADD
    [CodigoResumen]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 31-03-10',
     N'user', N'dbo', N'table', N'Bancos', N'column', N'CodigoResumen'
end
go

--------------------<< 12/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Provincias','IdCuentaPercepcionIIBBComprasJurisdiccionLocal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Provincias] ADD
    [IdCuentaPercepcionIIBBComprasJurisdiccionLocal]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12/04/2010',
     N'user', N'dbo', N'table', N'Provincias', N'column', N'IdCuentaPercepcionIIBBComprasJurisdiccionLocal'
end
go

declare @esta1 int
exec _AlterTable 'Empresa','NumeroAgentePercepcionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [NumeroAgentePercepcionIIBB]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12/04/2010',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'NumeroAgentePercepcionIIBB'
end
go
declare @esta1 int
exec _AlterTable 'Empresa','DigitoVerificadorNumeroAgentePercepcionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [DigitoVerificadorNumeroAgentePercepcionIIBB]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 12/04/2010',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'DigitoVerificadorNumeroAgentePercepcionIIBB'
end
go

--------------------<< 13/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [Observaciones]  [ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 13/04/2010',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'Observaciones'
end
go

declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [Observaciones]  [ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 13/04/2010',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'Observaciones'
end
go

--------------------<< 16/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','IdCuentaProvision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [IdCuentaProvision]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 16/04/2010',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdCuentaProvision'
end
go
--------------------<< 22/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','AjusteIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [AjusteIva]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22/04/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'AjusteIva'
end
go
--------------------<< 28/04/2010 >>----------------------

declare @esta1 int
exec _AlterTable 'Paises','Codigo2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Paises] ADD
    [Codigo2]  [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-04-10',
     N'user', N'dbo', N'table', N'Paises', N'column', N'Codigo2'
end
GO

declare @esta1 int
exec _AlterTable 'Paises','Cuit', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Paises] ADD
    [Cuit]  [varchar] (11) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-04-10',
     N'user', N'dbo', N'table', N'Paises', N'column', N'Cuit'
end
GO

declare @esta1 int
exec _AlterTable 'Facturas','TipoExportacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [TipoExportacion]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/04/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'TipoExportacion'
end
go
declare @esta1 int
exec _AlterTable 'Facturas','PermisoEmbarque', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [PermisoEmbarque]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28-04-10',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'PermisoEmbarque'
end
GO
--------------------<< 29/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Empresa','ModalidadFacturacionAPrueba', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [ModalidadFacturacionAPrueba]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29-04-10',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'ModalidadFacturacionAPrueba'
end
GO

--------------------<< 30/04/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras1]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras1'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras2]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras2'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras3]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras3'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras4]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras4'
end
go
declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras5]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras5'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras6', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras6]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras6'
end
go
declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras7', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras7]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras7'
end
go
declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras8', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras8]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras8'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras9', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras9]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras9'
end
go

declare @esta1 int
exec _AlterTable 'Rubros','IdCuentaCompras10', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Rubros] ADD
    [IdCuentaCompras10]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'Rubros', N'column', N'IdCuentaCompras10'
end
go
--------------------<< 10/05/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','FechaCertificadoDesde', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [FechaCertificadoDesde]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-05-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'FechaCertificadoDesde'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','FechaCertificadoHasta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    [FechaCertificadoHasta]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-05-10',
     N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'FechaCertificadoHasta'
end
GO
--------------------<< 11/05/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','Anulado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [Anulado]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-05-10',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'Anulado'
end
GO
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','IdUsuarioAnulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [IdUsuarioAnulo]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/2010',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'IdUsuarioAnulo'
end
go
declare @esta1 int
exec _AlterTable 'SubcontratosDatos','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [FechaAnulacion]  [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-05-10',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'FechaAnulacion'
end
GO

declare @esta1 int
exec _AlterTable 'SubcontratosDatos','MotivoAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    [MotivoAnulacion]  [Ntext] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10-05-10',
     N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'MotivoAnulacion'
end
GO
--------------------<< 12/05/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [CircuitoFirmasCompleto]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 11-05-10',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'CircuitoFirmasCompleto'
end
GO
--------------------<< 26/05/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroRemitoTransporte1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroRemitoTransporte1]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/05/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroRemitoTransporte1'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroRemitoTransporte2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroRemitoTransporte2]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/05/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroRemitoTransporte2'
end
GO
declare @esta1 int
exec _AlterTable 'PuntosVenta','CAEManual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PuntosVenta] ADD
    [CAEManual]  [varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26-05-10',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'CAEManual'
end
GO
--------------------<< 26/05/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosConsumos','Cantidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodosConsumos] ADD
    [Cantidad]  [Numeric] (19,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/06/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodosConsumos', N'column', N'Cantidad'
end
GO
--------------------<< 01/07/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdPresupuestoObraGrupoMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [IdPresupuestoObraGrupoMateriales]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdPresupuestoObraGrupoMateriales'
end
GO
--------------------<< 13/07/2010 >>----------------------
declare @esta1 int
exec _AlterTable 'TarifasFletes','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TarifasFletes] ADD
    [Codigo]  [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'Codigo'
end
GO
declare @esta1 int
exec _AlterTable 'TarifasFletes','LimiteInferior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TarifasFletes] ADD
    [LimiteInferior]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'LimiteInferior'
end
GO
declare @esta1 int
exec _AlterTable 'TarifasFletes','LimiteSuperior', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TarifasFletes] ADD
    [LimiteSuperior]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'LimiteSuperior'
end
GO
declare @esta1 int
exec _AlterTable 'TarifasFletes','IdUnidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[TarifasFletes] ADD
    [IdUnidad]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'IdUnidad'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','ImpuestosInternos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [ImpuestosInternos]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'ImpuestosInternos'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','PercepcionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [PercepcionIIBB]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'PercepcionIIBB'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','PercepcionIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [PercepcionIVA]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'PercepcionIVA'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','ImporteIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [ImporteIVA]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'ImporteIVA'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','Chofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [Chofer]  [Varchar] (50)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'Chofer'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','Patente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [Patente]  [Varchar] (10)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'Patente'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','NumeroRemitoTransporte1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [NumeroRemitoTransporte1]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'NumeroRemitoTransporte1'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','NumeroRemitoTransporte2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [NumeroRemitoTransporte2]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'NumeroRemitoTransporte2'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','IdChofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [IdChofer]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'IdChofer'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','IdFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [IdFlete]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'IdFlete'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','PesoBruto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [PesoBruto]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'PesoBruto'
end
GO

declare @esta1 int
exec _AlterTable 'RecepcionesSAT','PesoNeto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [PesoNeto]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'PesoNeto'
end
GO

declare @esta1 int
exec _AlterTable 'RecepcionesSAT','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [Tara]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'Tara'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','CantidadEnOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [CantidadEnOrigen]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'CantidadEnOrigen'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','DistanciaRecorrida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [DistanciaRecorrida]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'DistanciaRecorrida'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','CodigoTarifador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [CodigoTarifador]  [varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'CodigoTarifador'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','NumeroOrdenCarga', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [NumeroOrdenCarga]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'NumeroOrdenCarga'
end
GO
declare @esta1 int
exec _AlterTable 'RecepcionesSAT','IdPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RecepcionesSAT] ADD
    [IdPesada]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'RecepcionesSAT', N'column', N'IdPesada'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','MotivoAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [MotivoAnulacion]  [ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'MotivoAnulacion'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','NumeroRemitoTransporte1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [NumeroRemitoTransporte1]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'NumeroRemitoTransporte1'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','NumeroRemitoTransporte2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [NumeroRemitoTransporte2]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'NumeroRemitoTransporte2'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','IdChofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [IdChofer]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'IdChofer'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','IdFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [IdFlete]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'IdFlete'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','PesoBruto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [PesoBruto]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'PesoBruto'
end
GO


declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','PesoNeto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [PesoNeto]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'PesoNeto'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [Tara]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'Tara'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','CantidadEnOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [CantidadEnOrigen]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'CantidadEnOrigen'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','DistanciaRecorrida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [DistanciaRecorrida]  [Numeric] (18,2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'DistanciaRecorrida'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','CodigoTarifador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [CodigoTarifador]  [varchar] (10)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'CodigoTarifador'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMaterialesSAT','IdPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMaterialesSAT] ADD
    [IdPesada]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'SalidasMaterialesSAT', N'column', N'IdPesada'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdChofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdChofer]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdChofer'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdFlete]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdFlete'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','PesoBruto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [PesoBruto]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'PesoBruto'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','PesoNeto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [PesoNeto]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'PesoNeto'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [Tara]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'Tara'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','CantidadEnOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [CantidadEnOrigen]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'CantidadEnOrigen'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','DistanciaRecorrida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [DistanciaRecorrida]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'DistanciaRecorrida'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','CodigoTarifador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [CodigoTarifador]  [Varchar] (10)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'CodigoTarifador'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroOrdenCarga', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroOrdenCarga]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroOrdenCarga'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdPesada]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdPesada'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','IdTarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [IdTarifaFlete]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'IdTarifaFlete'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','TarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [TarifaFlete]  [Numeric] (18,2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Recepciones', N'column', N'TarifaFlete'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdFlete]  [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdFlete'
end
GO

----------------------------<<15/07/2010>>-------------------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','DetalleImputacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Requerimientos] ADD
    [DetalleImputacion]  [varchar] (50)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 01/07/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'DetalleImputacion'
end
GO
----------------------------<<16/07/2010>>-------------------------------
declare @esta1 int
exec _AlterTable 'Remitos','HoraSalida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [HoraSalida]  [varchar] (10)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 16/07/2010',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'HoraSalida'
end
GO
declare @esta1 int
exec _AlterTable 'Remitos','PesoBruto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [PesoBruto]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 16/07/2010',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'PesoBruto'
end
GO

declare @esta1 int
exec _AlterTable 'Remitos','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Remitos] ADD
    [Tara]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 16/07/2010',
     N'user', N'dbo', N'table', N'Remitos', N'column', N'Tara'
end
GO
----------------------------<<29/07/2010>>-------------------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdCuentaGasto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [IdCuentaGasto]  [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/07/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdCuentaGasto'
end
GO
----------------------------<<02/08/2010>>-------------------------------
declare @esta1 int
exec _AlterTable 'Choferes','NumeroDocumento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Choferes] ADD
    [NumeroDocumento]  [varchar] (20) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/07/2010',
     N'user', N'dbo', N'table', N'Choferes', N'column', N'NumeroDocumento'
end
GO

declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdFlete]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/07/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdFlete'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdChofer', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdChofer]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/07/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdChofer'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','DestinoDeObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [DestinoDeObra]  [varchar] (50)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/07/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'DestinoDeObra'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdSubrubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [IdSubrubro]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdSubrubro'
end
GO
----------------------------<09/08/2010>---------------------------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [SubItem1]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem1'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [SubItem2]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem2'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [SubItem3]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem3'
end
GO
------------------------<12-08-10>--------------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMaterialesPresupuestosObras','IdDetalleSalidaMaterialesKit', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMaterialesPresupuestosObras] ADD
    [IdDetalleSalidaMaterialesKit]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMaterialesPresupuestosObras', N'column', N'IdDetalleSalidaMaterialesKit'
end
GO
declare @esta1 int
exec _AlterTable 'Obras','EsPlantaDeProduccionInterna', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [EsPlantaDeProduccionInterna]  [varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'Obras', N'column', N'EsPlantaDeProduccionInterna'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosConsumos','IdObraOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodosConsumos] ADD
    [IdObraOrigen]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodosConsumos', N'column', N'IdObraOrigen'
end
GO
------------------------<13-08-10>--------------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMaterialesKits','CostoUnitario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMaterialesKits] ADD
    [CostoUnitario]  [Numeric] (18,4)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 6/08/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMaterialesKits', N'column', N'CostoUnitario'
end
GO
------------------------<06-09-10>--------------------------
declare @esta1 int
exec _AlterTable 'Obras','ActivarPresupuestoObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [ActivarPresupuestoObra]  [Varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Obras', N'column', N'ActivarPresupuestoObra'
end
GO
------------------------<07-09-10>--------------------------
declare @esta1 int
exec _AlterTable 'Conjuntos','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Conjuntos] ADD
    [IdObra]  [Int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Conjuntos', N'column', N'IdObra'
end
GO
------------------------<14-09-10>--------------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdDetalleRecepcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdDetalleRecepcion]  [Int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdDetalleRecepcion'
end
GO
ALTER TABLE [dbo].[SalidasMateriales]
         ALTER COLUMN [NumeroRemitoTransporte] Varchar (15)
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','PesoBruto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [PesoBruto]  [numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'PesoBruto'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','PesoNeto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [PesoNeto]  [numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'PesoNeto'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [Tara]  [numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Tara'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','CantidadEnOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [CantidadEnOrigen]  [numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'CantidadEnOrigen'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','DistanciaRecorrida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [DistanciaRecorrida]  [numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'DistanciaRecorrida'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','CodigoTarifador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [CodigoTarifador]  [Varchar] (10)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'CodigoTarifador'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdPesada]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdPesada'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdTarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdTarifaFlete]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdTarifaFlete'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','TarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [TarifaFlete]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'TarifaFlete'
end
GO

--------------- << 04/10/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'Facturas','NumeroFacturaInicial', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [NumeroFacturaInicial]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroFacturaInicial'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','NumeroFacturaFinal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [NumeroFacturaFinal]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroFacturaFinal'
end
GO
--------------- << 06/10/2010 >> ----------------  
declare @esta1 int
exec _AlterTable 'Facturas','CodigoIdAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    [CodigoIdAuxiliar]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'CodigoIdAuxiliar'
end
GO

declare @esta1 int
exec _AlterTable 'NotasCredito','CodigoIdAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [CodigoIdAuxiliar]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CodigoIdAuxiliar'
end
GO
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdLiquidacionFlete]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdLiquidacionFlete'
end
GO
declare @esta1 int
exec _AlterTable 'Obras','ProximoNumeroAutorizacionCompra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [ProximoNumeroAutorizacionCompra]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Obras', N'column', N'ProximoNumeroAutorizacionCompra'
end
GO
-----------------<<14-10-10>>-------------------
declare @esta1 int
exec _AlterTable 'Obras','ProximoNumeroAutorizacionCompra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [ProximoNumeroAutorizacionCompra]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/09/2010',
     N'user', N'dbo', N'table', N'Obras', N'column', N'ProximoNumeroAutorizacionCompra'
end
GO
ALTER TABLE [dbo].[Articulos]
         ALTER COLUMN [ValorOrigenContable] Numeric (19,6)
GO
ALTER TABLE [dbo].[Articulos]
         ALTER COLUMN [ValorOrigenImpositivo] Numeric (19,6)
GO

-----------------<<26-10-10>>-------------------
declare @esta1 int
exec _AlterTable 'NotasCredito','NumeroFacturaOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    [NumeroFacturaOriginal]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'NumeroFacturaOriginal'
end
GO

ALTER TABLE [dbo].[Articulos]
         ALTER COLUMN [ValorOrigenContable] Numeric (19,6)

ALTER TABLE [dbo].[Articulos]
         ALTER COLUMN [ValorOrigenImpositivo] Numeric (19,6)
-----------------------<16-09-10>--------------------------

/*ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [Importe] Numeric (18,8)*/
	   
/*ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [Cantidad] Numeric (18,8)*/
       
       	 
-----------------------<16-09-10>--------------------------

ALTER TABLE [dbo].[SalidasMateriales]
       ALTER COLUMN [NumeroRemitoTransporte] varchar (15)
  

--------------- << 29/07/2010 >> ----------------   
    
ALTER TABLE [dbo].[CuentasGastos]
         ALTER COLUMN [Codigo] Varchar (20)
--------------- << 04/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdEquipoDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleComprobantesProveedores ADD
    [IdEquipoDestino]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdEquipoDestino'
end
GO
--------------- << 10/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'Stock','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Stock ADD
    [IdColor]  [Int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Stock', N'column', N'IdColor'
end
GO

declare @esta1 int
exec _AlterTable 'Stock','Equivalencia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Stock ADD
    [Equivalencia]  [Numeric] (18,6)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Stock', N'column', N'Equivalencia'
end
GO
declare @esta1 int
exec _AlterTable 'Stock','CantidadEquivalencia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Stock ADD
    [CantidadEquivalencia]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Stock', N'column', N'CantidadEquivalencia'
end
GO
--------------- << 11/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'Facturas','NumeroCertificadoObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [NumeroCertificadoObra]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroCertificadoObra'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','ImporteCertificacionObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [ImporteCertificacionObra]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'ImporteCertificacionObra'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','FondoReparoCertificacionObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0 
 ALTER TABLE [dbo].Facturas ADD
    [FondoReparoCertificacionObra]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'FondoReparoCertificacionObra'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeRetencionesEstimadasCertificacionObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [PorcentajeRetencionesEstimadasCertificacionObra]  [Numeric] (6,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeRetencionesEstimadasCertificacionObra'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','NumeroExpedienteCertificacionObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [NumeroExpedienteCertificacionObra]  [Varchar] (20)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/10/2010',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroExpedienteCertificacionObra'
end
GO
--------------- << 15/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'Cuentas','OrdenamientoAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Cuentas ADD
    [OrdenamientoAuxiliar]  [int]   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/11/2010',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'OrdenamientoAuxiliar'
end
GO
--------------- << 16/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','NumeroCAE', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    [NumeroCAE]  [varchar] (20)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 16/11/2010',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'NumeroCAE'
end
GO

--------------- << 25/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','ADesignar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAutorizaciones ADD
    [ADesignar]  [varchar] (2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'ADesignar'
end
GO

--------------- << 30/11/2010 >> ----------------   
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','CantidadBase', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [CantidadBase]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'CantidadBase'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Rendimiento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [Rendimiento]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'Rendimiento'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Incidencia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [Incidencia]  [Numeric] (18,8)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'Incidencia'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Costo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [Costo]  [Numeric] (18,8)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'Costo'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosPxQxPresupuesto','CantidadTeorica', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodosPxQxPresupuesto ADD
    [CantidadTeorica]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/11/2010',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodosPxQxPresupuesto', N'column', N'CantidadTeorica'
end
GO

--Esto es solo para arreglar mocos--

ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [Incidencia] Numeric (18,8)
	   
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [Costo] Numeric (18,8)

--------------- << 06/12/2010	>> ----------------   
declare @esta1 int
exec _AlterTable 'Requerimientos','IdUsuarioDeslibero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [IdUsuarioDeslibero]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'IdUsuarioDeslibero'
end
GO
declare @esta1 int
exec _AlterTable 'Requerimientos','FechaDesliberacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [FechaDesliberacion]  [DateTime]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'FechaDesliberacion'
end
GO
declare @esta1 int
exec _AlterTable 'Requerimientos','NumeradorDesliberaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [NumeradorDesliberaciones]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'NumeradorDesliberaciones'
end
GO
declare @esta1 int
exec _AlterTable 'Requerimientos','IdUsuarioEliminoFirmas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [IdUsuarioEliminoFirmas]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'IdUsuarioEliminoFirmas'
end
GO
declare @esta1 int
exec _AlterTable 'Requerimientos','FechaEliminacionFirmas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [FechaEliminacionFirmas]  [DateTime]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'FechaEliminacionFirmas'
end
GO
declare @esta1 int
exec _AlterTable 'Requerimientos','NumeradorEliminacionesFirmas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [NumeradorEliminacionesFirmas]  [int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 06/12/2010',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'NumeradorEliminacionesFirmas'
end
GO
--------------- << 21/12/2010	>> ----------------   
declare @esta1 int
exec _AlterTable 'DetallePedidos','CostoOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetallePedidos ADD
    [CostoOriginal] [Numeric] (18,4) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetallePedidos', N'column', N'CostoOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetallePedidos','IdUsuarioModificoCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetallePedidos ADD
    [IdUsuarioModificoCosto] [Int]				 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetallePedidos', N'column', N'IdUsuarioModificoCosto'
end
GO

declare @esta1 int
exec _AlterTable 'DetallePedidos','FechaModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetallePedidos ADD
    [FechaModificacionCosto] [Datetime]				 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetallePedidos', N'column', N'FechaModificacionCosto'
end
GO
declare @esta1 int
exec _AlterTable 'DetallePedidos','ObservacionModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetallePedidos ADD
    [ObservacionModificacionCosto] [Ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetallePedidos', N'column', N'ObservacionModificacionCosto'
end
GO
------------------
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','CostoOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
     [CostoOriginal] [Numeric]	(18,4)	 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'CostoOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdUsuarioModificoCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
     [IdUsuarioModificoCosto] [Int]			 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdUsuarioModificoCosto'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','FechaModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
      [FechaModificacionCosto] [Datetime]				 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'FechaModificacionCosto'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','ObservacionModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
     [ObservacionModificacionCosto] [Ntext] 	 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'ObservacionModificacionCosto'
end
GO
	 			 			 
---------------------

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','CostoOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
     [CostoOriginal] [Numeric]	(18,4)	 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'CostoOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdUsuarioModificoCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
     [IdUsuarioModificoCosto] [Int]	 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdUsuarioModificoCosto'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','FechaModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
      [FechaModificacionCosto] [Datetime]	 NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'FechaModificacionCosto'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','ObservacionModificacionCosto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
     [ObservacionModificacionCosto] [Ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 21/12/2010',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'ObservacionModificacionCosto'
end
GO
-- ALTER COLUM

ALTER TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto]
       ALTER COLUMN [Importe] [Numeric] (18,4)

ALTER TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto]
       ALTER COLUMN [Cantidad] [Numeric] (18,8)
       
ALTER TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto]
       ALTER COLUMN [ImporteAvance] [Numeric] (18,4)

ALTER TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto]
       ALTER COLUMN [CantidadAvance] [Numeric] (18,8)
       
ALTER TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto]
       ALTER COLUMN  [CantidadTeorica] [Numeric] (18,8)
       
       
--------------- << 22/12/2010	>> ----------------   
declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP2_Letra_A', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    [CodigoAFIP2_Letra_A] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22/12/2010',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP2_Letra_A'
end
GO
declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP2_Letra_B', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    [CodigoAFIP2_Letra_B] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22/12/2010',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP2_Letra_B'
end
GO

declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP2_Letra_C', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    [CodigoAFIP2_Letra_C] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22/12/2010',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP2_Letra_C'
end
GO
declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP2_Letra_E', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    [CodigoAFIP2_Letra_E] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 22/12/2010',
     N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP2_Letra_E'
end
GO

--------------- << 28/12/2010	>> ----------------   
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','IdDetalleRecepcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].UnidadesEmpaque ADD
    [IdDetalleRecepcion] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/12/2010',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'IdDetalleRecepcion'
end
GO
--------------- << 07/01/2011	>> ----------------   
declare @esta1 int
exec _AlterTable 'OrdenesPago','NumeroReciboProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    [NumeroReciboProveedor] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07/01/2011',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'NumeroReciboProveedor'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesPago','FechaReciboProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    [FechaReciboProveedor] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 07/01/2011',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'FechaReciboProveedor'
end
GO
declare @esta1 int
exec _AlterTable 'Pedidos','IdMonedaOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    [IdMonedaOriginal] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10/01/2011',
     N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdMonedaOriginal'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdMonedaOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    [IdMonedaOriginal] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10/01/2011',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdMonedaOriginal'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdMonedaOriginal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    [IdMonedaOriginal] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 10/01/2011',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdMonedaOriginal'
end
GO
--------------- << 24/01/2011	>> ----------------
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','Metros', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].UnidadesEmpaque ADD
    [Metros]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'Metros'
end
GO
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','TipoRollo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].UnidadesEmpaque ADD
    [TipoRollo] [Varchar] (1) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'TipoRollo'
end
GO

declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].UnidadesEmpaque ADD
    [Observaciones] [Ntext]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'Observaciones'
end
GO
declare @esta1 int
exec _AlterTable 'UnidadesEmpaque','PartidasOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].UnidadesEmpaque ADD
    [PartidasOrigen] [Varchar] (110) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'UnidadesEmpaque', N'column', N'PartidasOrigen'
end
GO

-- ALTER COLUM

ALTER TABLE [dbo].[Ubicaciones]
       ALTER COLUMN  [Modulo] [Varchar] (4)
       
--------------- << 28/01/2011	>> ----------------

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','NumeroCaja', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    [NumeroCaja] [Int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'NumeroCaja'
end
GO

--------------- << 17/02/2011	>> ----------------
declare @esta1 int
exec _AlterTable 'Requerimientos','NumeradorModificaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [NumeradorModificaciones] [Int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/02/2011',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'NumeradorModificaciones'
end
GO


--------------- << 22/02/2011	>> ----------------
declare @esta1 int
exec _AlterTable 'SubcontratosPxQ','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SubcontratosPxQ ADD
    [IdPresupuestoObrasNodo] [Int]  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/02/2011',
     N'user', N'dbo', N'table', N'SubcontratosPxQ', N'column', N'IdPresupuestoObrasNodo'
end
GO

--------------- << 28/02/2011	>> ----------------
declare @esta1 int
exec _AlterTable 'Requerimientos','ParaTaller', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    [ParaTaller] [Varchar] (2)  NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/02/2011',
     N'user', N'dbo', N'table', N'Requerimientos', N'column', N'ParaTaller'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleAutorizacionesFirmantes','IdSubrubro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAutorizacionesFirmantes ADD
    [IdSubrubro] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/02/2011',
     N'user', N'dbo', N'table', N'DetalleAutorizacionesFirmantes', N'column', N'IdSubrubro'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleAutorizacionesFirmantes','ParaTaller', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAutorizacionesFirmantes ADD
    [ParaTaller] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/02/2011',
     N'user', N'dbo', N'table', N'DetalleAutorizacionesFirmantes', N'column', N'ParaTaller'
end
GO

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Importe', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [Importe]
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Cantidad', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [Cantidad]
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','CantidadBase', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [CantidadBase]
end
GO

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Rendimiento', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [Rendimiento]
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Incidencia', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [Incidencia]
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','Costo', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       DROP COLUMN [Costo]
end
GO
-- 17 / 03 /2011
declare @esta1 int
exec _AlterTable 'DetalleSalidasMaterialesPresupuestosObras','IdPresupuestoObrasNodoNoMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMaterialesPresupuestosObras ADD
    [IdPresupuestoObrasNodoNoMateriales] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'DetalleSalidasMaterialesPresupuestosObras', N'column', N'IdPresupuestoObrasNodoNoMateriales'
end
GO

-- 17 / 03 /2011

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdNodoAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [IdNodoAuxiliar] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdNodoAuxiliar'
end
GO

-- 22/03/2011

declare @esta1 int
exec _AlterTable 'Obras','AuxiliarDeMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    [AuxiliarDeMateriales] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Obras', N'column', N'AuxiliarDeMateriales'
end
GO
----07/04/2011

declare @esta1 int
exec _AlterTable 'PartesProduccion','IdPresupuestoObrasNodoMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PartesProduccion ADD
    [IdPresupuestoObrasNodoMateriales] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'PartesProduccion', N'column', N'IdPresupuestoObrasNodoMateriales'
end
GO

----18/04/2011----------

declare @esta1 int
exec _AlterTable 'CertificacionesObras','NumeroProyecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CertificacionesObras ADD
    [NumeroProyecto] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'CertificacionesObras', N'column', N'NumeroProyecto'
end
GO


declare @esta1 int
exec _AlterTable 'Facturas','NumeroProyecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [NumeroProyecto] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroProyecto'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','IdCertificacionObras', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [IdCertificacionObras] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'IdCertificacionObras'
end
GO
declare @esta1 int
exec _AlterTable 'Facturas','IdCertificacionObraDatos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [IdCertificacionObraDatos] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'IdCertificacionObraDatos'
end
GO

declare @esta1 int
exec _AlterTable 'Facturas','FechaRecepcionCliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    [FechaRecepcionCliente] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Facturas', N'column', N'FechaRecepcionCliente'
end
GO
declare @esta1 int
exec _AlterTable 'NotasCredito','FechaRecepcionCliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    [FechaRecepcionCliente] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'FechaRecepcionCliente'
end
GO

----20/04/2011----------

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [SubItem1] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem1'
end
GO

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [SubItem2] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem2'
end
GO

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    [SubItem3] [Varchar] (10) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem3'
end
GO

declare @esta1 int
exec _AlterTable 'Obras','DiasLiquidacionCertificados', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    [DiasLiquidacionCertificados] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Obras', N'column', N'DiasLiquidacionCertificados'
end
GO

----26/05/2011----------

declare @esta1 int
exec _AlterTable 'SalidasMateriales','Detalle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    [Detalle] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Detalle'
end
GO
declare @esta1 int
exec _AlterTable 'TarifasFletes','FechaVigencia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarifasFletes ADD
    [FechaVigencia] [Datetime] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'FechaVigencia'
end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','TextoAuxiliar1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    [TextoAuxiliar1] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'TextoAuxiliar1'
end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','TextoAuxiliar2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    [TextoAuxiliar2] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'TextoAuxiliar2'
end
GO
declare @esta1 int
exec _AlterTable 'Proveedores','TextoAuxiliar3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    [TextoAuxiliar3] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'TextoAuxiliar3'
end
GO
declare @esta1 int
exec _AlterTable 'Cuentas','TextoAuxiliar1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Cuentas ADD
    [TextoAuxiliar1] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'TextoAuxiliar1'
end
GO
declare @esta1 int
exec _AlterTable 'Cuentas','TextoAuxiliar2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Cuentas ADD
    [TextoAuxiliar2] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'TextoAuxiliar2'
end
GO
declare @esta1 int
exec _AlterTable 'Cuentas','TextoAuxiliar3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Cuentas ADD
    [TextoAuxiliar3] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'Cuentas', N'column', N'TextoAuxiliar3'
end
GO
-----Corrección Campo Detalle tabla SalidasMateriales------
alter table SalidasMateriales
alter column Detalle varchar (30)
GO
--------------------<< 30-05-11 >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','TextoAuxiliar1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    [TextoAuxiliar1] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'TextoAuxiliar1'
end
GO
declare @esta1 int
exec _AlterTable 'OrdenesPago','TextoAuxiliar2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    [TextoAuxiliar2] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'TextoAuxiliar2'
end
GO
declare @esta1 int
exec _AlterTable 'OrdenesPago','TextoAuxiliar3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    [TextoAuxiliar3] [Varchar] (100) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 17/03/2011',
     N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'TextoAuxiliar3'
end
GO
--------------------<< 14-06-11 >>----------------------
-- ALTER COLUM
ALTER TABLE [dbo].[DetalleOrdenesPagoValores]
       ALTER COLUMN [ChequesALaOrdenDe] [Varchar] (100)
ALTER TABLE [dbo].[Proveedores]
       ALTER COLUMN [ChequesALaOrdenDe] [Varchar] (100)
GO

declare @esta1 int
exec _AlterTable 'PuntosVenta','Activo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PuntosVenta ADD
    [Activo] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14/06/2011',
     N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'Activo'
end
GO
--------------------<< 05-07-11 >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdProduccionOrden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    [IdProduccionOrden] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdProduccionOrden'
end
GO

declare @esta1 int
exec _AlterTable 'AjustesStock','IdSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].AjustesStock ADD
    [IdSalidaMateriales] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'AjustesStock', N'column', N'IdSalidaMateriales'
end
GO

--------------------<< 22-07-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Bancos','Entidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Bancos ADD
    [Entidad] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'Bancos', N'column', N'Entidad'
end
GO

declare @esta1 int
exec _AlterTable 'Bancos','Subentidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Bancos ADD
    [Subentidad] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'Bancos', N'column', N'Subentidad'
end
GO


--------------------<< 04-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','IdBancoGestionador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    [IdBancoGestionador] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'Clientes', N'column', N'IdBancoGestionador'
end
GO

--------------------<< 08-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'IBCondiciones','CodigoNormaRetencion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    [CodigoNormaRetencion] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'CodigoNormaRetencion'
end
GO
declare @esta1 int
exec _AlterTable 'IBCondiciones','CodigoNormaPercepcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    [CodigoNormaPercepcion] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'CodigoNormaPercepcion'
end
GO


--------------------<< 09-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Empresa','CodigoActividadIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empresa ADD
    [CodigoActividadIIBB] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'CodigoActividadIIBB'
end
GO

--------------------<< 09-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Empresa','CodigoActividadIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empresa ADD
    [CodigoActividadIIBB] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 05-07-11',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'CodigoActividadIIBB'
end
GO

--------------------<< 19-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'IBCondiciones','CodigoActividad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    [CodigoActividad] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-08-11',
     N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'CodigoActividad'
end
GO
--------------------<< 19-08-11 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdDetalleProduccionOrden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    [IdDetalleProduccionOrden] [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-08-11',
     N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdDetalleProduccionOrden'
end
GO

--------------------<< 20-09-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Actividades Proveedores','Agrupacion1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Actividades Proveedores] ADD
    Agrupacion1 [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-08-11',
     N'user', N'dbo', N'table', N'Actividades Proveedores', N'column', N'Agrupacion1'
end
GO

--------------------<< 27-09-11 >>----------------------
declare @esta1 int
exec _AlterTable 'Empresa','ActividadComercializacionGranos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empresa ADD
    [ActividadComercializacionGranos] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14/06/2011',
     N'user', N'dbo', N'table', N'Empresa', N'column', N'ActividadComercializacionGranos'
end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','InscriptoRegistroFiscalOperadoresGranos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    [InscriptoRegistroFiscalOperadoresGranos] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 14/06/2011',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'InscriptoRegistroFiscalOperadoresGranos'
end
GO

declare @esta1 int
exec _AlterTable 'Conceptos','CoeficienteAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Conceptos ADD
    [CoeficienteAuxiliar]  [Numeric] (18,2)   NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 24/01/2011',
     N'user', N'dbo', N'table', N'Conceptos', N'column', N'CoeficienteAuxiliar'
end
GO

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdImpuestoDirecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    IdImpuestoDirecto [Int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19-08-11',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdImpuestoDirecto'
end
GO


--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
ALTER TABLE [dbo].[DetalleProduccionFichaProcesos]
  ALTER COLUMN  [Horas] [numeric](12, 2) NULL
Go
declare @esta1 int
exec _AlterTable 'DetalleProduccionOrdenProcesos','Horas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionOrdenProcesos] ADD
    [Horas] [numeric](12, 2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionOrdenProcesos', N'column', N'Horas'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
  
declare @esta1 int
exec _AlterTable 'DetalleProduccionOrdenProcesos','HorasReales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionOrdenProcesos] ADD
    [HorasReales] [numeric](12, 2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionOrdenProcesos', N'column', N'HorasReales'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','Horas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [Horas] [numeric](12, 2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'Horas'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------


declare @esta1 int
exec _AlterTable 'ProduccionPartes','HorasReales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [HorasReales] [numeric](12, 2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'HorasReales'
end
GO

--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','IdUbicacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [IdUbicacion] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'IdUbicacion'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','Aux_txtStockActual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [Aux_txtStockActual] [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'Aux_txtStockActual'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','Aux_txtPendiente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [Aux_txtPendiente] [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'Aux_txtPendiente'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','Aux_txtTolerancia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [Aux_txtTolerancia] [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'Aux_txtTolerancia'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleProduccionOrdenes','Orden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionOrdenes] ADD
    [Orden] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionOrdenes', N'column', N'Orden'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleProduccionFichas','Orden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionFichas] ADD
    [Orden] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionFichas', N'column', N'Orden'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------

declare @esta1 int
exec _AlterTable 'DetalleProduccionOrdenProcesos','Orden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionOrdenProcesos] ADD
    [Orden] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionOrdenProcesos', N'column', N'Orden'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleProduccionFichaProcesos','Orden', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionFichaProcesos] ADD
    [Orden] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionFichaProcesos', N'column', N'Orden'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','IdUsuarioCerro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [IdUsuarioCerro] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'IdUsuarioCerro'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'DetalleProduccionOrdenProcesos','IdProduccionParteQueCerroEsteProceso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleProduccionOrdenProcesos] ADD
    [IdProduccionParteQueCerroEsteProceso] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleProduccionOrdenProcesos', N'column', N'IdProduccionParteQueCerroEsteProceso'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionOrdenes','IdDetalleOrdenCompraImputado1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionOrdenes] ADD
    [IdDetalleOrdenCompraImputado1] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionOrdenes', N'column', N'IdDetalleOrdenCompraImputado1'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionOrdenes','IdDetalleOrdenCompraImputado2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionOrdenes] ADD
    [IdDetalleOrdenCompraImputado2] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionOrdenes', N'column', N'IdDetalleOrdenCompraImputado2'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionOrdenes','IdDetalleOrdenCompraImputado3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionOrdenes] ADD
    [IdDetalleOrdenCompraImputado3] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionOrdenes', N'column', N'IdDetalleOrdenCompraImputado3'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionOrdenes','IdDetalleOrdenCompraImputado4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionOrdenes] ADD
    [IdDetalleOrdenCompraImputado4] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionOrdenes', N'column', N'IdDetalleOrdenCompraImputado4'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionOrdenes','IdDetalleOrdenCompraImputado5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionOrdenes] ADD
    [IdDetalleOrdenCompraImputado5] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionOrdenes', N'column', N'IdDetalleOrdenCompraImputado5'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------
declare @esta1 int
exec _AlterTable 'ProduccionPartes','IdDetalleProduccionOrdenImputado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [IdDetalleProduccionOrdenImputado] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'IdDetalleProduccionOrdenImputado'
end
GO
--------------------------------------------------------------
--PRODUCCION
--------------------------------------------------------------

declare @esta1 int
exec _AlterTable 'ProduccionPartes','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ProduccionPartes] ADD
    [IdColor] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ProduccionPartes', N'column', N'IdColor'
end
GO
--------------------------------------------------------------
--------------------------------------------------------------
------------------<28-09-11>---------------------------------------

declare @esta1 int
exec _AlterTable 'ImpuestosDirectos','ParaInscriptosEnRegistroFiscalOperadoresGranos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ImpuestosDirectos] ADD
    [ParaInscriptosEnRegistroFiscalOperadoresGranos] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ImpuestosDirectos', N'column', N'ParaInscriptosEnRegistroFiscalOperadoresGranos'
end
GO

declare @esta1 int
exec _AlterTable 'Empresa','TipoActividadComercializacionGranos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empresa] ADD
    [TipoActividadComercializacionGranos] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Empresa', N'column', N'TipoActividadComercializacionGranos'
end
GO

declare @esta1 int
exec _AlterTable 'ImpuestosDirectos','CodigoRegimen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ImpuestosDirectos] ADD
    [CodigoRegimen] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ImpuestosDirectos', N'column', N'CodigoRegimen'
end
GO

------------------<26-10-11>---------------------------------------
declare @esta1 int
exec _AlterTable 'RubrosContables','NoTomarEnCuboPresupuestoFinanciero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[RubrosContables] ADD
    [NoTomarEnCuboPresupuestoFinanciero] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'RubrosContables', N'column', N'NoTomarEnCuboPresupuestoFinanciero'
end
GO
------------------<27-10-11>---------------------------------------
declare @esta1 int
exec _AlterTable 'Fletes','IdOrigenTransmision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Fletes] ADD
    [IdOrigenTransmision] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Fletes', N'column', N'IdOrigenTransmision'
end
GO
declare @esta1 int
exec _AlterTable 'Choferes','CUIL', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Choferes] ADD
    [CUIL] [Varchar] (13) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Choferes', N'column', N'CUIL'
end
GO
declare @esta1 int
exec _AlterTable 'Empleados','PuntoVentaAsociado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [PuntoVentaAsociado] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Empleados', N'column', N'PuntoVentaAsociado'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','ExpresionRegularNoAgruparFacturasConEstosVendedores', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [ExpresionRegularNoAgruparFacturasConEstosVendedores] [Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'ExpresionRegularNoAgruparFacturasConEstosVendedores'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','ExigeDatosCompletosEnCartaDePorteQueLoUse', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [ExigeDatosCompletosEnCartaDePorteQueLoUse] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'ExigeDatosCompletosEnCartaDePorteQueLoUse'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','DireccionDeCorreos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [DireccionDeCorreos] [Varchar] (50) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'DireccionDeCorreos'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','IdLocalidadDeCorreos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [IdLocalidadDeCorreos] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdLocalidadDeCorreos'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','IdProvinciaDeCorreos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [IdProvinciaDeCorreos] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdProvinciaDeCorreos'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','CodigoPostalDeCorreos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [CodigoPostalDeCorreos] [Varchar] (30) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'CodigoPostalDeCorreos'
end
GO
declare @esta1 int
exec _AlterTable 'Clientes','ObservacionesDeCorreos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Clientes] ADD
    [ObservacionesDeCorreos] [Varchar] (150) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Clientes', N'column', N'ObservacionesDeCorreos'
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','IdDestinoDeCartaDePorte', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [IdDestinoDeCartaDePorte] [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'IdDestinoDeCartaDePorte'
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioDescargaLocal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [PrecioDescargaLocal] [Numeric] (19,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioDescargaLocal'
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioDescargaExportacion ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [PrecioDescargaExportacion ] [Numeric] (19,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioDescargaExportacion '
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioCaladaLocal ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [PrecioCaladaLocal ] [Numeric] (19,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioCaladaLocal '
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioCaladaExportacion  ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [PrecioCaladaExportacion  ] [Numeric] (19,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioCaladaExportacion  '
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioRepetidoPeroConPrecision  ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ListasPreciosDetalle] ADD
    [PrecioRepetidoPeroConPrecision  ] [Numeric] (19,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioRepetidoPeroConPrecision  '
end
GO
declare @esta1 int
exec _AlterTable 'Localidades','CodigoONCAA  ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Localidades] ADD
    [CodigoONCAA  ] [Varchar] (20)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoONCAA  '
end
GO
----------------<28-10-11>--------------------------
  ALTER TABLE [dbo].[Clientes] 
Alter Column [RazonSocial] [Varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

GO
  ALTER TABLE [dbo].[Clientes] 
Alter Column [Direccion] [Varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

GO
declare @esta1 int
exec _AlterTable 'LMateriales','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[LMateriales] ADD
    [ArchivoAdjunto1] [Varchar] (200)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'LMateriales', N'column', N'ArchivoAdjunto1'
end
GO
declare @esta1 int
exec _AlterTable 'Recepciones','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [ArchivoAdjunto1] [Varchar] (200)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Recepciones', N'column', N'ArchivoAdjunto1'
end
GO
declare @esta1 int
exec _AlterTable 'Pedidos','IdLugarEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Pedidos] ADD
    [IdLugarEntrega] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdLugarEntrega'
end
GO
declare @esta1 int
exec _AlterTable 'Empleados','IdLugarEntregaAsignado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Empleados] ADD
    [IdLugarEntregaAsignado] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'Empleados', N'column', N'IdLugarEntregaAsignado'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [SubItem4] [Varchar] (10) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem4'
end
GO
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','SubItem5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodos] ADD
    [SubItem5] [Varchar] (10) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'SubItem5'
end
GO
----------------<02-11-11>---------------------------------------------
  declare @esta1 int
exec _AlterTable 'IBCondiciones','Alícuota', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    Alícuota [Numeric] (8,3) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'Alícuota'
end
GO
  ALTER TABLE [dbo].[IBCondiciones] 
    Alter Column [AlicuotaPercepcion] [Numeric] (8,3) NULL

GO

  ALTER TABLE [dbo].[IBCondiciones]
    Alter Column [AlicuotaPercepcionConvenio] [Numeric] (8,3) NULL

GO
-------------------------------<14-11-11>--------------------
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    [IdColor] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 02/01/07', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdColor'
end
GO
 ALTER TABLE [dbo].[Facturas]
    Alter Column [IdVendedor] [int] NULL

GO
 ALTER TABLE [dbo].[NotasCredito]
    Alter Column [IdVendedor] [int] NULL

GO
 ALTER TABLE [dbo].[NotasDebito]
    Alter Column [IdVendedor] [int] NULL

GO
-------------------------------<30-11-11>--------------------
declare @esta1 int
exec _AlterTable 'Comparativas','ImporteComparativaCalculado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [ImporteComparativaCalculado] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/11/11', N'user', N'dbo', N'table', N'Comparativas', N'column', N'ImporteComparativaCalculado'
end
GO

-------------------------------<26-12-11>--------------------
declare @esta1 int
exec _AlterTable 'Articulos','IdCuentaComprasActivo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [IdCuentaComprasActivo] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/11/11', N'user', N'dbo', N'table', N'Articulos', N'column', N'IdCuentaComprasActivo'
end
GO

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdPoliza', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdPoliza] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/11/11', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdPoliza'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoImpuestos','IdDetalleImpuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoImpuestos] ADD
    [IdDetalleImpuesto] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/11/11', N'user', N'dbo', N'table', N'DetalleOrdenesPagoImpuestos', N'column', N'IdDetalleImpuesto'
end
GO



-------------------------------<27-12-11>--------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdPoliza', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdPoliza] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdPoliza'
end
GO

-------------------------------<29-12-11>--------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesPagoImpuestos','IdDetalleImpuesto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesPagoImpuestos] ADD
    [IdDetalleImpuesto] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'DetalleOrdenesPagoImpuestos', N'column', N'IdDetalleImpuesto'
end
GO

-------------------------------<10-01-12>--------------------
declare @esta1 int
exec _AlterTable 'OrdenesCompra','Estado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [Estado] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'Estado'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','IdUsuarioCambioEstado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [IdUsuarioCambioEstado] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'IdUsuarioCambioEstado'
end
GO

declare @esta1 int
exec _AlterTable 'OrdenesCompra','FechaCambioEstado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesCompra] ADD
    [FechaCambioEstado] [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'OrdenesCompra', N'column', N'FechaCambioEstado'
end
GO

-------------------------------<12-01-12>--------------------
declare @esta1 int
exec _AlterTable 'NotasCredito','LiberarCartasDePorte', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [LiberarCartasDePorte] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'LiberarCartasDePorte'
end
GO
-------------------------------<18-01-12>--------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdDepositoIntermedio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [IdDepositoIntermedio] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/12/11', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdDepositoIntermedio'
end
GO

-------------------------------<27-01-12>--------------------
declare @esta1 int
exec _AlterTable 'Articulos','AuxiliarNumerico1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [AuxiliarNumerico1] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'AuxiliarNumerico1'
end
GO
declare @esta1 int
exec _AlterTable 'Articulos','AuxiliarNumerico2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [AuxiliarNumerico2] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'AuxiliarNumerico2'
end
GO

declare @esta1 int
exec _AlterTable 'Articulos','AuxiliarNumerico3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [AuxiliarNumerico3] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'AuxiliarNumerico3'
end
GO

declare @esta1 int
exec _AlterTable 'Articulos','AuxiliarNumerico4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [AuxiliarNumerico4] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'AuxiliarNumerico4'
end
GO
declare @esta1 int
exec _AlterTable 'Articulos','AuxiliarNumerico5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Articulos] ADD
    [AuxiliarNumerico5] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'AuxiliarNumerico5'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdRecepcion', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] 
			Drop Column [IdRecepcion]
end
GO
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdSalidaMateriales', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] 
			Drop Column [IdSalidaMateriales]
end
GO
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdGastoFlete', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] 
			Drop Column [IdGastoFlete]
end
GO

declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdDetalleSalidaMateriales', @esta = @esta1 output
if @esta1 = 1
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] 
			Drop Column [IdDetalleSalidaMateriales]
end
GO

declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdTipoComprobante', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [IdTipoComprobante] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'IdTipoComprobante'
end
Go
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdComprobante', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [IdComprobante] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'IdComprobante'
end
Go
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','Importe', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [Importe] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'Importe'
end

Go
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdDetalleLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    [IdDetalleLiquidacionFlete] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdDetalleLiquidacionFlete'
end

Go
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdDetalleLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    [IdDetalleLiquidacionFlete] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdDetalleLiquidacionFlete'
end

Go
declare @esta1 int
exec _AlterTable 'GastosFletes','IdDetalleLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[GastosFletes] ADD
    [IdDetalleLiquidacionFlete] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'IdDetalleLiquidacionFlete'
end

Go

-------------------------------<27-01-12>--------------------
declare @esta1 int
exec _AlterTable 'Recepciones','NumeroPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Recepciones] ADD
    [NumeroPesada] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Recepciones', N'column', N'NumeroPesada'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SalidasMateriales] ADD
    [NumeroPesada] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroPesada'
end
GO
-------------------------------<23-02-12>--------------------
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','Estado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [Estado] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'Estado'
end
GO
declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','IdUsuarioCambioEstado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [IdUsuarioCambioEstado] [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'IdUsuarioCambioEstado'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleOrdenesCompra','FechaCambioEstado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleOrdenesCompra] ADD
    [FechaCambioEstado] [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleOrdenesCompra', N'column', N'FechaCambioEstado'
end
GO

-------------------------------<07-03-12>--------------------
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','IdTarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [IdTarifaFlete] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'Estado'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','ValorUnitarioTarifa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [ValorUnitarioTarifa] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'Estado'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','EquivalenciaAUnidadTarifa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleLiquidacionesFletes] ADD
    [EquivalenciaAUnidadTarifa] [Numeric] (18,6) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'EquivalenciaAUnidadTarifa'
end
GO

declare @esta1 int
exec _AlterTable 'Comparativas','Anulada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [Anulada] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Comparativas', N'column', N'Anulada'
end
GO

declare @esta1 int
exec _AlterTable 'Comparativas','FechaAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [FechaAnulacion] [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Comparativas', N'column', N'FechaAnulacion'
end
GO

declare @esta1 int
exec _AlterTable 'Comparativas','IdUsuarioAnulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [IdUsuarioAnulo] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Comparativas', N'column', N'IdUsuarioAnulo'
end
GO

declare @esta1 int
exec _AlterTable 'Comparativas','MotivoAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Comparativas] ADD
    [MotivoAnulacion] [Ntext] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Comparativas', N'column', N'MotivoAnulacion'
end
GO
	
-------------------------------<08-03-12>--------------------
declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','ObservacionesFirmante', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [ObservacionesFirmante] [NText] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'ObservacionesFirmante'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','IdFirmanteObservo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [IdFirmanteObservo] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'IdFirmanteObservo'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','FechaUltimaObservacionFirmante', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRequerimientos] ADD
    [FechaUltimaObservacionFirmante] [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'FechaUltimaObservacionFirmante'
end
GO

declare @esta1 int
exec _AlterTable 'Polizas','TipoFacturacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Polizas] ADD
    [TipoFacturacion] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Polizas', N'column', N'TipoFacturacion'
end
GO

declare @esta1 int
exec _AlterTable 'Polizas','Certificado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Polizas] ADD
    [Certificado] [Varchar] (30) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Polizas', N'column', N'Certificado'
end
GO


declare @esta1 int
exec _AlterTable 'DetallePolizas','IdObraActual', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetallePolizas] ADD
    [IdObraActual] [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetallePolizas', N'column', N'IdObraActual'
end
GO
 
declare @esta1 int
exec _AlterTable 'DetallePolizas','EnUsoPor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetallePolizas] ADD
    [EnUsoPor] [Varchar] (30) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'DetallePolizas', N'column', N'EnUsoPor'
end
GO 
 

------------- 09/03/2012

declare @esta1 int
exec _AlterTable 'Polizas','IdTipoPoliza', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Polizas] ADD
    [IdTipoPoliza] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/01/12', N'user', N'dbo', N'table', N'Polizas', N'column', N'IdTipoPoliza'
end
GO 

------------- 19/03/2012	
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','NumeroCuotaPoliza', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [NumeroCuotaPoliza] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/03/12', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'NumeroCuotaPoliza'
end
GO 


declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdOrdenPagoRetencionIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdOrdenPagoRetencionIva] [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/03/12', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdOrdenPagoRetencionIva'
end
GO 



declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ImporteRetencionIvaEnOrdenPago', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [ImporteRetencionIvaEnOrdenPago] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/03/12', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ImporteRetencionIvaEnOrdenPago'
end
GO 


declare @esta1 int
exec _AlterTable 'OrdenesPago','IdsComprobanteProveedorRetenidosIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [IdsComprobanteProveedorRetenidosIva] [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/03/12', N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'IdsComprobanteProveedorRetenidosIva'
end
GO 

declare @esta1 int
exec _AlterTable 'OrdenesPago','TotalesImportesRetenidosIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[OrdenesPago] ADD
    [TotalesImportesRetenidosIva] [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/03/12', N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'TotalesImportesRetenidosIva'
end
GO 


------------- 20/03/2012	

declare @esta1 int
exec _AlterTable 'Impuestos','EnUsoPor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Impuestos] ADD
    [EnUsoPor] [Varchar] (30) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/03/12', N'user', N'dbo', N'table', N'Impuestos', N'column', N'EnUsoPor'
end
GO 


------------- 26/03/2012	

declare @esta1 int
exec _AlterTable 'DetalleImpuestos','Intereses1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleImpuestos] ADD
    [Intereses1] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'DetalleImpuestos', N'column', N'Intereses1'
end
GO 

declare @esta1 int
exec _AlterTable 'DetalleImpuestos','Intereses2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleImpuestos] ADD
    [Intereses2] [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'DetalleImpuestos', N'column', N'Intereses2'
end
GO 

declare @esta1 int
exec _AlterTable 'Impuestos','Detalle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Impuestos] ADD
    [Detalle] [Varchar] (50) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'Impuestos', N'column', N'Detalle'
end
GO 


------------- 27/03/2012

declare @esta1 int
exec _AlterTable 'Impuestos','TipoPlan', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Impuestos] ADD
    [TipoPlan] [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'Impuestos', N'column', N'TipoPlan'
end
GO 

------------- 24/04/2012


declare @esta1 int
exec _AlterTable 'Paises','CodigoESRI', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Paises] ADD
    [CodigoESRI] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'Paises', N'column', N'CodigoESRI'
end
GO 

declare @esta1 int
exec _AlterTable 'Provincias','CodigoESRI', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Provincias] ADD
    [CodigoESRI] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'Provincias', N'column', N'CodigoESRI'
end
GO 

declare @esta1 int
exec _AlterTable 'Localidades','CodigoESRI', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Localidades] ADD
    [CodigoESRI] [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 26/03/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoESRI'
end
GO 

declare @esta1 int
exec _AlterTable 'Polizas','IdMoneda', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Polizas ADD
    IdMoneda [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Polizas', N'column', N'IdMoneda'
end
GO 

declare @esta1 int
exec _AlterTable 'DetalleFletes','Tara', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFletes ADD
    Tara [Decimal] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleFletes', N'column', N'Tara'
end
GO 

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdUsuarioDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    IdUsuarioDioPorCumplidoLiquidacionFletes [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdUsuarioDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','FechaDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    FechaDioPorCumplidoLiquidacionFletes [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'FechaDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'DetalleRecepciones','ObservacionDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    ObservacionDioPorCumplidoLiquidacionFletes [ntext] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'ObservacionDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdUsuarioDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    IdUsuarioDioPorCumplidoLiquidacionFletes [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdUsuarioDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','FechaDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    FechaDioPorCumplidoLiquidacionFletes [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'FechaDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','ObservacionDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    ObservacionDioPorCumplidoLiquidacionFletes [ntext] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'ObservacionDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'GastosFletes','IdUsuarioDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    IdUsuarioDioPorCumplidoLiquidacionFletes [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'IdUsuarioDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'GastosFletes','FechaDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    FechaDioPorCumplidoLiquidacionFletes [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'FechaDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'GastosFletes','ObservacionDioPorCumplidoLiquidacionFletes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    ObservacionDioPorCumplidoLiquidacionFletes [ntext] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'ObservacionDioPorCumplidoLiquidacionFletes'
end
GO 
declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','IdCodigoIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    IdCodigoIva [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'IdCodigoIva'
end
GO 
declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','PorcentajeIva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    PorcentajeIva [numeric] (6,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'PorcentajeIva'
end
GO 
declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','SubtotalNoGravado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    SubtotalNoGravado [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'SubtotalNoGravado'
end
GO 
declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','SubtotalGravado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    SubtotalGravado [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'SubtotalGravado'
end
GO 

declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','Iva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    Iva [numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'Iva'
end
GO 

declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','Total', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    Total[numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'Total'

end
GO 
declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','Tipo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleLiquidacionesFletes ADD
    Tipo[Varchar] (12) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'Tipo'

end
GO 

declare @esta1 int
exec _AlterTable 'DetalleFletes','Patente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFletes ADD
    Patente[Varchar] (6) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleFletes', N'column', N'Patente'

end
GO 

declare @esta1 int
exec _AlterTable 'DetalleFletes','IdOrigenTransmision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFletes ADD
    IdOrigenTransmision [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'DetalleFletes', N'column', N'IdOrigenTransmision'

end
GO 

--------------------------<26/06/2012>
declare @esta1 int
exec _AlterTable 'GastosFletes','Gravado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    Gravado[Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'Gravado'

end
GO 


declare @esta1 int
exec _AlterTable 'GastosFletes','Iva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    Iva[numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'Iva'

end
GO 

declare @esta1 int
exec _AlterTable 'GastosFletes','Total', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    Total[numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'Total'

end
GO 
declare @esta1 int
exec _AlterTable 'Proveedores','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ArchivoAdjunto1[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ArchivoAdjunto1'

end
GO 
declare @esta1 int
exec _AlterTable 'Proveedores','ArchivoAdjunto2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ArchivoAdjunto2[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ArchivoAdjunto2'

end
GO 
declare @esta1 int
exec _AlterTable 'Proveedores','ArchivoAdjunto3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ArchivoAdjunto3[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ArchivoAdjunto3'

end
GO 
declare @esta1 int
exec _AlterTable 'Proveedores','ArchivoAdjunto4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ArchivoAdjunto4[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ArchivoAdjunto4'

end
GO 

----------------------<<13-08-2012>>---------------------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','Progresiva1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    Progresiva1[Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Progresiva1'

end
GO 
declare @esta1 int
exec _AlterTable 'SalidasMateriales','Progresiva2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    Progresiva2[Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'Progresiva2'

end
GO 
declare @esta1 int
exec _AlterTable 'SalidasMateriales','FechaPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    FechaPesada[Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'FechaPesada'

end
GO 
declare @esta1 int
exec _AlterTable 'SalidasMateriales','ObservacionesPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    ObservacionesPesada[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'ObservacionesPesada'

end
GO 

declare @esta1 int
exec _AlterTable 'Recepciones','Progresiva1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recepciones ADD
    Progresiva1[Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Recepciones', N'column', N'Progresiva1'

end
GO 
declare @esta1 int
exec _AlterTable 'Recepciones','Progresiva2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recepciones ADD
    Progresiva2[Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Recepciones', N'column', N'Progresiva2'

end
GO 
declare @esta1 int
exec _AlterTable 'Recepciones','FechaPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recepciones ADD
    FechaPesada[Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Recepciones', N'column', N'FechaPesada'

end
GO 
declare @esta1 int
exec _AlterTable 'Recepciones','ObservacionesPesada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recepciones ADD
    ObservacionesPesada[Varchar] (200) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Recepciones', N'column', N'ObservacionesPesada'

end
GO 
declare @esta1 int
exec _AlterTable 'Clientes','IdTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    IdTarjetaCredito [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdTarjetaCredito'

end
GO 
declare @esta1 int
exec _AlterTable 'Clientes','Tarjeta_NumeroTarjeta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    Tarjeta_NumeroTarjeta[Varchar] (16) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'Tarjeta_NumeroTarjeta'

end
GO 
declare @esta1 int
exec _AlterTable 'TarjetasCredito','TipoTarjeta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    TipoTarjeta[Varchar] (1) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'TipoTarjeta'

end
GO 
declare @esta1 int
exec _AlterTable 'TarjetasCredito','DiseñoRegistro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    DiseñoRegistro [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'DiseñoRegistro'

end
GO 
declare @esta1 int
exec _AlterTable 'TarjetasCredito','NumeroEstablecimiento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    NumeroEstablecimiento [Varchar] (10) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'NumeroEstablecimiento'

end
GO 
declare @esta1 int
exec _AlterTable 'TarjetasCredito','CodigoServicio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    CodigoServicio [Varchar] (5) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'CodigoServicio'

end
GO 
declare @esta1 int
exec _AlterTable 'TarjetasCredito','NumeroServicio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    NumeroServicio [Varchar] (10) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'NumeroServicio'

end
GO 

------------------------<12-09-12>-------------------------
declare @esta1 int
exec _AlterTable 'Facturas','CuentaVentaLetra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    CuentaVentaLetra [Varchar] (1) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'CuentaVentaLetra'

end
GO 
declare @esta1 int
exec _AlterTable 'Facturas','CuentaVentaPuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    CuentaVentaPuntoVenta [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'CuentaVentaPuntoVenta'

end
GO 
declare @esta1 int
exec _AlterTable 'Facturas','CuentaVentaNumero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    CuentaVentaNumero [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'CuentaVentaNumero'

end
GO 
declare @esta1 int
exec _AlterTable 'NotasCredito','CuentaVentaLetra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    CuentaVentaLetra [Varchar] (1) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CuentaVentaLetra'

end
GO 
declare @esta1 int
exec _AlterTable 'NotasCredito','CuentaVentaPuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    CuentaVentaPuntoVenta [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CuentaVentaPuntoVenta'

end
GO 
declare @esta1 int
exec _AlterTable 'NotasCredito','CuentaVentaNumero', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    CuentaVentaNumero [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 15/05/12', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CuentaVentaNumero'

end
GO 
--------------------<< CAMPOS WILLIAMS >>----------------------
declare @esta1 int
exec _AlterTable 'CartasDePorte','IdTipoMovimiento', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    IdTipoMovimiento [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'IdTipoMovimiento'

end
GO 

declare @esta1 int
exec _AlterTable 'CartasDePorte','IdClienteAFacturarle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    IdClienteAFacturarle [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'IdClienteAFacturarle'

end
GO 

declare @esta1 int
exec _AlterTable 'CartasDePorte','SubnumeroDeFacturacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    SubnumeroDeFacturacion [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'SubnumeroDeFacturacion'

end
GO 

declare @esta1 int
exec _AlterTable 'CartasDePorte','AgregaItemDeGastosAdministrativos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    AgregaItemDeGastosAdministrativos [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'AgregaItemDeGastosAdministrativos'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioExportacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    PrecioExportacion [money] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioExportacion'

end
GO 

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioEmbarque', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    PrecioEmbarque [money] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioEmbarque'

end
GO 

declare @esta1 int
exec _AlterTable 'Localidades','CodigoWilliams', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    CodigoWilliams [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoWilliams'

end
GO

declare @esta1 int
exec _AlterTable 'Localidades','CodigoLosGrobo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    CodigoLosGrobo [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoLosGrobo'

end
GO

declare @esta1 int
exec _AlterTable 'CuentasBancarias','Activa', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CuentasBancarias ADD
    Activa [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CuentasBancarias', N'column', N'Activa'

end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','ConfirmadoPorWeb  ', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    ConfirmadoPorWeb   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Pedidos', N'column', N'ConfirmadoPorWeb  '

end
GO


------------------------<19-11-12>-------------------------
declare @esta1 int
exec _AlterTable 'Cuentas','ImputarAPresupuestoDeObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Cuentas ADD
    ImputarAPresupuestoDeObra   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Cuentas', N'column', N'ImputarAPresupuestoDeObra  '

end
GO

------------------------<19-12-12>-------------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','FechasLiberacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    FechasLiberacion   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'FechasLiberacion'

end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','Presupuestos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    Presupuestos   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Presupuestos'

end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','Comparativas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    Comparativas   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Comparativas'

end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','Pedidos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    Pedidos   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Pedidos'

end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','Recepciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    Recepciones   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Recepciones'

end
GO

declare @esta1 int
exec _AlterTable 'Requerimientos','SalidasMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    SalidasMateriales   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'SalidasMateriales'

end
GO
------------------------<05-02-13>-------------------------

declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroRemitoTransporte1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    NumeroRemitoTransporte1 [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroRemitoTransporte1'

end
GO 

declare @esta1 int
exec _AlterTable 'SalidasMateriales','NumeroRemitoTransporte2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    NumeroRemitoTransporte2 [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'NumeroRemitoTransporte2'

end
GO 

declare @esta1 int
exec _AlterTable 'Marcas','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Marcas ADD
    Codigo [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Marcas', N'column', N'Codigo'

end
GO 

declare @esta1 int
exec _AlterTable 'Articulos','IdCurvaTalle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Articulos ADD
    IdCurvaTalle [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'IdCurvaTalle'

end
GO 

declare @esta1 int
exec _AlterTable 'Articulos','Curva', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Articulos ADD
    Curva   [Varchar] (50) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'Curva'

end
GO

--------------------<< 04-02-13 >>----------------------
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','IdCliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    IdCliente   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'IdCliente'

end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio2   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio2'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio3   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio3'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','FechaVigenciaHasta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    FechaVigenciaHasta   [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'FechaVigenciaHasta'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPrecios','DescripcionPrecio1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPrecios ADD
    DescripcionPrecio1   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPrecios', N'column', N'DescripcionPrecio1'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPrecios','DescripcionPrecio2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPrecios ADD
    DescripcionPrecio2   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPrecios', N'column', N'DescripcionPrecio2'

end
GO


declare @esta1 int
exec _AlterTable 'ListasPrecios','DescripcionPrecio3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPrecios ADD
    DescripcionPrecio3   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPrecios', N'column', N'DescripcionPrecio3'

end
GO

declare @esta1 int
exec _AlterTable 'Articulos','GenerarConsumosAutomaticamente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Articulos ADD
    GenerarConsumosAutomaticamente   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'GenerarConsumosAutomaticamente'

end
GO

declare @esta1 int
exec _AlterTable 'CurvasTalles','CurvaCodigos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CurvasTalles ADD
    CurvaCodigos   [Varchar] (50) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CurvasTalles', N'column', N'CurvaCodigos'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleFacturas','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFacturas ADD
    Talle   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleFacturas', N'column', N'Talle'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleFacturas','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFacturas ADD
    IdColor   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleFacturas', N'column', N'IdColor'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    Talle   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'Talle'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    Talle   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'Talle'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    IdColor   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'IdColor'

end
GO

declare @esta1 int
exec _AlterTable 'Stock','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Stock ADD
    Talle   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Stock', N'column', N'Talle'

end
GO

declare @esta1 int
exec _AlterTable 'Colores','Codigo2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Colores ADD
    Codigo2   [Varchar] (5) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Colores', N'column', N'Codigo2'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleFacturas','IdDetallePresupuestoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFacturas ADD
    IdDetallePresupuestoVenta   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleFacturas', N'column', N'IdDetallePresupuestoVenta'

end
GO


declare @esta1 int
exec _AlterTable 'Articulos','TalleCambioPrecio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Articulos ADD
    TalleCambioPrecio   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'TalleCambioPrecio'

end
GO


declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio4   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio4'

end
GO


declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio5   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio5'

end
GO


declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio6', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio6   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio6'

end
GO

----------------------<<15-02-13>>----------------------------
declare @esta1 int
exec _AlterTable 'PresupuestosVentas','TipoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestosVentas ADD
    TipoVenta   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'TipoVenta'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','IncluyeTarifaEnFactura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    IncluyeTarifaEnFactura   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'IncluyeTarifaEnFactura'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoTitular', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoTitular   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoTitular'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoIntermediario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoIntermediario   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoIntermediario'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoRemcomercial', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoRemcomercial   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoRemcomercial'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoCorredor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoCorredor   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoCorredor'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoDestinatario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoDestinatario   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoDestinatario'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoDestinatarioExportador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoDestinatarioExportador   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoDestinatarioExportador'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeDerivaSuFacturaAlCorredorDeLaCarta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeDerivaSuFacturaAlCorredorDeLaCarta   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeDerivaSuFacturaAlCorredorDeLaCarta'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','HabilitadoParaCartaPorte', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    HabilitadoParaCartaPorte   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'HabilitadoParaCartaPorte'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','SeLeFacturaCartaPorteComoClienteAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    SeLeFacturaCartaPorteComoClienteAuxiliar   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'SeLeFacturaCartaPorteComoClienteAuxiliar'

end
GO


declare @esta1 int
exec _AlterTable 'Clientes','EsAcondicionadoraDeCartaPorte', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    EsAcondicionadoraDeCartaPorte   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'EsAcondicionadoraDeCartaPorte'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','Contactos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    Contactos   [Varchar] (150) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'Contactos'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','TelefonosFijosOficina', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    TelefonosFijosOficina   [Varchar] (150) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'TelefonosFijosOficina'

end
GO


declare @esta1 int
exec _AlterTable 'Clientes','TelefonosCelulares', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    TelefonosCelulares   [Varchar] (150) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'TelefonosCelulares'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','CorreosElectronicos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    CorreosElectronicos   [Varchar] (150) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'CorreosElectronicos'

end
GO

declare @esta1 int
exec _AlterTable 'Localidades','CodigoWilliams', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    CodigoWilliams   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoWilliams'

end
GO


declare @esta1 int
exec _AlterTable 'Localidades','CodigoLosGrobo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    CodigoLosGrobo   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoLosGrobo'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioExportacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    PrecioExportacion   [Money] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioExportacion'

end
GO


declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioEmbarque', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    PrecioEmbarque   [Money] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioEmbarque'

end
GO


declare @esta1 int
exec _AlterTable 'Pedidos','ConfirmadoPorWeb', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    ConfirmadoPorWeb  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Pedidos', N'column', N'ConfirmadoPorWeb'

end
GO


declare @esta1 int
exec _AlterTable 'Empleados','EsConductor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    EsConductor  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Empleados', N'column', N'EsConductor'

end
GO


declare @esta1 int
exec _AlterTable 'Empleados','EsConductor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    EsConductor  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Empleados', N'column', N'EsConductor'

end
GO

declare @esta1 int
exec _AlterTable 'Empleados','FechaVencimientoRegistro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    FechaVencimientoRegistro  [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Empleados', N'column', N'FechaVencimientoRegistro'

end
GO


declare @esta1 int
exec _AlterTable 'TiposCompra','Modalidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposCompra ADD
    Modalidad  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'TiposCompra', N'column', N'Modalidad'

end
GO
--------------------<< 27-02-12 >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','IdDeposito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdDeposito   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdDeposito'

end
GO

--------------------<< 28-02-12 >>----------------------
declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion2   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion2'

end
GO

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion3   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion3'

end
GO

declare @esta1 int
exec _AlterTable 'Devoluciones','PercepcionIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PercepcionIVA   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PercepcionIVA'

end
GO

declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajePercepcionIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajePercepcionIVA   [Numeric] (6,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajePercepcionIVA'

end
GO

declare @esta1 int
exec _AlterTable 'Devoluciones','IdDeposito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdDeposito   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdDeposito'

end
GO
--------------------<< 01-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleRemitos','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRemitos ADD
    Talle  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleRemitos', N'column', N'Talle'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleRemitos','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRemitos ADD
    IdColor   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleRemitos', N'column', N'IdColor'

end
GO
--------------------<< 04-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'Articulos','TalleCambioPrecio2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Articulos ADD
    TalleCambioPrecio2  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Articulos', N'column', N'TalleCambioPrecio2'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio7', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio7   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio7'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio8', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio8   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio8'

end
GO

declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','Precio9', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    Precio9   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'Precio9'

end
GO
--------------------<< 05-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'DetallePresupuestosVentas','Estado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetallePresupuestosVentas ADD
    Estado  [Varchar] (1) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetallePresupuestosVentas', N'column', N'Estado'

end
GO
--------------------<< 06-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    Talle  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'Talle'

end
GO
--------------------<< 07-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    Talle  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'Talle'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    IdColor   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdColor'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAjustesStock ADD
    Talle  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'Talle'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAjustesStock ADD
    IdColor   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'IdColor'

end
GO
--------------------<< 08-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','Talle', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleOtrosIngresosAlmacen ADD
    Talle  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'Talle'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleOtrosIngresosAlmacen','IdColor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleOtrosIngresosAlmacen ADD
    IdColor   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleOtrosIngresosAlmacen', N'column', N'IdColor'

end
GO
--------------------<< 11-03-12 >>----------------------

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosPxQxPresupuesto','Certificado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodosPxQxPresupuesto ADD
    Certificado   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestoObrasNodosPxQxPresupuesto', N'column', N'Certificado'

end
GO

--------------------<< 22-03-12 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestosVentas','TipoOperacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestosVentas ADD
    TipoOperacion  [Varchar] (1) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'TipoOperacion'

end
GO

declare @esta1 int
exec _AlterTable 'PresupuestosVentas','ImporteTotal', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestosVentas ADD
    ImporteTotal   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'ImporteTotal'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','IdDetallePresupuestoVenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    IdDetallePresupuestoVenta   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'IdDetallePresupuestoVenta'

end
GO

--------------------<< 25-03-12 >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','IdTransportista', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    IdTransportista   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdTransportista'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','IdRegion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    IdRegion   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdRegion'

end
GO

declare @esta1 int
exec _AlterTable 'Clientes','IdCategoriaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    IdCategoriaCredito   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'IdCategoriaCredito'

end
GO

declare @esta1 int
exec _AlterTable 'Transportistas','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Transportistas ADD
    Codigo   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Transportistas', N'column', N'Codigo'

end
GO

declare @esta1 int
exec _AlterTable 'Vendedores','TodasLasZonas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Vendedores ADD
    TodasLasZonas  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Vendedores', N'column', N'TodasLasZonas'

end
GO

declare @esta1 int
exec _AlterTable 'Vendedores','EmiteComision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Vendedores ADD
    EmiteComision  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Vendedores', N'column', N'EmiteComision'

end
GO

--------------------<< 22-04-12 >>----------------------
declare @esta1 int
exec _AlterTable 'Condiciones Compra','PorcentajeBonificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Condiciones Compra] ADD
    PorcentajeBonificacion   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Condiciones Compra', N'column', N'PorcentajeBonificacion'

end
GO

declare @esta1 int
exec _AlterTable 'Condiciones Compra','ContraEntregaDeValores', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Condiciones Compra] ADD
    ContraEntregaDeValores  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Condiciones Compra', N'column', N'ContraEntregaDeValores'

end
GO
--------------------<< 25-04-12 >>----------------------
declare @esta1 int
exec _AlterTable 'PuntosVenta','AgentePercepcionIIBB', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PuntosVenta ADD
    AgentePercepcionIIBB  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'AgentePercepcionIIBB'

end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','CancelacionInmediataDeDeuda', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    CancelacionInmediataDeDeuda  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'CancelacionInmediataDeDeuda'

end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','DebitoAutomaticoPorDefecto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    DebitoAutomaticoPorDefecto  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'DebitoAutomaticoPorDefecto'

end
GO

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','DebitoAutomatico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    DebitoAutomatico  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'DebitoAutomatico'

end
GO

--------------------<< 30-04-12 >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','RecibidosEnDestino', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    RecibidosEnDestino  [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'RecibidosEnDestino'

end
GO

declare @esta1 int
exec _AlterTable 'SalidasMateriales','RecibidosEnDestinoFecha', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    RecibidosEnDestinoFecha  [Datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'RecibidosEnDestinoFecha'

end
GO

declare @esta1 int
exec _AlterTable 'SalidasMateriales','RecibidosEnDestinoIdUsuario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    RecibidosEnDestinoIdUsuario   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'RecibidosEnDestinoIdUsuario'

end
GO
--------------------<< 07-05-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Valores','NumeroTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    NumeroTarjetaCredito   [Varchar] (20) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'NumeroTarjetaCredito'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','NumeroAutorizacionTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    NumeroAutorizacionTarjetaCredito [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'NumeroAutorizacionTarjetaCredito'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','CantidadCuotas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    CantidadCuotas [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'CantidadCuotas'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','FechaExpiracionTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    FechaExpiracionTarjetaCredito [Varchar] (5)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'FechaExpiracionTarjetaCredito'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleRecibosValores','FechaExpiracionTarjetaCredito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecibosValores ADD
    FechaExpiracionTarjetaCredito [Varchar] (5)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleRecibosValores', N'column', N'FechaExpiracionTarjetaCredito'

end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','IdTipoCompraRM', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    IdTipoCompraRM [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdTipoCompraRM'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','IdFactura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    IdFactura [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'IdFactura'

end
GO


declare @esta1 int
exec _AlterTable 'Facturas','Cliente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    Cliente [Varchar] (50)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'Cliente'

end
GO


declare @esta1 int
exec _AlterTable 'Valores','IdDetallePresentacionTarjeta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    IdDetallePresentacionTarjeta [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'IdDetallePresentacionTarjeta'

end
GO
--------------------<< 16-05-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','RegistrarMovimientosEnCuentaCorriente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    RegistrarMovimientosEnCuentaCorriente [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'RegistrarMovimientosEnCuentaCorriente'

end

GO
declare @esta1 int
exec _AlterTable 'Proveedores','RegistrarMovimientosEnCuentaCorriente', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    RegistrarMovimientosEnCuentaCorriente [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'RegistrarMovimientosEnCuentaCorriente'

end
GO

declare @esta1 int
exec _AlterTable 'Facturas','OrigenRegistro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    OrigenRegistro [Varchar] (12)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'OrigenRegistro'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleFacturas','OrigenRegistro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleFacturas ADD
    OrigenRegistro [Varchar] (12)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleFacturas', N'column', N'OrigenRegistro'

end
GO

declare @esta1 int
exec _AlterTable 'TarjetasCredito','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarjetasCredito ADD
    Codigo [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'TarjetasCredito', N'column', N'Codigo'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','IdOrigen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    IdOrigen [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'IdOrigen'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','OrigenRegistro', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    OrigenRegistro [Varchar] (12)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'OrigenRegistro'

end
GO

declare @esta1 int
exec _AlterTable 'Valores','IdReciboAsignado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    IdReciboAsignado [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Valores', N'column', N'IdReciboAsignado'

end
GO
--------------------<< 29-05-13 >>----------------------
declare @esta1 int
exec _AlterTable 'Recibos','IdFacturaDirecta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recibos ADD
    IdFacturaDirecta [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Recibos', N'column', N'IdFacturaDirecta'

end
GO
--------------------<< 31-05-13 >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','FechaVencimientoParaEgresosProyectados', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    FechaVencimientoParaEgresosProyectados [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaVencimientoParaEgresosProyectados'

end
GO

--------------------<< 07-06-13 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestosVentas','PorcentajeBonificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestosVentas] ADD
    PorcentajeBonificacion   [Numeric] (6,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'PorcentajeBonificacion'

end
GO

--------------------<< 11-06-13 >>----------------------
declare @esta1 int
exec _AlterTable 'PartesProduccion','IdDetalleSalidaMateriales', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PartesProduccion] ADD
    IdDetalleSalidaMateriales   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PartesProduccion', N'column', N'IdDetalleSalidaMateriales'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdPresupuestoObrasNodoFleteLarga', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    IdPresupuestoObrasNodoFleteLarga   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdPresupuestoObrasNodoFleteLarga'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdPresupuestoObrasNodoFleteInterno', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    IdPresupuestoObrasNodoFleteInterno   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdPresupuestoObrasNodoFleteInterno'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','CostoFleteLarga', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    CostoFleteLarga   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'CostoFleteLarga'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','CostoFleteInterno', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSalidasMateriales] ADD
    CostoFleteInterno   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'CostoFleteInterno'

end
GO
--------------------<< 26-06-13 >>----------------------

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodosDatos','PrecioVentaUnitario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[PresupuestoObrasNodosDatos] ADD
    PrecioVentaUnitario   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestoObrasNodosDatos', N'column', N'PrecioVentaUnitario'

end
GO

declare @esta1 int
exec _AlterTable 'Obras','IdObraRelacionada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    IdObraRelacionada   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Obras', N'column', N'IdObraRelacionada'

end
GO
declare @esta1 int
exec _AlterTable 'DetalleAutorizacionesFirmantes','ImporteDesde', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizacionesFirmantes] ADD
    ImporteDesde   [Numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAutorizacionesFirmantes', N'column', N'ImporteDesde'

end
GO
declare @esta1 int
exec _AlterTable 'DetalleAutorizacionesFirmantes','ImporteHasta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizacionesFirmantes] ADD
    ImporteHasta   [Numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAutorizacionesFirmantes', N'column', N'ImporteHasta'

end
GO

declare @esta1 int
exec _AlterTable 'CertificacionesObrasDatos','IdAprobo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObrasDatos] ADD
    IdAprobo   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CertificacionesObrasDatos', N'column', N'IdAprobo'

end
GO

declare @esta1 int
exec _AlterTable 'CertificacionesObrasDatos','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CertificacionesObrasDatos] ADD
    CircuitoFirmasCompleto   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CertificacionesObrasDatos', N'column', N'CircuitoFirmasCompleto'

end
GO

declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','IdAprobo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    IdAprobo   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'IdAprobo'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleSubcontratosDatos','CircuitoFirmasCompleto', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleSubcontratosDatos] ADD
    CircuitoFirmasCompleto   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSubcontratosDatos', N'column', N'CircuitoFirmasCompleto'

end
GO

declare @esta1 int
exec _AlterTable 'SubcontratosDatos','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[SubcontratosDatos] ADD
    IdObra   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SubcontratosDatos', N'column', N'IdObra'

end
GO


declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','IdsTipoCompra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleAutorizaciones] ADD
    IdsTipoCompra   [Varchar] (100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'IdsTipoCompra'

end
GO

--------------------<< 05-07-13 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdProduccionTerminado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleRecepciones] ADD
    IdProduccionTerminado   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdProduccionTerminado'

end
GO

--------------------<< 11-07-13 >>----------------------
declare @esta1 int
exec _AlterTable 'CuentasBancarias','DiseñoCheque', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[CuentasBancarias] ADD
    DiseñoCheque   [Varchar] (4000) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CuentasBancarias', N'column', N'DiseñoCheque'

end
GO
--------------------<< 11-07-13 >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','TotalBultos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    TotalBultos   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'TotalBultos'

end
Go

declare @esta1 int
exec _AlterTable 'Facturas','IdDetalleClienteLugarEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    IdDetalleClienteLugarEntrega   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdDetalleClienteLugarEntrega'

end
GO
declare @esta1 int
exec _AlterTable 'Facturas','CuitClienteExterno', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Facturas] ADD
    CuitClienteExterno   [Varchar] (13)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'CuitClienteExterno'
end
GO

declare @esta1 int
exec _AlterTable 'Proveedores','SUSSFechaInicioVigencia', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    SUSSFechaInicioVigencia   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'SUSSFechaInicioVigencia'
end
GO

declare @esta1 int
exec _AlterTable 'Vendedores','IdsVendedoresAsignados', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Vendedores ADD
    IdsVendedoresAsignados   [Varchar] (1000)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Vendedores', N'column', N'IdsVendedoresAsignados'
end
GO


declare @esta1 int
exec _AlterTable 'Conceptos','GeneraComision', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Conceptos ADD
    GeneraComision   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Conceptos', N'column', N'GeneraComision'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','ComisionDiferenciada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    ComisionDiferenciada   [Numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'ComisionDiferenciada'
end
GO

declare @esta1 int
exec _AlterTable 'Facturas','ComisionDiferenciada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    ComisionDiferenciada   [Numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Facturas', N'column', N'ComisionDiferenciada'
end
GO

declare @esta1 int
exec _AlterTable 'Clientes','EsEntregador', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    EsEntregador   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'EsEntregador'
end
GO

declare @esta1 int
exec _AlterTable 'RubrosContables','DistribuirGastosEnResumen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].RubrosContables ADD
    DistribuirGastosEnResumen   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'RubrosContables', N'column', N'DistribuirGastosEnResumen'
end
GO
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','FechaPrestacionServicio', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    FechaPrestacionServicio   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'FechaPrestacionServicio'
end
GO

declare @esta1 int
exec _AlterTable 'CartasDePorte','IdDetalleFactura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    IdDetalleFactura   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'IdDetalleFactura'
end
GO

declare @esta1 int
exec _AlterTable 'CartasPorteMovimientos','IdDetalleFactura', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasPorteMovimientos ADD
    IdDetalleFactura   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CartasPorteMovimientos', N'column', N'IdDetalleFactura'
end
GO

--------------------<< 05-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','FechaEnvioProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    FechaEnvioProveedor   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Pedidos', N'column', N'FechaEnvioProveedor'
end
GO

declare @esta1 int
exec _AlterTable 'Pedidos','IdUsuarioEnvioProveedor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    IdUsuarioEnvioProveedor   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdUsuarioEnvioProveedor'
end
GO

--------------------<< 10-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'CurvasTalles','MostrarCurvaEnInformes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CurvasTalles ADD
    MostrarCurvaEnInformes   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CurvasTalles', N'column', N'MostrarCurvaEnInformes'
end
GO

--------------------<< 12-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','IdUsuarioDioPorRecepcionado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    IdUsuarioDioPorRecepcionado   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'IdUsuarioDioPorRecepcionado'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','FechaDioPorRecepcionado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    FechaDioPorRecepcionado   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'FechaDioPorRecepcionado'
end
GO


declare @esta1 int
exec _AlterTable 'DetalleSalidasMateriales','ObservacionDioPorRecepcionado', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleSalidasMateriales ADD
    ObservacionDioPorRecepcionado   [ntext]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleSalidasMateriales', N'column', N'ObservacionDioPorRecepcionado'
end
GO
--------------------<< 19-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Devoluciones','IdUsuarioAnulacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdUsuarioAnulacion   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdUsuarioAnulacion'
end
GO
--------------------<< 23-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'RubrosContables','CodigoAgrupacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].RubrosContables ADD
    CodigoAgrupacion   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'RubrosContables', N'column', N'CodigoAgrupacion'
end
GO

--------------------<< 27-09-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Empleados','LimitarUbicacionesAsignadas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    LimitarUbicacionesAsignadas   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Empleados', N'column', N'LimitarUbicacionesAsignadas'
end
GO

--------------------<< 01-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'ListasPrecios','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPrecios ADD
    IdObra   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPrecios', N'column', N'IdObra'
end
GO

--------------------<< 08-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestosVentas','TotalBultos', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestosVentas ADD
    TotalBultos   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'TotalBultos'
end
GO

--------------------<< 09-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'PuntosVenta','CodigoAuxiliar', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PuntosVenta ADD
    CodigoAuxiliar   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'CodigoAuxiliar'
end
GO
declare @esta1 int
exec _AlterTable 'PuntosVenta','IdDeposito', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PuntosVenta ADD
    IdDeposito   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PuntosVenta', N'column', N'IdDeposito'
end
GO

--------------------<< 15-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','PrecioEmbarque2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    PrecioEmbarque2   [Money]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'PrecioEmbarque2'
end
GO
declare @esta1 int
exec _AlterTable 'ListasPreciosDetalle','MaximaCantidadParaPrecioEmbarque', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ListasPreciosDetalle ADD
    MaximaCantidadParaPrecioEmbarque   [Numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'ListasPreciosDetalle', N'column', N'MaximaCantidadParaPrecioEmbarque'
end
Go
declare @esta1 int
exec _AlterTable 'AjustesStock','TipoAjusteInventario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].AjustesStock ADD
    TipoAjusteInventario   [Varchar] (1)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'TipoAjusteInventario'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','CantidadInventariada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAjustesStock ADD
    CantidadInventariada   [Numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'CantidadInventariada'
end
GO

declare @esta1 int
exec _AlterTable 'GastosFletes','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    IdObra   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'IdObra'
end
Go
declare @esta1 int
exec _AlterTable 'GastosFletes','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].GastosFletes ADD
    IdPresupuestoObrasNodo   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'GastosFletes', N'column', N'IdPresupuestoObrasNodo'
end
Go
--------------------<<16-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdCalle1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    IdCalle1   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdCalle1'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdCalle2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    IdCalle2   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdCalle2'
end
GO
declare @esta1 int
exec _AlterTable 'SalidasMateriales','IdCalle3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].SalidasMateriales ADD
    IdCalle3   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'SalidasMateriales', N'column', N'IdCalle3'
end
GO
--------------------<<28-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdCuenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    IdCuenta   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdCuenta'
end
GO

--------------------<<29-10-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Recibos','NumeroCertificadoRetencionGanancias', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recibos ADD
    NumeroCertificadoRetencionGanancias   [Numeric] (18,0)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Recibos', N'column', N'NumeroCertificadoRetencionGanancias'
end
GO
declare @esta1 int
exec _AlterTable 'Recibos','NumeroCertificadoRetencionIVA', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recibos ADD
    NumeroCertificadoRetencionIVA   [Numeric] (18,0)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Recibos', N'column', N'NumeroCertificadoRetencionIVA'
end
GO
declare @esta1 int
exec _AlterTable 'Recibos','NumeroCertificadoSUSS', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Recibos ADD
    NumeroCertificadoSUSS   [Numeric] (18,0)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Recibos', N'column', N'NumeroCertificadoSUSS'
end
GO

--------------------<<18-11-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Localidades','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    Codigo [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/11/13', N'user', N'dbo', N'table', N'Localidades', N'column', N'Codigo'

end
GO 
declare @esta1 int
exec _AlterTable 'Provincias','Codigo2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Provincias ADD
    Codigo2 [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/11/13', N'user', N'dbo', N'table', N'Provincias', N'column', N'Codigo2'

end
GO 

--------------------<<21-11-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'EmpleadosAccesos','FechaUltimaModificacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].EmpleadosAccesos ADD
    FechaUltimaModificacion   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'EmpleadosAccesos', N'column', N'FechaUltimaModificacion'
end
GO

declare @esta1 int
exec _AlterTable 'EmpleadosAccesos','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].EmpleadosAccesos ADD
    IdUsuarioModifico [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/11/13', N'user', N'dbo', N'table', N'EmpleadosAccesos', N'column', N'IdUsuarioModifico'

end
GO 

--------------------<<26-11-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'EmpleadosAccesos','UsuarioNTUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].EmpleadosAccesos ADD
    UsuarioNTUsuarioModifico   [Varchar] (50)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'EmpleadosAccesos', N'column', N'UsuarioNTUsuarioModifico'
end
Go

--------------------<<26-11-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'Localidades','Partido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    Partido   [Varchar] (60)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Localidades', N'column', N'Partido'
end
Go

--------------------<<18-12-2013 >>----------------------
declare @esta1 int
exec _AlterTable 'RubrosContables','IdTipoRubroFinancieroGrupo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].RubrosContables ADD
    IdTipoRubroFinancieroGrupo   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'RubrosContables', N'column', N'IdTipoRubroFinancieroGrupo'
end
Go

--------------------<<10-02-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Previsiones','IdObra', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Previsiones ADD
    IdObra   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Previsiones', N'column', N'IdObra'
end
Go

--------------------<<11-02-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'IBCondiciones','CodigoArticuloInciso', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    CodigoArticuloInciso   [varchar] (5) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'CodigoArticuloInciso'
end
Go


--------------------<<13-02-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Previsiones','PostergarFechaCaducidad', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Previsiones ADD
    PostergarFechaCaducidad   [varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Previsiones', N'column', N'PostergarFechaCaducidad'
end
Go

--------------------<<18-02-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdUsuarioModificoCuenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleComprobantesProveedores ADD
    IdUsuarioModificoCuenta   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdUsuarioModificoCuenta'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','FechaModificacionCuenta', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleComprobantesProveedores ADD
    FechaModificacionCuenta   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'FechaModificacionCuenta'
end
GO
--------------------<<14-03-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Empleados','PermitirAccesoATodasLasObras', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    PermitirAccesoATodasLasObras   [varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Empleados', N'column', N'PermitirAccesoATodasLasObras'
end
Go
--------------------<<17-03-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'CuentasBancariasSaldos','SaldoAnteriorPrimerDiaMes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CuentasBancariasSaldos ADD
    SaldoAnteriorPrimerDiaMes   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'CuentasBancariasSaldos', N'column', N'SaldoAnteriorPrimerDiaMes'
end
Go

--------------------<<19-03-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Lmateriales','IdUnidadFuncional', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Lmateriales ADD
    IdUnidadFuncional   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Lmateriales', N'column', N'IdUnidadFuncional'
end
Go

--------------------<<27-03-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','OperacionesMercadoInternoEntidadVinculada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    OperacionesMercadoInternoEntidadVinculada   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Clientes', N'column', N'OperacionesMercadoInternoEntidadVinculada'
end
Go

declare @esta1 int
exec _AlterTable 'Proveedores','OperacionesMercadoInternoEntidadVinculada', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    OperacionesMercadoInternoEntidadVinculada   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Proveedores', N'column', N'OperacionesMercadoInternoEntidadVinculada'
end
Go
--------------------<<23-04-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'RubrosContables','TomarMesDeVentaEnResumen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].RubrosContables ADD
    TomarMesDeVentaEnResumen   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'RubrosContables', N'column', N'TomarMesDeVentaEnResumen'
end
Go

declare @esta1 int
exec _AlterTable 'Obras','OrdenamientoSecundario', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    OrdenamientoSecundario   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/10/12', N'user', N'dbo', N'table', N'Obras', N'column', N'OrdenamientoSecundario'
end
Go


--------------------<<30-04-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP3_Letra_A', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    CodigoAFIP3_Letra_A   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP3_Letra_A'
end
Go

declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP3_Letra_B', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    CodigoAFIP3_Letra_B   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP3_Letra_B'
end
Go

declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP3_Letra_C', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    CodigoAFIP3_Letra_C   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP3_Letra_C'
end
Go

declare @esta1 int
exec _AlterTable 'TiposComprobante','CodigoAFIP3_Letra_E', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    CodigoAFIP3_Letra_E   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'CodigoAFIP3_Letra_E'
end
Go

declare @esta1 int
exec _AlterTable 'Facturas','IdTipoNegocioVentas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdTipoNegocioVentas   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdTipoNegocioVentas'
end
Go


declare @esta1 int
exec _AlterTable 'TiposRubrosFinancierosGrupos','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposRubrosFinancierosGrupos ADD
    Codigo   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'TiposRubrosFinancierosGrupos', N'column', N'Codigo'
end
Go

declare @esta1 int
exec _AlterTable 'Facturas','IdTipoNegocioVentas', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdTipoNegocioVentas   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdTipoNegocioVentas'
end
Go


declare @esta1 int
exec _AlterTable 'Proveedores','IdCuentaAplicacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    IdCuentaAplicacion   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdCuentaAplicacion'
end
Go
--------------------<<28-05-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Parametros2','Valor', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Parametros2 ADD
    Valor   [varchar] (500)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Parametros2', N'column', N'Valor'
end
Go

declare @esta1 int
exec _AlterTable 'Tree','Imagen', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Tree ADD
    Imagen   [varchar] (500)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Tree', N'column', N'Imagen'
end
Go

declare @esta1 int
exec _AlterTable 'Conjuntos','Version', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Conjuntos ADD
    Version   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Conjuntos', N'column', N'Version'
end
Go

declare @esta1 int
exec _AlterTable 'Facturas','NumeroOrdenCompraExterna', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    NumeroOrdenCompraExterna   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Facturas', N'column', N'NumeroOrdenCompraExterna'
end
Go
--------------------<<9-06-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'AjustesStock','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].AjustesStock ADD
    ArchivoAdjunto1   [varchar] (100)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'ArchivoAdjunto1'
end
Go
declare @esta1 int
exec _AlterTable 'AjustesStock','ArchivoAdjunto2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].AjustesStock ADD
    ArchivoAdjunto2   [varchar] (100)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'AjustesStock', N'column', N'ArchivoAdjunto2'
end
Go

declare @esta1 int
exec _AlterTable 'DescripcionIva','PorcentajePercepcion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DescripcionIva ADD
    PorcentajePercepcion   [Numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'DescripcionIva', N'column', N'PorcentajePercepcion'
end
Go
--------------------<<1-07-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestosVentas','IdDetalleClienteLugarEntrega', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestosVentas ADD
    IdDetalleClienteLugarEntrega   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'PresupuestosVentas', N'column', N'IdDetalleClienteLugarEntrega'
end
Go

--------------------<<18-07-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Rubros','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Rubros ADD
    Codigo   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Rubros', N'column', N'Codigo'
end
Go

declare @esta1 int
exec _AlterTable 'Subrubros','Codigo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Subrubros ADD
    Codigo   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/04/14', N'user', N'dbo', N'table', N'Subrubros', N'column', N'Codigo'
end
Go

--------------------<<28-07-2014 >>----------------------

ALTER TABLE [dbo].[DescripcionIva]
DROP CONSTRAINT  PK_DescripcionIva
GO
ALTER TABLE [dbo].[DescripcionIva]
    Alter Column [IdCodigoIva] [int]
GO
ALTER TABLE [dbo].[DescripcionIva]
ADD CONSTRAINT PK_DescripcionIva
PRIMARY KEY (IdCodigoIva)
GO


--------------------<<30-07-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'Rubros','IdTipoOperacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Rubros ADD
    IdTipoOperacion   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Rubros', N'column', N'IdTipoOperacion'
end
Go

declare @esta1 int
exec _AlterTable 'Facturas','IdTipoOperacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdTipoOperacion   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdTipoOperacion'
end
Go

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdTipoOperacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    IdTipoOperacion   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdTipoOperacion'
end
Go

declare @esta1 int
exec _AlterTable 'NotasCredito','IdTipoOperacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdTipoOperacion   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdTipoOperacion'
end
Go

--------------------<< 11-08-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleAjustesStock','IdDetalleValeSalida', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAjustesStock ADD
    IdDetalleValeSalida   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'DetalleAjustesStock', N'column', N'IdDetalleValeSalida'
end
Go
		
--------------------<< 15-08-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'CartasDePorte','IdCorredor2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    IdCorredor2   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'IdCorredor2'
end
Go					
declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio1   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio1'
end
Go	
declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio2   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio2'
end
Go			
declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio3', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio3   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio3'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio4', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio4   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio4'
end
Go				
declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio5', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio5   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio5'
end
Go				

--------------------<< 28-08-2014 >>----------------------
declare @esta1 int
exec _AlterTable 'PresupuestoObrasRedeterminaciones','Año', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasRedeterminaciones ADD
    Año   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasRedeterminaciones', N'column', N'Año'
end
Go	
declare @esta1 int
exec _AlterTable 'PresupuestoObrasRedeterminaciones','Mes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasRedeterminaciones ADD
    Mes   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasRedeterminaciones', N'column', N'Mes'
end
Go	
declare @esta1 int
exec _AlterTable 'PresupuestoObrasRedeterminaciones','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasRedeterminaciones ADD
    IdPresupuestoObrasNodo   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasRedeterminaciones', N'column', N'IdPresupuestoObrasNodo'
end
Go	
declare @esta1 int
exec _AlterTable 'PresupuestoObrasRedeterminaciones','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasRedeterminaciones ADD
    Observaciones   [Ntext]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasRedeterminaciones', N'column', N'Observaciones'
end
Go	
	
declare @esta1 int
exec _AlterTable 'DetalleRequerimientosLogSituacion','CambioSituacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRequerimientosLogSituacion ADD
    CambioSituacion   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'DetalleRequerimientosLogSituacion', N'column', N'CambioSituacion'
end
Go	

declare @esta1 int
exec _AlterTable 'ValesSalida','IdUsuarioDioPorCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ValesSalida ADD
    IdUsuarioDioPorCumplido   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ValesSalida', N'column', N'IdUsuarioDioPorCumplido'
end
Go	
declare @esta1 int
exec _AlterTable 'ValesSalida','FechaDioPorCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ValesSalida ADD
    FechaDioPorCumplido   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ValesSalida', N'column', N'FechaDioPorCumplido'
end
Go	
declare @esta1 int
exec _AlterTable 'ValesSalida','MotivoDioPorCumplido', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ValesSalida ADD
    MotivoDioPorCumplido   [Ntext]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ValesSalida', N'column', N'MotivoDioPorCumplido'
end
Go	

-----------------------<<08-09-2014>>---------------------
declare @esta1 int
exec _AlterTable 'DetalleClientes','Acciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleClientes ADD
    Acciones   [Varchar] (500)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'DetalleClientes', N'column', N'Acciones'
end
Go	

declare @esta1 int
exec _AlterTable 'DetalleProveedores','Acciones', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleProveedores ADD
    Acciones   [Varchar] (500)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'DetalleProveedores', N'column', N'Acciones'
end
Go	





--Alter agregado por Mariano el dia 17-09-2014, No sabemos si Eduardo lo tiene en el Doc
ALTER TABLE empleadosaccesos ALTER COLUMN Nodo varchar(100) NULL
go

ALTER TABLE [dbo].[Tree]
DROP CONSTRAINT  PK_Tree
GO
ALTER TABLE [dbo].[Tree]
    ALTER COLUMN IdItem varchar(30) NOT NULL
GO
ALTER TABLE [dbo].[Tree]
ADD CONSTRAINT PK_Tree
PRIMARY KEY (IdItem)
GO

ALTER TABLE Tree ALTER COLUMN Clave varchar(100) NULL
go



-----------------------<<18-09-2014>>---------------------
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ArchivoAdjunto1', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    ArchivoAdjunto1   [Varchar] (200)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ArchivoAdjunto1'
end
Go	

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','ArchivoAdjunto2', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    ArchivoAdjunto2   [Varchar] (200)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'ArchivoAdjunto2'
end
Go	



-----------------------<<02-10-2014>>---------------------
declare @esta1 int
exec _AlterTable 'DetalleRequerimientos','IdPresupuestoObrasNodo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRequerimientos ADD
    IdPresupuestoObrasNodo   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'DetalleRequerimientos', N'column', N'IdPresupuestoObrasNodo'
end
Go	


-- AGREGADO POR MARIANO 
declare @esta1 int
exec _AlterTable 'Clientes','CartaPorteTipoDeAdjuntoDeFacturacion', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    CartaPorteTipoDeAdjuntoDeFacturacion   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'Clientes', N'column', N'CartaPorteTipoDeAdjuntoDeFacturacion'
end
Go	
-----------------------<<17-11-2014>>---------------------



declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdArticulo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    IdArticulo   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdArticulo'
end
Go	


-----------------------<<18-11-2014>>---------------------


declare @esta1 int
exec _AlterTable 'Proveedores','CodigoCategoriaIIBBAlternativo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    CodigoCategoriaIIBBAlternativo   [varchar] (1)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/11/2014', N'user', N'dbo', N'table', N'Proveedores', N'column', N'CodigoCategoriaIIBBAlternativo'
end
Go	

-----------------------<<27-11-2014>>---------------------

declare @esta1 int
exec _AlterTable 'TiposNegociosVentas','Grupo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposNegociosVentas ADD
    Grupo   [varchar] (20)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 27/11/2014', N'user', N'dbo', N'table', N'TiposNegociosVentas', N'column', N'Grupo'
end
Go	

-----------------------<<28-11-2014>>---------------------


declare @esta1 int
exec _AlterTable 'TiposNegociosVentas','Grupo', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposNegociosVentas ADD
    Grupo   [varchar] (20)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/11/2014', N'user', N'dbo', N'table', N'TiposNegociosVentas', N'column', N'Grupo'
end
Go	

-----------------------<<1-12-2014>>---------------------

declare @esta1 int
exec _AlterTable 'Proveedores','FechaInicialControlComprobantes', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    FechaInicialControlComprobantes   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 1/12/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaInicialControlComprobantes'
end
Go	

-----------------------<<22-12-2014>>---------------------


declare @esta1 int
exec _AlterTable 'Proveedores','ResolucionAfip3668', @esta = @esta1 output
if @esta1 = 0
begin
select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ResolucionAfip3668   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 28/11/2014', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ResolucionAfip3668'
end
Go	

--------------------<< FIN ALTER TABLE >>----------------------











































--------------------<< ALTER COLUMN >>----------------------
--------------------------<20/03/2012>
  ALTER TABLE [dbo].[_TempCuboIngresoEgresosPorObra]
    Alter Column [Entidad] [Varchar] (100) NULL

GO
 ALTER TABLE [dbo].[_TempVentasParaCubo]
    Alter Column [Detalle] [Varchar] (200) NULL

GO
 ALTER TABLE [dbo].[Facturas]
    Alter Column [IdTransportista1] [int] NULL

GO
 ALTER TABLE [dbo].[Facturas]
    Alter Column [IdTransportista2] [int] NULL

GO
 ALTER TABLE [dbo].[Facturas]
    Alter Column [CAE] [varchar] (14) NULL

GO

 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante1] [numeric] (18,0) NULL

GO

 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante2] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante3] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante4] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante5] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante6] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante7] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante8] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante9] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[Recibos]
    Alter Column [NumeroComprobante10] [numeric] (18,0) NULL

GO
 ALTER TABLE [dbo].[IBcondiciones]
    Alter Column [IdProvinciaReal] [Int] NULL

GO

ALTER TABLE [dbo].[Facturas]
    Alter Column [NumeroOrdenCompraExterna] [Bigint] NULL

GO

ALTER TABLE [dbo].[Clientes]
    Alter Column [IdCodigoIva] [int] NULL

GO

ALTER TABLE [dbo].[Proveedores]
    Alter Column [IdCodigoIva] [int] NULL

GO

 ALTER TABLE [dbo].[DetalleClientes]
    Alter Column [Email] [varchar] (200) NULL

GO


--------------------<< FIN ALTER COLUMN >>----------------------


















































































































/*Eliminamos la Tabla _TempInformacionImpositiva*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_TempInformacionImpositiva]') AND type in (N'U'))
DROP TABLE [dbo].[_TempInformacionImpositiva]
GO


/* Se Agregan Valores por Defecto a la Tabla archivosATransmitir */


Truncate table ArchivosATransmitir
/*Sistema Pronto Sat*/
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Rubros','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Subrubros','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Familias','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Articulos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Obras','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Equipos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetEquipos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Planos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Clientes','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Acopios','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetAcopios','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetAcopiosEquipos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetAcopiosRevisiones','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Proveedores','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('ArchivosATransmitirDestinos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Transportistas','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Pedidos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetPedidos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Localidades','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Provincias','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Paises','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Monedas','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Sectores','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Cuentas','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('UnidadesOperativas','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Unidades','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('SalidasMateriales','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetRequerimientos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('CondicionesCompra','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DescripcionIva','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Cotizaciones','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Ubicaciones','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Depositos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Empleados','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetArticulosUnidades','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Conjuntos','SAT')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetConjuntos','SAT')
/*Sistema de Mantenimiento*/
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Articulos','MANTENIMIENTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Obras','MANTENIMIENTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetObrasDestinos','MANTENIMIENTO')
/*Sistema de Pronto*/
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Clientes','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Facturas','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetFacturas','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Recibos','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetRecibos','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetRecibosCuentas','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetRecibosRubrosContables','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetRecibosValores','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('CtasCtesD','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Subdiarios','PRONTO')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Valores','PRONTO')
/*Sistema de Balanza*/
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Rubros','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Subrubros','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Familias','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Articulos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Obras','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Clientes','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Proveedores','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('ArchivosATransmitirDestinos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Transportistas','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Pedidos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetPedidos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Localidades','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Provincias','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Paises','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Monedas','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Sectores','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Cuentas','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('UnidadesOperativas','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Unidades','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DescripcionIva','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Ubicaciones','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Depositos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Empleados','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Conjuntos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetConjuntos','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Choferes','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('Fletes','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('TarifasFletes','BALANZA')
INSERT INTO ArchivosATransmitir (Descripcion,Sistema) VALUES('DetArticulosUnidades','BALANZA')
GO





/*
ACTUALIZAMOS LA TABLA TIPOSCOMPROBANTE PARA PODER SACAR LA RESOLUCION RG1361
*/

update tiposcomprobante
set VaAlRegistroComprasAFIP = 'SI'
where Agrupacion1='Proveedores' and VaAlRegistroComprasAFIP is null 


update TiposComprobante
set    VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='CP'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='FC'

update TiposComprobante
set	VaAlLibro = 'NO', VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='CI'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='DP'

update TiposComprobante
set	VaAlLibro ='NO'	, VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='DI'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='DBG'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='CB'

update TiposComprobante
set	VaAlLibro ='NO'	, VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='DFF'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='Tik'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='RP'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='OT'
GO

/*
AGREGAMOS TIPOS DE COMPROBANTES NUEVOS 05-08-11


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 50),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (50,'Salida de Materiales',1,'SM','NO',null,'STOCK',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 51),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (51,'Nota De pedido',1,'PE','NO',null,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 52),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (52,'Ticket-Factura',1,'TKF','NO',01,'PROVEEDORES','SI',null,null,null,null,null,null,null,null,'SI','SI',null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 53),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (53,'Comprobantes de Servicios Publicos',1,'TKF','NO',01,'PROVEEDORES','SI',null,null,null,null,null,null,null,null,'SI','SI',null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 60),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (60,'Recepcion de Materiales',1,'RC','NO',01,'STOCK',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 61),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (61,'Ticket-Factura',1,'TK','NO',00,'VENTAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 70),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (70,'Subcontrato',1,'SC','NO',00,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)

if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 71),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (71,'Parte Produccion',1,'PP','NO',00,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)

if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 101),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (101,'Lista Acopio',1,'LA','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)

if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 102),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (102,'Lista Materiales',1,'LM','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 103),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (103,'Requerimiento',1,'RQ','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)

if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 104),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (104,'Solicitud de Cotizacion',1,'SC','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)				


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 105),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (105,'Comparativa',1,'CM','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 106),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (106,'Ajuste de Stock',1,'AJ','NO',00,'STOCK',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 107),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (107,'Autorizacion de Compra',1,'AC','NO',00,'COMPRAS',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)


if (Isnull((Select COUNT(*) from TiposComprobante
	where IdTipoComprobante = 108),0)) = 0
Insert into TiposComprobante	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,EsValor,CodigoDgi,Agrupacion1,CalculaDiferenciaCambio,VaAlLibro,PideBancoCuenta,PideCuenta,
								IdCuentaDefault,VaAConciliacionBancaria,LlevarAPesosEnValores,CoeficienteParaFondoFijo,CoeficienteParaConciliaciones,VaAlCiti,VaAlRegistroComprasAFIP,
								CodigoAFIP_Letra_A,CodigoAFIP_Letra_B,CodigoAFIP_Letra_C,CodigoAFIP_Letra_E,InformacionAuxiliar,ExigirCAI,NumeradorAuxiliar,CodigoAFIP2_Letra_A,
								CodigoAFIP2_Letra_B,CodigoAFIP2_Letra_C,CodigoAFIP2_Letra_E) 
						Values (108,'Otros Ingresos',1,'OI','NO',00,'STOCK',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
*/

/*
Insertamos en la tabla Tipos de Comprobante el registro para poder llevar puntos de venta en las salidas de materiales
*/
if (Isnull((Select COUNT(*) from TiposComprobante
	where Descripcion ='Salida de materiales'),0)) < 1 
insert into TiposComprobante 
	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,Agrupacion1) 
		values (50,'Salida de materiales',1,'SM','STOCK')

GO

if (Isnull((Select COUNT(*) from TiposComprobante
	where Descripcion ='Gastos Fletes'),0)) < 1 
insert into TiposComprobante 
	(IdTipoComprobante,Descripcion,Coeficiente,DescripcionAb,Agrupacion1) 
		values (120,'Gastos Fletes',1,'GF',null)

GO

/*
Importante : Inicializar CantidadCC= Cantidad
esta opcion de control de Calidad dentro de Otros Ingresos a Almacen
se programo para Cedinsa
*/
Update DetalleOtrosIngresosAlmacen
set CantidadCC = Cantidad
Where CantidadCC is null
go

/* Consultar si estos parametros son iguales para todas las empresas */
/* Update Parametros */
/* set TopeMinimoRetencionIVA = 320 */
/* GO */

/* Update Parametros */
/* set TopeMinimoRetencionIVAServicios = 200 */
/* GO */


/* Se agregan los campos de la tabla CuentaCorrienteDeudores que se eliminaron en el incio */
/* de este archivo */


ALTER TABLE [dbo].[CuentasCorrientesDeudores] ADD
  [Saldotrs] [Numeric] (19,2) NULL
GO

ALTER TABLE [dbo].[CuentasCorrientesDeudores] ADD
  [Marca] [Varchar] (2) NULL
GO

/*
Actualizamos la tabla parametros2 para la Rg de los monotributistas
*/

if (select Count(*) from Parametros2
where Campo = 'TopeMonotributoAnual_Servicios') = 1
begin
declare @IdParametro int, @Valor int
set @IdParametro = (select IdParametro from parametros2 where Campo='TopeMonotributoAnual_Servicios')
set @Valor = (select Valor from parametros2 where Campo='TopeMonotributoAnual_Servicios')
Update Parametros2
set Valor = 999999
where IdParametro = @IdParametro and @Valor = 0
end
go
if (select Count(*) from Parametros2
where Campo = 'TopeMonotributoAnual_Bienes') = 1
begin
declare @IdParametro int, @Valor int
set @IdParametro = (select IdParametro from parametros2 where Campo='TopeMonotributoAnual_Bienes')
set @Valor = (select Valor from parametros2 where Campo='TopeMonotributoAnual_Bienes')
Update Parametros2
set Valor = 999999
where IdParametro = @IdParametro and @Valor = 0
end
go
if (select Count(*) from Parametros2
where Campo = 'TopeMonotributoAnual_Servicios') = 0
begin
Insert into Parametros2 (Campo,Valor) Values ('TopeMonotributoAnual_Servicios',999999)
end
if (select Count(*) from Parametros2
where Campo = 'TopeMonotributoAnual_Bienes') = 0
begin
Insert into Parametros2 (Campo,Valor) Values ('TopeMonotributoAnual_Bienes',999999)
end
GO




/*
Actualizamos la tabla TiposCuenta Paea que este el tipo Cuenta Madre que tiene que tener el ID numero 4
*/
if (select count(*) from TiposCuenta
where Descripcion='Cuenta madre') = '0'
insert into TiposCuenta (Descripcion)
values ('Cuenta madre')
GO
if (select count(*) from TiposCuenta
where Descripcion='Total') = '1'
Delete from  TiposCuenta where Descripcion='Total'
GO

/*
Actualizamos la talba de TiposImpuesto
*/
if (select count(*) from TiposImpuesto
where Descripcion='RETENCION IVA') = 0
insert into TiposImpuesto (Descripcion) 
		values ('RETENCION IVA')

GO


/*
Actualizamos la tabla IBCondiciones y le colocamos la primer provincia que encuentra
en los registros que estan en NULL, esto es para corregir un error que tira el sistema 
cuando se hace una OP y no recalcula las retenciones
*/
Update IBCondiciones
set IdProvincia = (select top 1 IdProvincia from Provincias),
IdProvinciaReal = (select top 1 IdProvincia from Provincias)
where IdProvincia not in (Select IdProvincia from Provincias) or IdProvincia is null


/*
Revisa en Parametros si la empresa Percibe IIBB y baja el tilde a todos los puntos de venta que no estén parametrizados
*/
update PuntosVenta
set AgentePercepcionIIBB = 'SI'
where (Select COUNT(*) from Parametros where PercepcionIIBB = 'SI')>0 and AgentePercepcionIIBB is null

---------<< Corrige Tabla Temp de Cubo de Ventas >>---------
alter table _TempVentasParaCubo
alter column Detalle varchar(200)

---------<< Corrige Campos SubItem para Presupuesto >>---------
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [SubItem1] varchar (10)
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [SubItem2] varchar (10)
ALTER TABLE [dbo].[PresupuestoObrasNodos]
       ALTER COLUMN [SubItem3] varchar (10)
	   


	   


