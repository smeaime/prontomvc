CREATE TABLE [dbo].[BancoChequeras] (
    [IdBancoChequera]      INT         IDENTITY (1, 1) NOT NULL,
    [IdBanco]              INT         NULL,
    [IdCuentaBancaria]     INT         NULL,
    [NumeroChequera]       INT         NULL,
    [DesdeCheque]          INT         NULL,
    [HastaCheque]          INT         NULL,
    [Fecha]                DATETIME    NULL,
    [ProximoNumeroCheque]  INT         NULL,
    [Activa]               VARCHAR (2) NULL,
    [ChequeraPagoDiferido] VARCHAR (2) NULL,
    CONSTRAINT [PK_BancoChequeras] PRIMARY KEY CLUSTERED ([IdBancoChequera] ASC) WITH (FILLFACTOR = 90)
);

