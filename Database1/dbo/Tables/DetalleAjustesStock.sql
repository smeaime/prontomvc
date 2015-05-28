CREATE TABLE [dbo].[DetalleAjustesStock] (
    [IdDetalleAjusteStock]         INT             IDENTITY (1, 1) NOT NULL,
    [IdAjusteStock]                INT             NULL,
    [IdArticulo]                   INT             NULL,
    [Partida]                      VARCHAR (20)    NULL,
    [CantidadUnidades]             DECIMAL (18, 2) NULL,
    [CantidadAdicional]            DECIMAL (18, 2) NULL,
    [IdUnidad]                     INT             NULL,
    [Cantidad1]                    DECIMAL (18, 2) NULL,
    [Cantidad2]                    DECIMAL (18, 2) NULL,
    [Observaciones]                NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdUbicacion]                  INT             NULL,
    [IdObra]                       INT             NULL,
    [EnviarEmail]                  TINYINT         NULL,
    [IdDetalleAjusteStockOriginal] INT             NULL,
    [IdAjusteStockOriginal]        INT             NULL,
    [IdOrigenTransmision]          INT             NULL,
    [IdDetalleSalidaMateriales]    INT             NULL,
    [NumeroCaja]                   INT             NULL,
    [Talle]                        VARCHAR (2)     NULL,
    [IdColor]                      INT             NULL,
    [CantidadInventariada]         NUMERIC (18, 2) NULL,
    [IdDetalleValeSalida]          INT             NULL,
    CONSTRAINT [PK_DetalleAjustesStock] PRIMARY KEY CLUSTERED ([IdDetalleAjusteStock] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleAjustesStock_AjustesStock] FOREIGN KEY ([IdAjusteStock]) REFERENCES [dbo].[AjustesStock] ([IdAjusteStock])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleAjustesStock]([IdAjusteStock] ASC) WITH (FILLFACTOR = 90);

