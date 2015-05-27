CREATE TABLE [dbo].[ProduccionPlanes] (
    [IdProduccionPlan]    INT             IDENTITY (1, 1) NOT NULL,
    [Fecha]               DATETIME        NULL,
    [Documento]           VARCHAR (30)    NULL,
    [Cliente]             VARCHAR (30)    NULL,
    [Cantidad]            NUMERIC (18, 2) NULL,
    [StockInicial]        NUMERIC (18, 2) NULL,
    [AConsumir]           NUMERIC (18, 2) NULL,
    [IngresosPrevistos]   NUMERIC (18, 2) NULL,
    [StockFinal]          NUMERIC (18, 2) NULL,
    [PedidosPrevistos]    NUMERIC (18, 2) NULL,
    [OPPrevista]          INT             NULL,
    [PlanMaestro]         INT             NULL,
    [idArticuloProducido] INT             NULL,
    [idArticuloMaterial]  INT             NULL,
    [GrillaSerializada]   VARCHAR (2000)  NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionPlan] ASC) WITH (FILLFACTOR = 90)
);

