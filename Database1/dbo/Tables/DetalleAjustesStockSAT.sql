CREATE TABLE [dbo].[DetalleAjustesStockSAT] (
    [IdDetalleAjusteStock]         INT             IDENTITY (1, 1) NOT NULL,
    [IdAjusteStock]                INT             NULL,
    [IdArticulo]                   INT             NULL,
    [Partida]                      INT             NULL,
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
    CONSTRAINT [PK_DetalleAjustesStockSAT] PRIMARY KEY CLUSTERED ([IdDetalleAjusteStock] ASC) WITH (FILLFACTOR = 90)
);

