CREATE TABLE [dbo].[Cuantificacion] (
    [IdCuantificacion]   INT          IDENTITY (1, 1) NOT NULL,
    [TipoCuantificacion] VARCHAR (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Cuantificacion] PRIMARY KEY CLUSTERED ([IdCuantificacion] ASC) WITH (FILLFACTOR = 90)
);

