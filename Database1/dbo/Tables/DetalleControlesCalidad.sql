CREATE TABLE [dbo].[DetalleControlesCalidad] (
    [IdDetalleControlCalidad]     INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleRecepcion]          INT             NULL,
    [IdRecepcion]                 INT             NULL,
    [Fecha]                       DATETIME        NULL,
    [IdMotivoRechazo]             INT             NULL,
    [Cantidad]                    NUMERIC (18, 2) NULL,
    [Observaciones]               NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CantidadAdicional]           NUMERIC (18, 2) NULL,
    [IdRealizo]                   INT             NULL,
    [CantidadRechazada]           NUMERIC (18, 2) NULL,
    [Trasabilidad]                VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdDetalleOtroIngresoAlmacen] INT             NULL,
    [NumeroRemitoRechazo]         INT             NULL,
    [FechaRemitoRechazo]          DATETIME        NULL,
    [IdProveedorRechazo]          INT             NULL,
    CONSTRAINT [PK_DetalleControlesCalidad] PRIMARY KEY CLUSTERED ([IdDetalleControlCalidad] ASC) WITH (FILLFACTOR = 90)
);

