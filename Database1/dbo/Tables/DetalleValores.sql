CREATE TABLE [dbo].[DetalleValores] (
    [IdDetalleValor]   INT             IDENTITY (1, 1) NOT NULL,
    [IdValor]          INT             NULL,
    [TipoDetalle]      VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdObra]           INT             NULL,
    [IdCuenta]         INT             NULL,
    [Detalle]          NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Importe]          NUMERIC (18, 2) NULL,
    [ImporteNeto]      NUMERIC (18, 2) NULL,
    [IdPedido]         INT             NULL,
    [IdCentroCosto]    INT             NULL,
    [TempObra]         VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TempNumeroCheque] INT             NULL,
    CONSTRAINT [PK_DetalleValores] PRIMARY KEY CLUSTERED ([IdDetalleValor] ASC) WITH (FILLFACTOR = 90)
);

