CREATE TABLE [dbo].[AjustesStockSAT] (
    [IdAjusteStock]               INT         IDENTITY (1, 1) NOT NULL,
    [NumeroAjusteStock]           INT         NULL,
    [FechaAjuste]                 DATETIME    NULL,
    [Observaciones]               NTEXT       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdRealizo]                   INT         NULL,
    [FechaRegistro]               DATETIME    NULL,
    [IdAprobo]                    INT         NULL,
    [NumeroMarbete]               INT         NULL,
    [TipoAjuste]                  VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                 TINYINT     NULL,
    [IdAjusteStockOriginal]       INT         NULL,
    [IdOrigenTransmision]         INT         NULL,
    [FechaImportacionTransmision] DATETIME    NULL,
    CONSTRAINT [PK_AjustesStockSAT] PRIMARY KEY CLUSTERED ([IdAjusteStock] ASC) WITH (FILLFACTOR = 90)
);

