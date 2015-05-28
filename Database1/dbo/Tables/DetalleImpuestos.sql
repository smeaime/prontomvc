CREATE TABLE [dbo].[DetalleImpuestos] (
    [IdDetalleImpuesto] INT             IDENTITY (1, 1) NOT NULL,
    [IdImpuesto]        INT             NULL,
    [Año]               INT             NULL,
    [Cuota]             INT             NULL,
    [Importe]           NUMERIC (18, 2) NULL,
    [FechaVencimiento1] DATETIME        NULL,
    [FechaVencimiento2] DATETIME        NULL,
    [FechaVencimiento3] DATETIME        NULL,
    [Intereses1]        NUMERIC (18, 2) NULL,
    [Intereses2]        NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleImpuestos] PRIMARY KEY CLUSTERED ([IdDetalleImpuesto] ASC) WITH (FILLFACTOR = 90)
);

