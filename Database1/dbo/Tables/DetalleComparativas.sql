CREATE TABLE [dbo].[DetalleComparativas] (
    [IdDetalleComparativa]   INT             IDENTITY (1, 1) NOT NULL,
    [IdComparativa]          INT             NULL,
    [IdPresupuesto]          INT             NULL,
    [NumeroPresupuesto]      INT             NULL,
    [FechaPresupuesto]       DATETIME        NULL,
    [IdArticulo]             INT             NULL,
    [Cantidad]               NUMERIC (18, 2) NULL,
    [Precio]                 NUMERIC (18, 4) NULL,
    [Estado]                 VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SubNumero]              INT             NULL,
    [Observaciones]          NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdUnidad]               INT             NULL,
    [IdMoneda]               INT             NULL,
    [OrigenDescripcion]      INT             NULL,
    [PorcentajeBonificacion] NUMERIC (6, 2)  NULL,
    [CotizacionMoneda]       NUMERIC (18, 3) NULL,
    [IdDetallePresupuesto]   INT             NULL,
    CONSTRAINT [PK_DetalleComparativas] PRIMARY KEY CLUSTERED ([IdDetalleComparativa] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleComparativas_Articulo] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleComparativas_Unidad] FOREIGN KEY ([IdUnidad]) REFERENCES [dbo].[Unidades] ([IdUnidad])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleComparativas]([IdComparativa] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleComparativas]([IdDetallePresupuesto] ASC) WITH (FILLFACTOR = 90);

