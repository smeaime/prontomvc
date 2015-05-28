CREATE TABLE [dbo].[DetallePresupuestosVentas] (
    [IdDetallePresupuestoVenta] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoVenta]        INT             NULL,
    [IdArticulo]                INT             NULL,
    [Cantidad]                  NUMERIC (18, 2) NULL,
    [PrecioUnitario]            NUMERIC (19, 8) NULL,
    [Bonificacion]              NUMERIC (6, 2)  NULL,
    [IdUnidad]                  INT             NULL,
    [Talle]                     VARCHAR (2)     NULL,
    [IdColor]                   INT             NULL,
    [Estado]                    VARCHAR (1)     NULL,
    CONSTRAINT [PK_DetallePresupuestosVentas] PRIMARY KEY CLUSTERED ([IdDetallePresupuestoVenta] ASC) WITH (FILLFACTOR = 90)
);

