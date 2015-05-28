CREATE TABLE [dbo].[ControlesCalidad] (
    [IdControlCalidad] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]      VARCHAR (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Inspeccion]       VARCHAR (2)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]      VARCHAR (2)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Detalle]          NTEXT         COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_ControlesCalidad] PRIMARY KEY CLUSTERED ([IdControlCalidad] ASC) WITH (FILLFACTOR = 90)
);

