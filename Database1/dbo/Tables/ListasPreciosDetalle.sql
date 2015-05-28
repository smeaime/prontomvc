﻿CREATE TABLE [dbo].[ListasPreciosDetalle] (
    [IdListaPreciosDetalle]            INT             IDENTITY (1, 1) NOT NULL,
    [IdListaPrecios]                   INT             NULL,
    [IdArticulo]                       INT             NULL,
    [Precio]                           NUMERIC (18, 2) NULL,
    [IdDestinoDeCartaDePorte]          INT             NULL,
    [PrecioDescargaLocal]              MONEY           NULL,
    [PrecioDescargaExportacion]        MONEY           NULL,
    [PrecioCaladaLocal]                MONEY           NULL,
    [PrecioCaladaExportacion]          MONEY           NULL,
    [PrecioRepetidoPeroConPrecision]   MONEY           NULL,
    [IdCliente]                        INT             NULL,
    [Precio2]                          NUMERIC (18, 2) NULL,
    [Precio3]                          NUMERIC (18, 2) NULL,
    [FechaVigenciaHasta]               DATETIME        NULL,
    [Precio4]                          NUMERIC (18, 2) NULL,
    [Precio5]                          NUMERIC (18, 2) NULL,
    [Precio6]                          NUMERIC (18, 2) NULL,
    [PrecioExportacion]                MONEY           NULL,
    [PrecioEmbarque]                   MONEY           NULL,
    [Precio7]                          NUMERIC (18, 2) NULL,
    [Precio8]                          NUMERIC (18, 2) NULL,
    [Precio9]                          NUMERIC (18, 2) NULL,
    [PrecioEmbarque2]                  MONEY           NULL,
    [MaximaCantidadParaPrecioEmbarque] NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleListasPrecios] PRIMARY KEY CLUSTERED ([IdListaPreciosDetalle] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ListasPreciosDetalle_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_ListasPreciosDetalle_ListasPrecios] FOREIGN KEY ([IdListaPrecios]) REFERENCES [dbo].[ListasPrecios] ([IdListaPrecios])
);

