CREATE TABLE [dbo].[_TempCuboPosicionFinanciera] (
    [IdPosicionFinaciera]                         INT             IDENTITY (1, 1) NOT NULL,
    [Tipo]                                        VARCHAR (20)    NULL,
    [Moneda]                                      VARCHAR (20)    NULL,
    [Descripcion]                                 VARCHAR (200)   NULL,
    [Fecha]                                       DATETIME        NULL,
    [Detalle]                                     VARCHAR (100)   NULL,
    [DepositosPendientes]                         NUMERIC (18, 2) NULL,
    [TransferenciasEntreCuentasPropiasPendientes] NUMERIC (18, 2) NULL,
    [ChequesEmitidosPendientes]                   NUMERIC (18, 2) NULL,
    [SaldoContable]                               NUMERIC (18, 2) NULL,
    [Otros]                                       NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboPosicionFinanciera] PRIMARY KEY CLUSTERED ([IdPosicionFinaciera] ASC) WITH (FILLFACTOR = 90)
);

