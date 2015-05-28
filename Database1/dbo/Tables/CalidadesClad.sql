CREATE TABLE [dbo].[CalidadesClad] (
    [IdCalidadClad] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]   VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]   VARCHAR (100) NULL,
    CONSTRAINT [PK_CalidadesClad] PRIMARY KEY CLUSTERED ([IdCalidadClad] ASC) WITH (FILLFACTOR = 90)
);

