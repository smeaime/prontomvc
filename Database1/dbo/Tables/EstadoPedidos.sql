CREATE TABLE [dbo].[EstadoPedidos] (
    [IdEstado]           INT             IDENTITY (1, 1) NOT NULL,
    [IdProveedor]        INT             NULL,
    [Fecha]              DATETIME        NULL,
    [IdTipoComprobante]  INT             NULL,
    [IdComprobante]      INT             NULL,
    [LetraComprobante]   VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroComprobante1] INT             NULL,
    [NumeroComprobante2] INT             NULL,
    [IdImputacion]       INT             NULL,
    [CodigoProveedor]    VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroComprobante]  VARCHAR (13)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroSAP]          VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImporteTotal]       NUMERIC (18, 2) NULL,
    [Saldo]              NUMERIC (18, 2) NULL,
    [SaldoTrs]           NUMERIC (18, 2) NULL,
    [Marca]              VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroPedido]       INT             NULL,
    [SubNumeroPedido]    INT             NULL,
    CONSTRAINT [PK_EstadoPedidos] PRIMARY KEY CLUSTERED ([IdEstado] ASC) WITH (FILLFACTOR = 90)
);

