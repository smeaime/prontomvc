CREATE TABLE [dbo].[DiferenciasCambio] (
    [IdDiferenciaCambio]        INT         IDENTITY (1, 1) NOT NULL,
    [IdTipoComprobante]         INT         NULL,
    [IdRegistroOrigen]          INT         NULL,
    [Estado]                    VARCHAR (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdTipoComprobanteGenerado] INT         NULL,
    [IdComprobanteGenerado]     INT         NULL,
    CONSTRAINT [PK_DiferenciasCambio] PRIMARY KEY CLUSTERED ([IdDiferenciaCambio] ASC) WITH (FILLFACTOR = 90)
);

