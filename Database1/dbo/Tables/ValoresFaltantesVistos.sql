CREATE TABLE [dbo].[ValoresFaltantesVistos] (
    [IdValorFaltanteVisto] INT          IDENTITY (1, 1) NOT NULL,
    [IdBancoChequera]      INT          NULL,
    [NumeroCheque]         NUMERIC (18) NULL,
    [IdUsuarioMarco]       INT          NULL,
    [FechaMarcado]         DATETIME     NULL,
    [MotivoMarcado]        VARCHAR (30) NULL,
    CONSTRAINT [PK_ValoresFaltantesVistos] PRIMARY KEY CLUSTERED ([IdValorFaltanteVisto] ASC) WITH (FILLFACTOR = 90)
);

