CREATE TABLE [dbo].[DetalleProduccionFichas] (
    [IdDetalleProduccionFicha] INT             IDENTITY (1, 1) NOT NULL,
    [IdProduccionFicha]        INT             NULL,
    [IdArticulo]               INT             NULL,
    [IdStock]                  INT             NULL,
    [Partida]                  VARCHAR (20)    NULL,
    [Cantidad]                 NUMERIC (12, 2) NULL,
    [CantidadAdicional]        NUMERIC (12, 2) NULL,
    [IdUnidad]                 INT             NULL,
    [Cantidad1]                NUMERIC (12, 2) NULL,
    [Cantidad2]                NUMERIC (12, 2) NULL,
    [Observaciones]            NTEXT           NULL,
    [Porcentaje]               NUMERIC (18, 2) NULL,
    [Tolerancia]               NUMERIC (18, 2) NULL,
    [IdProduccionProceso]      INT             NULL,
    [IdColor]                  INT             NULL,
    [Orden]                    INT             NULL,
    PRIMARY KEY CLUSTERED ([IdDetalleProduccionFicha] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionFicha]) REFERENCES [dbo].[ProduccionFichas] ([IdProduccionFicha]),
    FOREIGN KEY ([IdUnidad]) REFERENCES [dbo].[Unidades] ([IdUnidad])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Campo Agregado el dia 02/01/07', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DetalleProduccionFichas', @level2type = N'COLUMN', @level2name = N'Orden';

