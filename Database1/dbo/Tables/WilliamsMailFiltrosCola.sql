CREATE TABLE [dbo].[WilliamsMailFiltrosCola] (
    [IdWilliamsMailFiltroCola] INT           IDENTITY (1, 1) NOT NULL,
    [IdWilliamsMailFiltro]     INT           NOT NULL,
    [Descripcion]              VARCHAR (50)  NULL,
    [Emails]                   VARCHAR (250) NULL,
    [FechaDesde]               DATETIME      NULL,
    [FechaHasta]               DATETIME      NULL,
    [EsPosicion]               VARCHAR (6)   NULL,
    [Enviar]                   VARCHAR (6)   NULL,
    [EsMailOesFax]             VARCHAR (6)   NULL,
    [Orden]                    INT           NULL,
    [Modo]                     VARCHAR (8)   NULL,
    [AplicarANDuORalFiltro]    VARCHAR (6)   NULL,
    [Vendedor]                 INT           NULL,
    [CuentaOrden1]             INT           NULL,
    [CuentaOrden2]             INT           NULL,
    [Corredor]                 INT           NULL,
    [Entregador]               INT           NULL,
    [IdArticulo]               INT           NULL,
    [Contrato]                 INT           NULL,
    [Destino]                  INT           NULL,
    [Procedencia]              INT           NULL,
    [AuxiliarString1]          VARCHAR (50)  NULL,
    [AuxiliarString2]          VARCHAR (50)  NULL,
    [UltimoResultado]          VARCHAR (100) NULL,
    [PuntoVenta]               INT           NULL,
    [QueContenga]              VARCHAR (100) NULL,
    [EstadoDeCartaPorte]       VARCHAR (20)  NULL,
    [IdUsuarioEncolo]          INT           NULL,
    [AgrupadorDeTandaPeriodos] INT           NULL,
    [ModoImpresion]            VARCHAR (6)   NULL,
    [Corredor2]                INT           NULL,
    PRIMARY KEY CLUSTERED ([IdWilliamsMailFiltroCola] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_WilliamsMailFiltrosCola_UltimoResultado]
    ON [dbo].[WilliamsMailFiltrosCola]([UltimoResultado] ASC, [AgrupadorDeTandaPeriodos] ASC);

