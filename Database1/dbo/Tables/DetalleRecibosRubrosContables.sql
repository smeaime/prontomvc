CREATE TABLE [dbo].[DetalleRecibosRubrosContables] (
    [IdDetalleReciboRubrosContables]         INT             IDENTITY (1, 1) NOT NULL,
    [IdRecibo]                               INT             NULL,
    [IdRubroContable]                        INT             NULL,
    [Importe]                                NUMERIC (18, 2) NULL,
    [EnviarEmail]                            TINYINT         NULL,
    [IdOrigenTransmision]                    INT             NULL,
    [IdReciboOriginal]                       INT             NULL,
    [IdDetalleReciboRubrosContablesOriginal] INT             NULL,
    [FechaImportacionTransmision]            DATETIME        NULL,
    CONSTRAINT [PK_DetalleRecibosRubrosContables] PRIMARY KEY CLUSTERED ([IdDetalleReciboRubrosContables] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRecibosRubrosContables_Recibos] FOREIGN KEY ([IdRecibo]) REFERENCES [dbo].[Recibos] ([IdRecibo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRecibosRubrosContables]([IdRecibo] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleRecibosRubrosContables]([IdRubroContable] ASC) WITH (FILLFACTOR = 90);

