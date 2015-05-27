CREATE TABLE [dbo].[DetalleProduccionLineas] (
    [IdDetalleProduccionLinea] INT IDENTITY (1, 1) NOT NULL,
    [IdProduccionLinea]        INT NULL,
    [IdProduccionProceso]      INT NULL,
    [IdMaquina]                INT NULL,
    [Orden]                    INT NULL,
    PRIMARY KEY CLUSTERED ([IdDetalleProduccionLinea] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionLinea]) REFERENCES [dbo].[ProduccionLineas] ([IdProduccionLinea]),
    FOREIGN KEY ([IdProduccionProceso]) REFERENCES [dbo].[ProduccionProcesos] ([IdProduccionProceso])
);

