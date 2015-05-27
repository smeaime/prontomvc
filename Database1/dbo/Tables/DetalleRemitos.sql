﻿CREATE TABLE [dbo].[DetalleRemitos] (
    [IdDetalleRemito]         INT             IDENTITY (1, 1) NOT NULL,
    [IdRemito]                INT             NULL,
    [NumeroItem]              INT             NULL,
    [Cantidad]                NUMERIC (18, 3) NULL,
    [IdUnidad]                INT             NULL,
    [IdArticulo]              INT             NULL,
    [Precio]                  NUMERIC (18, 2) NULL,
    [Observaciones]           NTEXT           NULL,
    [PorcentajeCertificacion] NUMERIC (6, 2)  NULL,
    [OrigenDescripcion]       INT             NULL,
    [IdDetalleOrdenCompra]    INT             NULL,
    [TipoCancelacion]         INT             NULL,
    [IdUbicacion]             INT             NULL,
    [IdObra]                  INT             NULL,
    [Partida]                 VARCHAR (20)    NULL,
    [DescargaPorKit]          VARCHAR (2)     NULL,
    [NumeroCaja]              INT             NULL,
    [Talle]                   VARCHAR (2)     NULL,
    [IdColor]                 INT             NULL,
    CONSTRAINT [PK_DetalleRemitos] PRIMARY KEY CLUSTERED ([IdDetalleRemito] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRemitos_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleRemitos_DetalleOrdenesCompra] FOREIGN KEY ([IdDetalleOrdenCompra]) REFERENCES [dbo].[DetalleOrdenesCompra] ([IdDetalleOrdenCompra]),
    CONSTRAINT [FK_DetalleRemitos_Obras] FOREIGN KEY ([IdObra]) REFERENCES [dbo].[Obras] ([IdObra]),
    CONSTRAINT [FK_DetalleRemitos_Remitos] FOREIGN KEY ([IdRemito]) REFERENCES [dbo].[Remitos] ([IdRemito])
);

