CREATE TABLE [dbo].[CuentasCorrientesDeudores] (
    [IdCtaCte]                         INT             IDENTITY (1, 1) NOT NULL,
    [IdCliente]                        INT             NULL,
    [Fecha]                            DATETIME        NULL,
    [FechaVencimiento]                 DATETIME        NULL,
    [IdTipoComp]                       INT             NULL,
    [IdComprobante]                    INT             NULL,
    [NumeroComprobante]                INT             NULL,
    [IdImputacion]                     INT             NULL,
    [ImporteTotal]                     NUMERIC (18, 2) NULL,
    [Saldo]                            NUMERIC (18, 2) NULL,
    [ImporteParteEnDolares]            NUMERIC (18, 2) NULL,
    [SaldoImporteParteEnDolares]       NUMERIC (18, 2) NULL,
    [ImporteParteEnPesos]              NUMERIC (18, 2) NULL,
    [SaldoImporteParteEnPesos]         NUMERIC (18, 2) NULL,
    [Cotizacion]                       NUMERIC (18, 3) NULL,
    [IdDetalleRecibo]                  INT             NULL,
    [ImporteTotalDolar]                NUMERIC (18, 2) NULL,
    [SaldoDolar]                       NUMERIC (18, 2) NULL,
    [IdMoneda]                         INT             NULL,
    [CotizacionMoneda]                 NUMERIC (18, 4) NULL,
    [IdDetalleNotaCreditoImputaciones] INT             NULL,
    [EnviarEmail]                      TINYINT         NULL,
    [IdOrigenTransmision]              INT             NULL,
    [IdCtaCteOriginal]                 INT             NULL,
    [FechaImportacionTransmision]      DATETIME        NULL,
    [IdComprobanteOriginal]            INT             NULL,
    [IdImputacionOriginal]             INT             NULL,
    [CuitClienteTransmision]           VARCHAR (13)    NULL,
    [SaldoTrs]                         NUMERIC (18, 2) NULL,
    [Marca]                            VARCHAR (1)     NULL,
    CONSTRAINT [PK_CuentasCorrientesDeudores] PRIMARY KEY NONCLUSTERED ([IdCtaCte] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_CuentasCorrientesDeudores_Clientes] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[CuentasCorrientesDeudores]([IdCliente] ASC, [IdCtaCte] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[CuentasCorrientesDeudores]([IdImputacion] ASC, [Fecha] ASC, [IdCtaCte] ASC) WITH (FILLFACTOR = 90);

