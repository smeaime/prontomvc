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

@tabla Varchar(200),
@campo varchar(200),
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

--------------------<< 07/01/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'DetalleNotasCredito','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleNotasCredito ADD
    Observaciones   [ntext]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/12/2015', N'user', N'dbo', N'table', N'DetalleNotasCredito', N'column', N'Observaciones'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleNotasCredito','OrigenDescripcion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleNotasCredito ADD
    OrigenDescripcion   [Int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'DetalleNotasCredito', N'column', N'OrigenDescripcion'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleNotasDebito','Observaciones', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleNotasDebito ADD
    Observaciones   [ntext]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 23/12/2015', N'user', N'dbo', N'table', N'DetalleNotasDebito', N'column', N'Observaciones'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleNotasDebito','OrigenDescripcion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleNotasDebito ADD
    OrigenDescripcion   [Int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'DetalleNotasDebito', N'column', N'OrigenDescripcion'
end
Go


--------------------<< 08/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','CoeficienteCompra', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    CoeficienteCompra   [Numeric] (5,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'Pedidos', N'column', N'CoeficienteCompra'
end
Go	


--------------------<< 13/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','Detalle', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    Detalle   [Varchar] (100)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'Pedidos', N'column', N'Detalle'
end
Go	

--------------------<< 14/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleAutorizacionesFirmantes','IdPuntoVenta', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAutorizacionesFirmantes ADD
    IdPuntoVenta   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'DetalleAutorizacionesFirmantes', N'column', N'IdPuntoVenta'
end
Go	

--------------------<< 21/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleAutorizaciones','Excluyente', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleAutorizaciones ADD
    Excluyente   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'DetalleAutorizaciones', N'column', N'Excluyente'
end
Go	

--------------------<< 22/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','ExcluirDelCircuitoDeFirmasComprobantes', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ExcluirDelCircuitoDeFirmasComprobantes   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ExcluirDelCircuitoDeFirmasComprobantes'
end
Go	

--------------------<< 25/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Rubros','AsignarIPsObradorCentral', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Rubros ADD
    AsignarIPsObradorCentral   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 03/10/2014', N'user', N'dbo', N'table', N'Rubros', N'column', N'AsignarIPsObradorCentral'
end
Go	

--------------------<< 29/01/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Proveedores','ExcluirDeActualizacionIvaRG18', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    ExcluirDeActualizacionIvaRG18   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Proveedores', N'column', N'ExcluirDeActualizacionIvaRG18'
end
Go	

--------------------<< 02/02/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Requerimientos','Detalle2', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Requerimientos ADD
    Detalle2   [Varchar] (50)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Requerimientos', N'column', N'Detalle2'
end
Go	

--------------------<< 08/03/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Devoluciones','CAE', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    CAE   [Varchar] (14)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'CAE'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RechazoCAE   [Varchar] (11)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RechazoCAE'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','FechaVencimientoORechazoCAE', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    FechaVencimientoORechazoCAE   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'FechaVencimientoORechazoCAE'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIdentificacionCAE', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIdentificacionCAE   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIdentificacionCAE'
end
Go	

--------------------<< 16/03/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Condiciones Compra','AsociarARecepciones', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Condiciones Compra] ADD
    AsociarARecepciones   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Condiciones Compra', N'column', N'AsociarARecepciones'
end
Go	
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','IdUsuarioEnlazoRecepcion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleComprobantesProveedores ADD
    IdUsuarioEnlazoRecepcion   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'IdUsuarioEnlazoRecepcion'
end
Go	
declare @esta1 int
exec _AlterTable 'DetalleComprobantesProveedores','FechaEnlazoRecepcion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleComprobantesProveedores ADD
    FechaEnlazoRecepcion   [datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleComprobantesProveedores', N'column', N'FechaEnlazoRecepcion'
end
Go	
--------------------<< 22/03/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','BienesOServicios', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    BienesOServicios   [Varchar] (1)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'BienesOServicios'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','FechaInicioServicio', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    FechaInicioServicio   [datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'FechaInicioServicio'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','FechaFinServicio', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    FechaFinServicio   [datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'FechaFinServicio'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','FechaInicioServicio', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    FechaInicioServicio   [datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'FechaInicioServicio'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','FechaFinServicio', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    FechaFinServicio   [datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'FechaFinServicio'
end
Go	

--------------------<< 23/03/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Devoluciones','Cliente', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    Cliente   [Varchar] (50)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'Cliente'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','OrigenRegistro', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    OrigenRegistro   [Varchar] (12)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'OrigenRegistro'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','CuitClienteExterno', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    CuitClienteExterno   [Varchar] (13)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'CuitClienteExterno'
end
Go	


declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','OrigenRegistro', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    OrigenRegistro   [Varchar] (12)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'OrigenRegistro'
end
Go	

--------------------<< 24/03/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'NovedadesUsuarios','Mensaje', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NovedadesUsuarios ADD
    Mensaje   [ntext]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NovedadesUsuarios', N'column', N'Mensaje'
end
Go	
--------------------<< 12/04/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Viajes','IdCliente', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdCliente   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdCliente'
end
Go	
declare @esta1 int
exec _AlterTable 'Viajes','IdArticulo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdArticulo   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdArticulo'
end
Go	
declare @esta1 int
exec _AlterTable 'Viajes','IdTarifaFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdTarifaFlete   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdTarifaFlete'
end
Go	
declare @esta1 int
exec _AlterTable 'Viajes','IdUnidad', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdUnidad   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdUnidad'
end
Go	
declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','IdCliente', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    IdCliente   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'IdCliente'
end
Go	
declare @esta1 int
exec _AlterTable 'Facturas','IdLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdLiquidacionFlete   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdLiquidacionFlete'
end
Go	

--------------------<< 24/04/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','PorcentajeIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    PorcentajeIva   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'PorcentajeIva'
end
Go	
declare @esta1 int
exec _AlterTable 'DetalleDevoluciones','ImporteIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleDevoluciones ADD
    ImporteIva   [numeric] (18,4)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleDevoluciones', N'column', N'ImporteIva'
end
Go	
declare @esta1 int
exec _AlterTable 'Devoluciones','OtrasPercepciones3', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    OtrasPercepciones3   [numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'OtrasPercepciones3'
end
Go	
declare @esta1 int
exec _AlterTable 'Devoluciones','OtrasPercepciones3Desc', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    OtrasPercepciones3Desc   [varchar] (15)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'OtrasPercepciones3Desc'
end
Go	
declare @esta1 int
exec _AlterTable 'Devoluciones','AjusteIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    AjusteIva   [numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'AjusteIva'
end
Go	


--------------------<< 04/05/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Localidades','CodigoCGG', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Localidades ADD
    CodigoCGG   [varchar] (10)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 04/05/2016', N'user', N'dbo', N'table', N'Localidades', N'column', N'CodigoCGG'
end
Go	

--------------------<< 04/05/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'TarifasFletes','ValorUnitario2', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarifasFletes ADD
    ValorUnitario2   [numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'ValorUnitario2'
end
Go	

declare @esta1 int
exec _AlterTable 'Viajes','Tarifa2', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    Tarifa2   [numeric] (18,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'Tarifa2'
end
Go	

--------------------<< 09/05/2016 >>----------------------

  ALTER TABLE [dbo].[CertificacionesObrasPxQ]
    Alter Column [Cantidad] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[CertificacionesObrasPxQ]
    Alter Column [CantidadAvance] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[CertificacionesObras]
    Alter Column [Cantidad] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [Importe] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [Cantidad] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [ImporteAvance] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [CantidadAvance] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [CantidadAvanceAcumulada] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [ImporteDescuento] [Numeric] (18,4) NULL
  ALTER TABLE [dbo].[SubcontratosPxQ]
    Alter Column [ImporteTotal] [Numeric] (18,4) NULL
GO


declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion31   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion31'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos31   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos31   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion32   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion32'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos32   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos32'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos32   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos32'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion33   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion33'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos33   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos33'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos33   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos33'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion34   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion34'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos34   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos34'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos34   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos34'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion35   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion35'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos35   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos35'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos35   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos35'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion36   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion36'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos36   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos36'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos36   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos36'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion37   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion37'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos37   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos37'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos37   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos37'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion38   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion38'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos38   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos38'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos38   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos38'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','IdIBCondicion39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    IdIBCondicion39   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'IdIBCondicion39'
end
Go	

declare @esta1 int
exec _AlterTable 'Facturas','RetencionIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    RetencionIBrutos39   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'RetencionIBrutos39'
end
Go	


declare @esta1 int
exec _AlterTable 'Facturas','PorcentajeIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    PorcentajeIBrutos39   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'PorcentajeIBrutos39'
end
Go

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion31   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion31'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos31   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos31   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion32   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion32'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos32   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos32'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos32   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos32'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion33   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion33'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos33   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos33'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos33   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos33'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion34   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion34'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos34   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos34'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos34   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos34'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion35   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion35'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos35   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos35'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos35   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos35'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion36   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion36'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos36   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos36'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos36   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos36'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion37   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion37'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos37   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos37'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos37   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos37'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion38   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion38'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos38   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos38'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos38   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos38'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','IdIBCondicion39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    IdIBCondicion39   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'IdIBCondicion39'
end
Go	

declare @esta1 int
exec _AlterTable 'Devoluciones','RetencionIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    RetencionIBrutos39   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'RetencionIBrutos39'
end
Go	


declare @esta1 int
exec _AlterTable 'Devoluciones','PorcentajeIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Devoluciones ADD
    PorcentajeIBrutos39   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Devoluciones', N'column', N'PorcentajeIBrutos39'
end
Go

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion31   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos31   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos31   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion32   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion32'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos32   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos32'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos32   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos32'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion33   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion33'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos33   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos33'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos33   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos33'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion34   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion34'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos34   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos34'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos34   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos34'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion35   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion35'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos35   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos35'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos35   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos35'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion36   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion36'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos36   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos36'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos36   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos36'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion37   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion37'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos37   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos37'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos37   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos37'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion38   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion38'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos38   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos38'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos38   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos38'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdIBCondicion39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdIBCondicion39   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdIBCondicion39'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','RetencionIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    RetencionIBrutos39   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'RetencionIBrutos39'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasCredito','PorcentajeIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    PorcentajeIBrutos39   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'PorcentajeIBrutos39'
end
Go


declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion31   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos31   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos31', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos31   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos31'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion32   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion32'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos32   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos32'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos32', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos32   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos32'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion33   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion33'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos33   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos33'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos33', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos33   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos33'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion34   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion34'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos34   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos34'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos34', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos34   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos34'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion35   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion35'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos35   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos35'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos35', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos35   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos35'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion36   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion36'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos36   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos36'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos36', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos36   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos36'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion37   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion37'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos37   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos37'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos37', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos37   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos37'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion38   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion38'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos38   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos38'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos38', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos38   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos38'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdIBCondicion39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdIBCondicion39   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdIBCondicion39'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','RetencionIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    RetencionIBrutos39   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'RetencionIBrutos39'
end
Go	


declare @esta1 int
exec _AlterTable 'NotasDebito','PorcentajeIBrutos39', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    PorcentajeIBrutos39   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'PorcentajeIBrutos39'
end
Go
--------------------<< 13/05/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'Valores','PercepcionIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    PercepcionIva   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Valores', N'column', N'PercepcionIva'
end
Go

declare @esta1 int
exec _AlterTable 'Valores','IdCuentaPercepcionIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Valores] ADD
    [IdCuentaPercepcionIva] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Valores', N'column', N'IdCuentaPercepcionIva'
end
GO

declare @esta1 int
exec _AlterTable 'Valores','PorcentajePercepcionIva', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Valores ADD
    PorcentajePercepcionIva   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Valores', N'column', N'PorcentajePercepcionIva'
end
Go

--------------------<< 19/05/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'CertificacionesObrasDatos','MontoEstimado', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CertificacionesObrasDatos ADD
    MontoEstimado   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'CertificacionesObrasDatos', N'column', N'MontoEstimado'
end
Go

--------------------<< 31/05/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'ImpuestosDirectos','ImpuestoMinimo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ImpuestosDirectos ADD
    ImpuestoMinimo   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'ImpuestosDirectos', N'column', N'ImpuestoMinimo'
end
Go
--------------------<<   02/06/2016     >>----------------------
declare @esta1 int
exec _AlterTable 'NotasDebito','ActivarRecuperoGastos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [ActivarRecuperoGastos] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'ActivarRecuperoGastos'
end

GO

declare @esta1 int
exec _AlterTable 'NotasDebito','IdAutorizoRecuperoGastos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasDebito] ADD
    [IdAutorizoRecuperoGastos] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdAutorizoRecuperoGastos'
end
GO

declare @esta1 int
exec _AlterTable 'NotasCredito','IdNotaDebitoVenta_RecuperoGastos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[NotasCredito] ADD
    [IdNotaDebitoVenta_RecuperoGastos] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdNotaDebitoVenta_RecuperoGastos'
end
GO

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdNotaDebitoVenta_RecuperoGastos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[ComprobantesProveedores] ADD
    [IdNotaDebitoVenta_RecuperoGastos] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdNotaDebitoVenta_RecuperoGastos'
end
GO

declare @esta1 int
exec _AlterTable 'Viajes','Comision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    Comision   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'Viajes', N'column', N'Comision'
end
Go

declare @esta1 int
exec _AlterTable 'Viajes','CartaPorte', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Viajes] ADD
    [CartaPorte] [Varchar] (15) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Viajes', N'column', N'CartaPorte'
end

GO

declare @esta1 int
exec _AlterTable 'Viajes','IdOrigen', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Viajes] ADD
    [IdOrigen] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Viajes', N'column', N'IdOrigen'
end
GO

declare @esta1 int
exec _AlterTable 'Viajes','IdDestino', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Viajes] ADD
    [IdDestino] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Viajes', N'column', N'IdDestino'
end
GO

declare @esta1 int
exec _AlterTable 'DetalleLiquidacionesFletes','Comision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleLiquidacionesFletes ADD
    Comision   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'DetalleLiquidacionesFletes', N'column', N'Comision'
end
Go


--------------------<<   03/06/2016     >>----------------------

declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','Comision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    Comision   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'Comision'
end
Go

declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','PorcentajeIvaComision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    PorcentajeIvaComision   [numeric] (6,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'PorcentajeIvaComision'
end
Go

declare @esta1 int
exec _AlterTable 'LiquidacionesFletes','IvaComision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LiquidacionesFletes ADD
    IvaComision   [numeric] (18,2)NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 29/01/2016', N'user', N'dbo', N'table', N'LiquidacionesFletes', N'column', N'IvaComision'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleFacturas','IdDetalleLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[DetalleFacturas] ADD
    [IdDetalleLiquidacionFlete] [int] NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'DetalleFacturas', N'column', N'IdDetalleLiquidacionFlete'
end
GO

--------------------<<   07/06/2016     >>----------------------

declare @esta1 int
exec _AlterTable 'Obras','RegimenMinero', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Obras] ADD
    [RegimenMinero] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Obras', N'column', N'RegimenMinero'
end

GO

declare @esta1 int
exec _AlterTable 'Proveedores','ResolucionAfip3692', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].[Proveedores] ADD
    [ResolucionAfip3692] [Varchar] (2) NULL
     exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 050608',
     N'user', N'dbo', N'table', N'Proveedores', N'column', N'ResolucionAfip3692'
end

GO

--------------------<< 10-06-2016 >>----------------------
Go				
declare @esta1 int
exec _AlterTable 'CartasDePorte','AcopioFacturarleA', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    AcopioFacturarleA   [Int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'AcopioFacturarleA'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGranosDanadosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGranosDanadosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGranosDanadosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGranosExtranosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGranosExtranosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGranosExtranosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGranosExtranosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGranosExtranosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGranosExtranosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadQuebradosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadQuebradosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadQuebradosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadDanadosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadDanadosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadDanadosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadChamicoMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadChamicoMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadChamicoMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadRevolcadosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadRevolcadosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadRevolcadosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadObjetablesMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadObjetablesMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadObjetablesMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadAmohosadosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadAmohosadosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadAmohosadosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPuntaSobreadaMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPuntaSobreadaMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPuntaSobreadaMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadHectolitricoMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadHectolitricoMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadHectolitricoMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadCarbonMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadCarbonMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadCarbonMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPanzaBlancaMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPanzaBlancaMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPanzaBlancaMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPicadosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPicadosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPicadosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadVerdesMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadVerdesMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadVerdesMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadQuemadosMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadQuemadosMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadQuemadosMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadTierraMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadTierraMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadTierraMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadZarandeoMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadZarandeoMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadZarandeoMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadDescuentoFinalMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadDescuentoFinalMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadDescuentoFinalMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadHumedadMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadHumedadMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadHumedadMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGastosFumigacionMerma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGastosFumigacionMerma   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGastosFumigacionMerma'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadQuebradosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadQuebradosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadQuebradosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadChamicoRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadChamicoRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadChamicoRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadRevolcadosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadRevolcadosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadRevolcadosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadObjetablesRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadObjetablesRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadObjetablesRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadAmohosadosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadAmohosadosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadAmohosadosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPuntaSobreadaRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPuntaSobreadaRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPuntaSobreadaRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadHectolitricoRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadHectolitricoRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadHectolitricoRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadCarbonRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadCarbonRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadCarbonRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPanzaBlancaRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPanzaBlancaRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPanzaBlancaRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadPicadosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadPicadosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadPicadosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadVerdesRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadVerdesRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadVerdesRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadQuemadosRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadQuemadosRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadQuemadosRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadTierraRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadTierraRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadTierraRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadZarandeoRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadZarandeoRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadZarandeoRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadDescuentoFinalRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadDescuentoFinalRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadDescuentoFinalRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadHumedadRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadHumedadRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadHumedadRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGastosFumigacionRebaja', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGastosFumigacionRebaja   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGastosFumigacionRebaja'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadHumedadResultado', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadHumedadResultado   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadHumedadResultado'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','CalidadGastosFumigacionResultado', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    CalidadGastosFumigacionResultado   [Numeric] (18,2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'CalidadGastosFumigacionResultado'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','Acopio6', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    Acopio6   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'Acopio6'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','ConDuplicados', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    ConDuplicados   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'ConDuplicados'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','TieneRecibidorOficial', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    TieneRecibidorOficial   [Varchar] (2) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'TieneRecibidorOficial'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','EstadoRecibidor', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    EstadoRecibidor   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'EstadoRecibidor'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','ClienteAcondicionador', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    ClienteAcondicionador   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'ClienteAcondicionador'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','MotivoRechazo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    MotivoRechazo   [Int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'MotivoRechazo'
end
Go		

declare @esta1 int
exec _AlterTable 'CartasDePorte','FacturarA_Manual', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CartasDePorte ADD
    FacturarA_Manual   [bit] NOT NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CartasDePorte', N'column', N'FacturarA_Manual'
end
Go		



declare @esta1 int
exec _AlterTable 'Viajes','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdUsuarioModifico   [bit]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdUsuarioModifico'
end
Go		

declare @esta1 int
exec _AlterTable 'Viajes','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    FechaModifico   [Datetime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'FechaModifico'
end
Go		

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','CompensacionGastosProveedorCliente', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    CompensacionGastosProveedorCliente   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'CompensacionGastosProveedorCliente'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdComprobanteProveedor_Compensacion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdComprobanteProveedor_Compensacion   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdComprobanteProveedor_Compensacion'
end
Go	

 ALTER TABLE [dbo].[Subcontratos]
    Alter Column [Descripcion] [Varchar] (500) NULL

Go	

 ALTER TABLE [dbo].[Fletes]
    Alter Column [Patente] [Varchar] (10) NULL
Go	

 ALTER TABLE [dbo].[Viajes]
    Alter Column [Patente] [Varchar] (10) NULL
Go
declare @esta1 int
exec _AlterTable 'Viajes','IdUsuarioIngreso', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdUsuarioIngreso   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdUsuarioIngreso'
end
Go	
declare @esta1 int
exec _AlterTable 'Viajes','FechaIngreso', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    FechaIngreso   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'FechaIngreso'
end
Go	





--------------------<< 08/08/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Facturas','CircuitoLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Facturas ADD
    CircuitoLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'Facturas', N'column', N'CircuitoLiquidacionFlete'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','IdLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdLiquidacionFlete'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasDebito','CircuitoLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    CircuitoLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'CircuitoLiquidacionFlete'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','IdLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdLiquidacionFlete'
end
Go	

declare @esta1 int
exec _AlterTable 'NotasCredito','CircuitoLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    CircuitoLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'CircuitoLiquidacionFlete'
end
Go	


declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','CircuitoLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    CircuitoLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'CircuitoLiquidacionFlete'
end
Go	

--------------------<< 09/08/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'DetalleNotasDebito','IdDetalleLiquidacionFlete', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleNotasDebito ADD
    IdDetalleLiquidacionFlete   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'DetalleNotasDebito', N'column', N'IdDetalleLiquidacionFlete'
end
Go	

--------------------<< 12/08/2016 >>----------------------
declare @esta1 int
exec _AlterTable 'Clientes','FechaInicioExclusionPercepcionIVA', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    FechaInicioExclusionPercepcionIVA   [datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaInicioExclusionPercepcionIVA'
end
Go	
declare @esta1 int
exec _AlterTable 'Clientes','FechaFinExclusionPercepcionIVA', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    FechaFinExclusionPercepcionIVA   [datetime] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 08/08/2016', N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaFinExclusionPercepcionIVA'
end
Go	

  ALTER TABLE [dbo].[LogBackups]
    Alter Column [Descripcion] [Varchar] (500) NULL


--------------------<< 31/08/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'Viajes','CartaPortePorArrime', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    CartaPortePorArrime   [Varchar] (15)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'CartaPortePorArrime'
end
Go	


--------------------<< 19/09/2016 >>----------------------
 ALTER TABLE [dbo].[PresupuestoObrasNodosDatos]
    Alter Column [CantidadBase] [numeric] (18,4) NULL

GO
 ALTER TABLE [dbo].[PresupuestoObrasNodosDatos]
    Alter Column [Rendimiento] [numeric] (18,4) NULL

GO
 ALTER TABLE [dbo].[PresupuestoObrasNodosDatos]
    Alter Column [PrecioVentaUnitario] [numeric] (18,4) NULL

GO	

declare @esta1 int
exec _AlterTable 'DetalleRecepciones','IdSituacion', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleRecepciones ADD
    IdSituacion   [int] NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 19/09/2016', N'user', N'dbo', N'table', N'DetalleRecepciones', N'column', N'IdSituacion'
end
Go	
-------------------<< 04/10/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','HabilitarAvanceReal', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    HabilitarAvanceReal   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'HabilitarAvanceReal'
end
Go	

-------------------<< 12/10/2016 >>----------------------
ALTER TABLE [dbo].[Viajes]
Alter Column [Quincena] [Varchar] (20) NULL

-------------------<< 04/10/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'PresupuestoObrasNodos','IdCondicionCompra', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].PresupuestoObrasNodos ADD
    IdCondicionCompra   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'PresupuestoObrasNodos', N'column', N'IdCondicionCompra'
end
Go

-------------------<< 07/11/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'Clientes','CodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    CodigoNormaCapital   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Clientes', N'column', N'CodigoNormaCapital'
end
Go

declare @esta1 int
exec _AlterTable 'Clientes','FechaInicioVigenciaCodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    FechaInicioVigenciaCodigoNormaCapital   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaInicioVigenciaCodigoNormaCapital'
end
Go	


declare @esta1 int
exec _AlterTable 'Clientes','FechaFinVigenciaCodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Clientes ADD
    FechaFinVigenciaCodigoNormaCapital   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Clientes', N'column', N'FechaFinVigenciaCodigoNormaCapital'
end
Go	

declare @esta1 int
exec _AlterTable 'Proveedores','CodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    CodigoNormaCapital   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'CodigoNormaCapital'
end
Go

declare @esta1 int
exec _AlterTable 'Proveedores','FechaInicioVigenciaCodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    FechaInicioVigenciaCodigoNormaCapital   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaInicioVigenciaCodigoNormaCapital'
end
Go	


declare @esta1 int
exec _AlterTable 'Proveedores','FechaFinVigenciaCodigoNormaCapital', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    FechaFinVigenciaCodigoNormaCapital   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'FechaFinVigenciaCodigoNormaCapital'
end
Go	

ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto1] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto2] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto3] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto4] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto5] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto6] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto7] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto8] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto9] [Varchar] (200) NULL
ALTER TABLE [dbo].[DetallePresupuestos]
Alter Column [ArchivoAdjunto10] [Varchar] (200) NULL

