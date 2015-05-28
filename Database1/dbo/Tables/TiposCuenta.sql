CREATE TABLE [dbo].[TiposCuenta] (
    [IdTipoCuenta] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]  VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_TiposCuenta] PRIMARY KEY NONCLUSTERED ([IdTipoCuenta] ASC) WITH (FILLFACTOR = 90)
);

