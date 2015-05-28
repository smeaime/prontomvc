CREATE TABLE [dbo].[LiquidacionesFletes] (
    [IdLiquidacionFlete] INT             IDENTITY (1, 1) NOT NULL,
    [IdTransportista]    INT             NULL,
    [NumeroLiquidacion]  INT             NULL,
    [FechaLiquidacion]   DATETIME        NULL,
    [Anulada]            VARCHAR (2)     NULL,
    [FechaAnulacion]     DATETIME        NULL,
    [IdUsuarioAnulo]     INT             NULL,
    [MotivoAnulacion]    NTEXT           NULL,
    [IdUsuarioIngreso]   INT             NULL,
    [FechaIngreso]       DATETIME        NULL,
    [IdUsuarioModifico]  INT             NULL,
    [FechaModifico]      DATETIME        NULL,
    [Observaciones]      NTEXT           NULL,
    [IdCodigoIva]        INT             NULL,
    [PorcentajeIva]      NUMERIC (6, 2)  NULL,
    [SubtotalNoGravado]  NUMERIC (18, 2) NULL,
    [SubtotalGravado]    NUMERIC (18, 2) NULL,
    [Iva]                NUMERIC (18, 2) NULL,
    [Total]              NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_LiquidacionesFletes] PRIMARY KEY CLUSTERED ([IdLiquidacionFlete] ASC) WITH (FILLFACTOR = 90)
);