-------------------<< 07/11/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'OrdenesPago','DocumentacionCompleta', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    DocumentacionCompleta   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'DocumentacionCompleta'
end
Go
-------------------<< 22/11/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'Viajes','IdTarifaSeguro', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdTarifaSeguro   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdTarifaSeguro'
end
Go

declare @esta1 int
exec _AlterTable 'Viajes','Estado', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    Estado   [Varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'Estado'
end
Go

declare @esta1 int
exec _AlterTable 'TarifasFletes','ComisionAsociada', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TarifasFletes ADD
    ComisionAsociada   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'TarifasFletes', N'column', N'ComisionAsociada'
end
Go

declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','AcumularParaSUSS', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    AcumularParaSUSS   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'AcumularParaSUSS'
end
Go

-------------------<< 06/12/2016 >>----------------------

declare @esta1 int
exec _AlterTable 'IBcondiciones','CodigoRegimen', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBcondiciones ADD
    CodigoRegimen   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'IBcondiciones', N'column', N'CodigoRegimen'
end
Go

-------------------<< 11/01/2017 >>----------------------

declare @esta1 int
exec _AlterTable 'Proveedores','IdObraDefault', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    IdObraDefault   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdObraDefault'
end
Go
-------------------<< 24/01/2017 >>----------------------

declare @esta1 int
exec _AlterTable 'Viajes','IdOrigenTransmision', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdOrigenTransmision   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdOrigenTransmision'
end
Go
-------------------<< 06/02/2017 >>----------------------

declare @esta1 int
exec _AlterTable 'Proveedores','RegimenSimplificadoIIBB', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    RegimenSimplificadoIIBB   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'RegimenSimplificadoIIBB'
end
Go
-------------------<< 14/03/2017 >>----------------------

declare @esta1 int
exec _AlterTable 'Remitos','NumeroCAI', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Remitos ADD
    NumeroCAI   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Remitos', N'column', N'NumeroCAI'
end
Go

declare @esta1 int
exec _AlterTable 'Remitos','FechaVencimientoCAI', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Remitos ADD
    FechaVencimientoCAI   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Remitos', N'column', N'FechaVencimientoCAI'
end
Go	

-------------------<< 21/03/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'TiposComprobante','IdUsuarioModifico', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    IdUsuarioModifico   [int]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'IdUsuarioModifico'
end
Go	

declare @esta1 int
exec _AlterTable 'TiposComprobante','FechaModifico', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].TiposComprobante ADD
    FechaModifico   [DateTime]  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'TiposComprobante', N'column', N'FechaModifico'
