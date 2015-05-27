CREATE TABLE [dbo].[_TempCuboCashFlow] (
    [IdCuboCashFlow] INT             IDENTITY (1, 1) NOT NULL,
    [Tipo]           VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdProveedor]    INT             NULL,
    [Proveedor]      VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCliente]      INT             NULL,
    [Cliente]        VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Fecha]          DATETIME        NULL,
    [Importe]        NUMERIC (18, 2) NULL,
    [Detalle]        VARCHAR (120)   NULL,
    CONSTRAINT [PK__TempCuboCashFlow] PRIMARY KEY CLUSTERED ([IdCuboCashFlow] ASC) WITH (FILLFACTOR = 90)
);

