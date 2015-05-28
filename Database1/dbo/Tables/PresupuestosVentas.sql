CREATE TABLE [dbo].[PresupuestosVentas] (
    [IdPresupuestoVenta]           INT             IDENTITY (1, 1) NOT NULL,
    [Numero]                       INT             NULL,
    [IdCliente]                    INT             NULL,
    [Fecha]                        DATETIME        NULL,
    [IdCondicionVenta]             SMALLINT        NULL,
    [IdVendedor]                   INT             NULL,
    [Observaciones]                NTEXT           NULL,
    [Estado]                       VARCHAR (1)     NULL,
    [TipoVenta]                    INT             NULL,
    [TipoOperacion]                VARCHAR (1)     NULL,
    [ImporteTotal]                 NUMERIC (18, 2) NULL,
    [PorcentajeBonificacion]       NUMERIC (6, 2)  NULL,
    [TotalBultos]                  INT             NULL,
    [IdDetalleClienteLugarEntrega] INT             NULL,
    CONSTRAINT [PK_PresupuestosVentas] PRIMARY KEY CLUSTERED ([IdPresupuestoVenta] ASC) WITH (FILLFACTOR = 90)
);