end
Go	

-------------------<< 03/04/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'Obras','AnticipoFinancieroPorcentual', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    AnticipoFinancieroPorcentual   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Obras', N'column', N'AnticipoFinancieroPorcentual'
end
Go
declare @esta1 int
exec _AlterTable 'Obras','FondoReparoPorcentual', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    FondoReparoPorcentual   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Obras', N'column', N'FondoReparoPorcentual'
end
Go
declare @esta1 int
exec _AlterTable 'Obras','PlazoCobroDias', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    PlazoCobroDias   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Obras', N'column', N'PlazoCobroDias'
end
Go
declare @esta1 int
exec _AlterTable 'Proveedores','IdIBCondicionAnterior', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    IdIBCondicionAnterior   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Proveedores', N'column', N'IdIBCondicionAnterior'
end
Go

-------------------<< 27/04/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'Viajes','IdDetalleClienteSucursal', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    IdDetalleClienteSucursal   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'IdDetalleClienteSucursal'
end
Go
declare @esta1 int
exec _AlterTable 'CertificacionesObrasDatos','PorcentajeAnticipoFinanciero', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CertificacionesObrasDatos ADD
    PorcentajeAnticipoFinanciero   [numeric] (6,2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CertificacionesObrasDatos', N'column', N'PorcentajeAnticipoFinanciero'
end
Go

-------------------<< 02/05/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'Pedidos','BloqueadoFirma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    BloqueadoFirma   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Pedidos', N'column', N'BloqueadoFirma'
end
Go
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','BloqueadoFirma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    BloqueadoFirma   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'BloqueadoFirma'
end
Go

declare @esta1 int
exec _AlterTable 'Pedidos','IdUsuarioBloqueo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Pedidos ADD
    IdUsuarioBloqueo   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Pedidos', N'column', N'IdUsuarioBloqueo'
end
Go
declare @esta1 int
exec _AlterTable 'ComprobantesProveedores','IdUsuarioBloqueo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ComprobantesProveedores ADD
    IdUsuarioBloqueo   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'ComprobantesProveedores', N'column', N'IdUsuarioBloqueo'
end
Go

-------------------<< 04/05/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'CertificacionesObrasDatos','EsAnticipo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].CertificacionesObrasDatos ADD
    EsAnticipo   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'CertificacionesObrasDatos', N'column', N'EsAnticipo'
end
Go


-------------------<< 24/05/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'Obras','CantidadEstimadaCertificados', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Obras ADD
    CantidadEstimadaCertificados   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Obras', N'column', N'CantidadEstimadaCertificados'
end
Go

-------------------<< 05/06/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'NotasCredito','IdViajeAsociado', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdViajeAsociado   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdViajeAsociado'
end
Go
-------------------<< 21/06/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'Viajes','EstadoImagenes', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Viajes ADD
    EstadoImagenes   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'Viajes', N'column', N'EstadoImagenes'
end
Go
-------------------<< 17/07/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'NotasCredito','NumeroProyecto', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    NumeroProyecto   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'NumeroProyecto'
end
Go
declare @esta1 int
exec _AlterTable 'NotasCredito','IdCertificacionObras', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdCertificacionObras   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdCertificacionObras'
end
Go
declare @esta1 int
exec _AlterTable 'NotasCredito','IdCertificacionObraDatos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasCredito ADD
    IdCertificacionObraDatos   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasCredito', N'column', N'IdCertificacionObraDatos'
end
Go

declare @esta1 int
exec _AlterTable 'NotasDebito','NumeroProyecto', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    NumeroProyecto   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'NumeroProyecto'
end
Go
declare @esta1 int
exec _AlterTable 'NotasDebito','IdCertificacionObras', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdCertificacionObras   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdCertificacionObras'
end
Go
declare @esta1 int
exec _AlterTable 'NotasDebito','IdCertificacionObraDatos', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].NotasDebito ADD
    IdCertificacionObraDatos   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'NotasDebito', N'column', N'IdCertificacionObraDatos'
