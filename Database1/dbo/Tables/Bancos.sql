CREATE TABLE [dbo].[Bancos] (
    [IdBanco]                      INT          IDENTITY (1, 1) NOT NULL,
    [Nombre]                       VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCuenta]                     INT          NULL,
    [CodigoCuenta]                 VARCHAR (10) NULL,
    [NombreDatanet]                VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cuit]                         VARCHAR (13) NULL,
    [Codigo]                       INT          NULL,
    [IdCodigoIva]                  INT          NULL,
    [CodigoUniversal]              INT          NULL,
    [IdCuentaParaChequesDiferidos] INT          NULL,
    [CodigoResumen]                INT          NULL,
    [Entidad]                      INT          NULL,
    [Subentidad]                   INT          NULL,
    CONSTRAINT [PK_Bancos] PRIMARY KEY CLUSTERED ([IdBanco] ASC) WITH (FILLFACTOR = 90)
);

