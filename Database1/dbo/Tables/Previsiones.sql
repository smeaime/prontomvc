CREATE TABLE [dbo].[Previsiones] (
    [IdPrevision]             INT             IDENTITY (1, 1) NOT NULL,
    [Numero]                  INT             NULL,
    [Fecha]                   DATETIME        NULL,
    [IdRubroFinanciero]       INT             NULL,
    [IdBanco]                 INT             NULL,
    [Observaciones]           NTEXT           NULL,
    [FechaCaducidad]          DATETIME        NULL,
    [Importe]                 NUMERIC (18, 2) NULL,
    [IdUsuarioIngreso]        INT             NULL,
    [FechaIngreso]            DATETIME        NULL,
    [IdUsuarioModifico]       INT             NULL,
    [FechaModifico]           DATETIME        NULL,
    [TipoMovimiento]          VARCHAR (1)     NULL,
    [IdObra]                  INT             NULL,
    [PostergarFechaCaducidad] VARCHAR (2)     NULL,
    CONSTRAINT [PK_Previsiones] PRIMARY KEY CLUSTERED ([IdPrevision] ASC) WITH (FILLFACTOR = 90)
);