end
Go
-------------------<< 19/07/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'OrdenesPago','FechaTimeStamp', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].OrdenesPago ADD
    FechaTimeStamp   [timestamp]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 30/07/14', N'user', N'dbo', N'table', N'OrdenesPago', N'column', N'FechaTimeStamp'
end
Go

-------------------<< 20/07/2017 >>----------------------
declare @esta1 int
exec _AlterTable 'IBCondiciones','AlicuotaParaRiesgoFiscal', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].IBCondiciones ADD
    AlicuotaParaRiesgoFiscal   [numeric] (8,3)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'IBCondiciones', N'column', N'AlicuotaParaRiesgoFiscal'
end
Go

declare @esta1 int
exec _AlterTable 'DetalleProveedoresIB','AlicuotaParaRiesgoFiscal', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].DetalleProveedoresIB ADD
    AlicuotaParaRiesgoFiscal   [numeric] (8,3)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'DetalleProveedoresIB', N'column', N'AlicuotaParaRiesgoFiscal'
end
Go

declare @esta1 int
exec _AlterTable 'Proveedores','RiesgoFiscal', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Proveedores ADD
    RiesgoFiscal   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'Proveedores', N'column', N'RiesgoFiscal'
end
Go

declare @esta1 int
exec _AlterTable 'BancoChequeras','ChequeraSinUso', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].BancoChequeras ADD
    ChequeraSinUso   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'BancoChequeras', N'column', N'ChequeraSinUso'
