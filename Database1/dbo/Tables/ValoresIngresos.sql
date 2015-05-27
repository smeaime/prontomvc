CREATE TABLE [dbo].[ValoresIngresos] (
    [IdValorIngreso] INT             IDENTITY (1, 1) NOT NULL,
    [FechaIngreso]   DATETIME        NULL,
    [IdBanco]        INT             NULL,
    [Observaciones]  NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Importe]        NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_ValoresIngresos] PRIMARY KEY CLUSTERED ([IdValorIngreso] ASC) WITH (FILLFACTOR = 90)
);

