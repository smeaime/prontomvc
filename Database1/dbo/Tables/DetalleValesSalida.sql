CREATE TABLE [dbo].[DetalleValesSalida] (
    [IdDetalleValeSalida]         INT             IDENTITY (1, 1) NOT NULL,
    [IdValeSalida]                INT             NULL,
    [IdArticulo]                  INT             NULL,
    [IdStock]                     INT             NULL,
    [Partida]                     VARCHAR (20)    NULL,
    [Cantidad]                    DECIMAL (18, 2) NULL,
    [CantidadAdicional]           DECIMAL (18, 2) NULL,
    [IdUnidad]                    INT             NULL,
    [Cantidad1]                   DECIMAL (18, 2) NULL,
    [Cantidad2]                   DECIMAL (18, 2) NULL,
    [IdDetalleReserva]            INT             NULL,
    [IdDetalleLMateriales]        INT             NULL,
    [Estado]                      VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCentroCosto]               INT             NULL,
    [Cumplido]                    VARCHAR (2)     NULL,
    [EnviarEmail]                 TINYINT         NULL,
    [IdDetalleValeSalidaOriginal] INT             NULL,
    [IdValeSalidaOriginal]        INT             NULL,
    [IdOrigenTransmision]         INT             NULL,
    [IdEquipoDestino]             INT             NULL,
    [IdDetalleSolicitudEntrega]   INT             NULL,
    [IdDetalleRequerimiento]      INT             NULL,
    CONSTRAINT [PK_DetalleValesSalida] PRIMARY KEY CLUSTERED ([IdDetalleValeSalida] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleValesSalida_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleValesSalida_DetalleRequerimientos] FOREIGN KEY ([IdDetalleRequerimiento]) REFERENCES [dbo].[DetalleRequerimientos] ([IdDetalleRequerimiento]),
    CONSTRAINT [FK_DetalleValesSalida_ValesSalida] FOREIGN KEY ([IdValeSalida]) REFERENCES [dbo].[ValesSalida] ([IdValeSalida])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleValesSalida]([IdValeSalida] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleValesSalida]([IdDetalleRequerimiento] ASC) WITH (FILLFACTOR = 90);