end
Go

declare @esta1 int
exec _AlterTable 'Empleados','AdministradorSistema', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    AdministradorSistema   [varchar] (2)  NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'Empleados', N'column', N'AdministradorSistema'
end
Go


declare @esta1 int
exec _AlterTable 'Empleados','FechaVencimientoSuplenciaFirma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    FechaVencimientoSuplenciaFirma   [Datetime]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'Empleados', N'column', N'FechaVencimientoSuplenciaFirma'
end
Go

declare @esta1 int
exec _AlterTable 'Empleados','IdSuplenteFirma', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].Empleados ADD
    IdSuplenteFirma   [int]   NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 20/07/17', N'user', N'dbo', N'table', N'Empleados', N'column', N'IdSuplenteFirma'
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

alter table _TempPresupuestoObrasNodosPxQxPresupuesto
alter column Certificado numeric(18,4)
GO

alter table PresupuestoObrasNodosPxQxPresupuesto
alter column Certificado numeric(18,4)
GO

alter table OrdenesPago
alter column CuitOpcional varchar(13)
GO


alter table Valores
alter column Importe numeric(18,4)
GO


alter table Pedidos
 Alter Column [ArchivoAdjunto1] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto2] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto3] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto4] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto5] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto6] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto7] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto8] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto9] [varchar] (200) NULL
