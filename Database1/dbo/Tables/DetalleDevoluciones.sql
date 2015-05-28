CREATE TABLE [dbo].[DetalleDevoluciones] (
    [IdDetalleDevolucion]       INT             IDENTITY (1, 1) NOT NULL,
    [IdDevolucion]              INT             NULL,
    [NumeroDevolucion]          INT             NULL,
    [TipoABC]                   VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PuntoVenta]                INT             NULL,
    [IdArticulo]                INT             NULL,
    [CodigoArticulo]            VARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cantidad]                  NUMERIC (18, 3) NULL,
    [Partida]                   VARCHAR (20)    NULL,
    [Costo]                     NUMERIC (19, 8) NULL,
    [PrecioUnitario]            NUMERIC (19, 8) NULL,
    [Bonificacion]              NUMERIC (6, 2)  NULL,
    [IdUnidad]                  INT             NULL,
    [OrigenDescripcion]         INT             NULL,
    [Observaciones]             NTEXT           NULL,
    [PorcentajeCertificacion]   NUMERIC (6, 2)  NULL,
    [IdUbicacion]               INT             NULL,
    [IdObra]                    INT             NULL,
    [NumeroCaja]                INT             NULL,
    [IdDetalleFactura]          INT             NULL,
    [Talle]                     VARCHAR (2)     NULL,
    [IdColor]                   INT             NULL,
    [IdDetallePresupuestoVenta] INT             NULL,
    CONSTRAINT [PK_DetalleDevoluciones] PRIMARY KEY NONCLUSTERED ([IdDetalleDevolucion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleDevoluciones_Devoluciones] FOREIGN KEY ([IdDevolucion]) REFERENCES [dbo].[Devoluciones] ([IdDevolucion])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleDevoluciones]([IdDevolucion] ASC, [IdDetalleDevolucion] ASC) WITH (FILLFACTOR = 90);

