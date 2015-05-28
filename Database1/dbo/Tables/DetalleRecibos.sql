CREATE TABLE [dbo].[DetalleRecibos] (
    [IdDetalleRecibo]             INT             IDENTITY (1, 1) NOT NULL,
    [IdRecibo]                    INT             NULL,
    [IdImputacion]                INT             NULL,
    [Importe]                     NUMERIC (19, 2) NULL,
    [SaldoParteEnDolaresAnterior] NUMERIC (18, 2) NULL,
    [PagadoParteEnDolares]        NUMERIC (18, 2) NULL,
    [NuevoSaldoParteEnDolares]    NUMERIC (18, 2) NULL,
    [SaldoParteEnPesosAnterior]   NUMERIC (18, 2) NULL,
    [PagadoParteEnPesos]          NUMERIC (18, 2) NULL,
    [NuevoSaldoParteEnPesos]      NUMERIC (18, 2) NULL,
    [EnviarEmail]                 TINYINT         NULL,
    [IdOrigenTransmision]         INT             NULL,
    [IdReciboOriginal]            INT             NULL,
    [IdDetalleReciboOriginal]     INT             NULL,
    [FechaImportacionTransmision] DATETIME        NULL,
    CONSTRAINT [PK_DetalleRecibos] PRIMARY KEY NONCLUSTERED ([IdDetalleRecibo] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRecibos_Recibos] FOREIGN KEY ([IdRecibo]) REFERENCES [dbo].[Recibos] ([IdRecibo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRecibos]([IdRecibo] ASC, [IdDetalleRecibo] ASC) WITH (FILLFACTOR = 90);