GO
alter table Pedidos
 Alter Column [ArchivoAdjunto10] [varchar] (200) NULL
GO

alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto1] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto2] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto3] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto4] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto5] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto6] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto7] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto8] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto9] [varchar] (200) NULL
GO
alter table DetalleRequerimientos
 Alter Column [ArchivoAdjunto10] [varchar] (200) NULL
GO

alter table DetallePedidos
 Alter Column [ArchivoAdjunto1] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto2] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto3] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto4] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto5] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto6] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto7] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto8] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto9] [varchar] (200) NULL
GO
alter table DetallePedidos
 Alter Column [ArchivoAdjunto10] [varchar] (200) NULL
GO


 ALTER TABLE [dbo].[Remitos]
    Alter Column [NumeroCAI] [numeric] (19,0) NULL
GO
     ALTER TABLE [dbo].[ComprobantesProveedores]
    Alter Column [IdUsuarioBloqueo] [int] NULL
GO
     ALTER TABLE [dbo].[Pedidos]
    Alter Column [IdUsuarioBloqueo] [int] NULL

GO

--Aca Encontre un problema en una de las bases de datos y con eso se eliminan los campos que sobran

declare @esta1 int
exec _AlterTable 'Subdiarios','Replicador_Insert', @esta = @esta1 output
if @esta1 = 1
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE Subdiarios DROP COLUMN [Replicador_Insert]
end
Go

