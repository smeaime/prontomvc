CREATE TABLE [dbo].[Polizas] (
    [IdPoliza]                    INT             IDENTITY (1, 1) NOT NULL,
    [Tipo]                        VARCHAR (10)    NULL,
    [Numero]                      VARCHAR (30)    NULL,
    [IdProveedor]                 INT             NULL,
    [FechaVigencia]               DATETIME        NULL,
    [FechaFinalizacionCobertura]  DATETIME        NULL,
    [FechaVencimientoPrimerCuota] DATETIME        NULL,
    [CantidadCuotas]              INT             NULL,
    [ImporteAsegurado]            NUMERIC (18, 2) NULL,
    [ImportePrima]                NUMERIC (18, 2) NULL,
    [ImportePremio]               NUMERIC (18, 2) NULL,
    [MotivoContratacion]          NTEXT           NULL,
    [Observaciones]               NTEXT           NULL,
    [NumeroEndoso]                VARCHAR (30)    NULL,
    [TipoFacturacion]             INT             NULL,
    [Certificado]                 VARCHAR (30)    NULL,
    [IdTipoPoliza]                INT             NULL,
    [IdMoneda]                    INT             NULL,
    CONSTRAINT [PK_Polizas] PRIMARY KEY CLUSTERED ([IdPoliza] ASC) WITH (FILLFACTOR = 90)
);

