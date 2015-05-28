CREATE TABLE [dbo].[DetalleNotasDebitoProvincias] (
    [IdDetalleNotaDebitoProvincias] INT            IDENTITY (1, 1) NOT NULL,
    [IdNotaDebito]                  INT            NULL,
    [IdProvinciaDestino]            INT            NULL,
    [Porcentaje]                    NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleNotasDebitoProvincias] PRIMARY KEY CLUSTERED ([IdDetalleNotaDebitoProvincias] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasDebitoProvincias_NotasDebito] FOREIGN KEY ([IdNotaDebito]) REFERENCES [dbo].[NotasDebito] ([IdNotaDebito])
);

