CREATE TABLE [dbo].[DetalleProduccionFichaProcesos] (
    [IdDetalleProduccionFichaProceso] INT             IDENTITY (1, 1) NOT NULL,
    [IdProduccionFicha]               INT             NULL,
    [IdProduccionProceso]             INT             NULL,
    [Horas]                           NUMERIC (12, 2) NULL,
    [Observaciones]                   NTEXT           NULL,
    [Orden]                           INT             NULL,
    PRIMARY KEY CLUSTERED ([IdDetalleProduccionFichaProceso] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionFicha]) REFERENCES [dbo].[ProduccionFichas] ([IdProduccionFicha]),
    FOREIGN KEY ([IdProduccionProceso]) REFERENCES [dbo].[ProduccionProcesos] ([IdProduccionProceso])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Campo Agregado el dia 02/01/07', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DetalleProduccionFichaProcesos', @level2type = N'COLUMN', @level2name = N'Orden';