declare @esta1 int
exec _AlterTable 'Subdiarios','Replicador_Update', @esta = @esta1 output
if @esta1 = 1
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE Subdiarios DROP COLUMN [Replicador_Update]
end
Go




declare @esta1 int
exec _AlterTable 'ColaCorreosComprobantes','IdColaCorreoComprobante', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].ColaCorreosComprobantes ADD
      IdColaCorreoComprobante INT IDENTITY(1,1)
 ALTER TABLE dbo.ColaCorreosComprobantes 
    ADD CONSTRAINT PK_ColaCorreosComprobantes
    PRIMARY KEY CLUSTERED (IdColaCorreoComprobante)

end
Go

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
Where Descripcionab ='CP' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='FC' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro = 'NO', VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='CI' and VaAlLibro <> 'NO' and VaAlRegistroComprasAFIP <> 'NO'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='DP' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro ='NO'	, VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='DI' and VaAlLibro <> 'NO' and VaAlRegistroComprasAFIP <> 'NO'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='DBG' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='CB' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro ='NO'	, VaAlRegistroComprasAFIP ='NO'
Where Descripcionab ='DFF' and VaAlLibro <> 'NO' and VaAlRegistroComprasAFIP <> 'NO'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='Tik' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'

update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='RP' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'
/*
update TiposComprobante
set	VaAlLibro = NULL, VaAlRegistroComprasAFIP ='SI'
Where Descripcionab ='OT' and VaAlLibro is not null and VaAlRegistroComprasAFIP <> 'SI'
GO
*/
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
Update Parametros2
set Valor = 0
where campo like '%PorcentajeToleranciaOrdenesCompra%' and Valor is null
GO
Update Parametros2
set Valor = 0
where Campo Like '%CantidadToleranciaOrdenesCompra%' and Valor is null
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
	   


