CREATE TABLE [dbo].[DetalleNotasCreditoProvincias] (
    [IdDetalleNotaCreditoProvincias] INT            IDENTITY (1, 1) NOT NULL,
    [IdNotaCredito]                  INT            NULL,
    [IdProvinciaDestino]             INT            NULL,
    [Porcentaje]                     NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleNotasCreditoProvincias] PRIMARY KEY CLUSTERED ([IdDetalleNotaCreditoProvincias] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasCreditoProvincias_NotasCredito] FOREIGN KEY ([IdNotaCredito]) REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
);

