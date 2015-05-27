CREATE TABLE [dbo].[Impuestos] (
    [IdImpuesto]        INT          IDENTITY (1, 1) NOT NULL,
    [IdTipoComprobante] INT          NULL,
    [Fecha]             DATETIME     NULL,
    [IdEquipoImputado]  INT          NULL,
    [NumeroTramite]     VARCHAR (50) NULL,
    [CodigoPlan]        VARCHAR (50) NULL,
    [Agencia]           VARCHAR (50) NULL,
    [Observaciones]     NTEXT        NULL,
    [IdCuenta]          INT          NULL,
    [EnUsoPor]          VARCHAR (30) NULL,
    [Detalle]           VARCHAR (50) NULL,
    [TipoPlan]          VARCHAR (20) NULL,
    CONSTRAINT [PK_Impuestos] PRIMARY KEY CLUSTERED ([IdImpuesto] ASC) WITH (FILLFACTOR = 90)
);

