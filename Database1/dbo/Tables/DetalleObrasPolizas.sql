CREATE TABLE [dbo].[DetalleObrasPolizas] (
    [IdDetalleObraPoliza]        INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                     INT             NULL,
    [IdTipoPoliza]               INT             NULL,
    [IdProveedor]                INT             NULL,
    [NumeroPoliza]               NUMERIC (18)    NULL,
    [FechaVigencia]              DATETIME        NULL,
    [FechaVencimientoCuota]      DATETIME        NULL,
    [Importe]                    NUMERIC (18, 2) NULL,
    [FechaEstimadaRecupero]      DATETIME        NULL,
    [FechaRecupero]              DATETIME        NULL,
    [CondicionRecupero]          VARCHAR (100)   NULL,
    [MotivoDeContratacionSeguro] VARCHAR (100)   NULL,
    [Observaciones]              NTEXT           NULL,
    [FechaFinalizacionCobertura] DATETIME        NULL,
    CONSTRAINT [PK_DetalleObraPolizas] PRIMARY KEY CLUSTERED ([IdDetalleObraPoliza] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleObrasPolizas_Obras] FOREIGN KEY ([IdObra]) REFERENCES [dbo].[Obras] ([IdObra])
);