/*
Se corre este SQL que actualiza Notas de Debito y Credito viejas, poniendo la alícuota en 0 en el detalle en los conceptos que están en NO
05-10-2015 (Consulta 15066)
*/


update DetalleNotasDebito
set PorcentajeIva=0
where Gravado='NO'
and PorcentajeIva is null

update DetalleNotasCredito
set PorcentajeIva=0
where Gravado='NO'
and PorcentajeIva is null


update DetalleNotasDebito
set PorcentajeIva=Null
where DetalleNotasDebito.PorcentajeIva is not null and Exists(Select Top 1 dnd.IdNotaDebito From DetalleNotasDebito dnd where dnd.IdNotaDebito=DetalleNotasDebito.IdNotaDebito and dnd.PorcentajeIva is null)

update DetalleNotasCredito
set PorcentajeIva=Null
where DetalleNotasCredito.PorcentajeIva is not null and Exists(Select Top 1 dnc.IdNotaCredito From DetalleNotasCredito dnc where dnc.IdNotaCredito=DetalleNotasCredito.IdNotaCredito and dnc.PorcentajeIva is null)





/* PARA NORMALIZAR LA CONTRASEÑA NUESTRA EN TODOS LADOS, PONEMOS TODAS EN .SistemaPronto. */

update Empleados
set Password = '.SistemaPronto.'
where UsuarioNT in ('bdl','bdl_1','bdl_2','bdl1','bdl2','pronto')


/* BDL SOPORTE  18/08/2016*/

declare @esta1 int
exec _AlterTable 'BdlSoporte','PathBackup', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].BdlSoporte ADD
    PathBackup   varchar(50) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/08/2016', N'user', N'dbo', N'table', N'BdlSoporte', N'column', N'PathBackup'
end
Go	


declare @esta1 int
exec _AlterTable 'LogBackups','Archivo', @esta = @esta1 output
if @esta1 = 0
begin
--select @esta1 as Existe_Si_1_NO_0
  ALTER TABLE [dbo].LogBackups ADD
    Archivo   varchar(100) NULL
   exec sp_addextendedproperty N'MS_Description', N'Campo Agregado el dia 18/08/2016', N'user', N'dbo', N'table', N'LogBackups', N'column', N'Archivo'
end
Go	

alter table LogBackups
 Alter Column Descripcion [varchar] (500) NULL
GO

