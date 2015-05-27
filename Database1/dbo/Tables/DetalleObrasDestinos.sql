CREATE TABLE [dbo].[DetalleObrasDestinos] (
    [IdDetalleObraDestino] INT          IDENTITY (1, 1) NOT NULL,
    [IdObra]               INT          NULL,
    [Destino]              VARCHAR (13) NULL,
    [Detalle]              NTEXT        NULL,
    [ADistribuir]          VARCHAR (2)  NULL,
    [InformacionAuxiliar]  VARCHAR (20) NULL,
    [TipoConsumo]          INT          NULL,
    CONSTRAINT [PK_DetalleObrasDestinos] PRIMARY KEY CLUSTERED ([IdDetalleObraDestino] ASC) WITH (FILLFACTOR = 90)
);

