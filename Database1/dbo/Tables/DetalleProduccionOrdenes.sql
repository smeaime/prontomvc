CREATE TABLE [dbo].[DetalleProduccionOrdenes] (
    [IdDetalleProduccionOrden]            INT             IDENTITY (1, 1) NOT NULL,
    [IdProduccionOrden]                   INT             NULL,
    [IdArticulo]                          INT             NULL,
    [IdStock]                             INT             NULL,
    [Partida]                             VARCHAR (20)    NULL,
    [Cantidad]                            NUMERIC (12, 2) NULL,
    [CantidadAdicional]                   NUMERIC (12, 2) NULL,
    [IdUnidad]                            INT             NULL,
    [Cantidad1]                           NUMERIC (12, 2) NULL,
    [Cantidad2]                           NUMERIC (12, 2) NULL,
    [IdDetalleValeSalida]                 INT             NULL,
    [Adjunto]                             VARCHAR (2)     NULL,
    [Observaciones]                       NTEXT           NULL,
    [IdUbicacion]                         INT             NULL,
    [IdObra]                              INT             NULL,
    [CostoUnitario]                       NUMERIC (18, 4) NULL,
    [IdMoneda]                            INT             NULL,
    [CotizacionDolar]                     NUMERIC (18, 4) NULL,
    [CotizacionMoneda]                    NUMERIC (18, 4) NULL,
    [IdEquipoDestino]                     INT             NULL,
    [EnviarEmail]                         TINYINT         NULL,
    [IdOrigenTransmision]                 INT             NULL,
    [DescargaPorKit]                      VARCHAR (2)     NULL,
    [FechaImputacion]                     DATETIME        NULL,
    [IdOrdenesTrabajo]                    INT             NULL,
    [IdDetalleObraDestino]                INT             NULL,
    [IdPresupuestoObraRubro]              INT             NULL,
    [Porcentaje]                          NUMERIC (18, 2) NULL,
    [IdProduccionProceso]                 INT             NULL,
    [IdColor]                             INT             NULL,
    [Tolerancia]                          NUMERIC (18, 2) NULL,
    [Orden]                               INT             NULL,
    [IdProduccionParteQueCerroEsteInsumo] INT             NULL,
    PRIMARY KEY CLUSTERED ([IdDetalleProduccionOrden] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionOrden]) REFERENCES [dbo].[ProduccionOrdenes] ([IdProduccionOrden]),
    FOREIGN KEY ([IdUnidad]) REFERENCES [dbo].[Unidades] ([IdUnidad])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Campo Agregado el dia 02/01/07', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DetalleProduccionOrdenes', @level2type = N'COLUMN', @level2name = N'Orden';

