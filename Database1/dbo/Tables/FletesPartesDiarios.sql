CREATE TABLE [dbo].[FletesPartesDiarios] (
    [IdFleteParteDiario] INT             IDENTITY (1, 1) NOT NULL,
    [IdFlete]            INT             NULL,
    [Fecha]              DATETIME        NULL,
    [Cantidad]           NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_FletesPartesDiarios] PRIMARY KEY CLUSTERED ([IdFleteParteDiario] ASC) WITH (FILLFACTOR = 90)
);

