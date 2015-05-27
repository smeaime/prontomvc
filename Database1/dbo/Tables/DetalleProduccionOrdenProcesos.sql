CREATE TABLE [dbo].[DetalleProduccionOrdenProcesos] (
    [IdDetalleProduccionOrdenProceso]      INT      IDENTITY (1, 1) NOT NULL,
    [IdProduccionOrden]                    INT      NULL,
    [IdProduccionProceso]                  INT      NULL,
    [Horas]                                INT      NULL,
    [FechaInicio]                          DATETIME NULL,
    [FechaFinal]                           DATETIME NULL,
    [HorasReales]                          INT      NULL,
    [idMaquina]                            INT      NULL,
    [Observaciones]                        NTEXT    NULL,
    [Orden]                                INT      NULL,
    [IdProduccionParteQueCerroEsteProceso] INT      NULL,
    PRIMARY KEY CLUSTERED ([IdDetalleProduccionOrdenProceso] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionOrden]) REFERENCES [dbo].[ProduccionOrdenes] ([IdProduccionOrden]),
    FOREIGN KEY ([IdProduccionProceso]) REFERENCES [dbo].[ProduccionProcesos] ([IdProduccionProceso])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Campo Agregado el dia 02/01/07', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DetalleProduccionOrdenProcesos', @level2type = N'COLUMN', @level2name = N'Orden';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Campo Agregado el dia 02/01/07', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DetalleProduccionOrdenProcesos', @level2type = N'COLUMN', @level2name = N'IdProduccionParteQueCerroEsteProceso';

