CREATE TABLE [dbo].[CuentasBancarias] (
    [IdCuentaBancaria]       INT            IDENTITY (1, 1) NOT NULL,
    [Cuenta]                 VARCHAR (50)   NULL,
    [IdBanco]                INT            NULL,
    [IdMoneda]               INT            NULL,
    [IdProvincia]            INT            NULL,
    [Detalle]                VARCHAR (30)   NULL,
    [PlantillaChequera]      VARCHAR (50)   NULL,
    [ChequesPorPlancha]      INT            NULL,
    [CBU]                    VARCHAR (22)   NULL,
    [InformacionAuxiliar]    VARCHAR (10)   NULL,
    [CaracteresBeneficiario] INT            NULL,
    [Activa]                 VARCHAR (2)    NULL,
    [DiseñoCheque]           VARCHAR (4000) NULL,
    CONSTRAINT [PK_CuentasBancarias] PRIMARY KEY CLUSTERED ([IdCuentaBancaria] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_CuentasBancarias_Bancos] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[Bancos] ([IdBanco])
);

