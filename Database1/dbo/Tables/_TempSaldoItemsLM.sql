CREATE TABLE [dbo].[_TempSaldoItemsLM] (
    [IdDetalleLMateriales] INT             NULL,
    [IdLMateriales]        INT             NULL,
    [Nombre]               VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroLMateriales]    INT             NULL,
    [Tag]                  VARCHAR (40)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroItem]           INT             NULL,
    [Fecha]                DATETIME        NULL,
    [IdArticulo]           INT             NULL,
    [Cantidad]             NUMERIC (18, 2) NULL,
    [Cantidad1]            NUMERIC (18, 2) NULL,
    [Cantidad2]            NUMERIC (18, 2) NULL,
    [LA]                   NUMERIC (18, 2) NULL,
    [RM]                   NUMERIC (18, 2) NULL,
    [RS]                   NUMERIC (18, 2) NULL,
    [StockDisponible]      NUMERIC (18, 2) NULL,
    [StockEnOtrasObras]    NUMERIC (18, 2) NULL,
    [Observaciones]        NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);

