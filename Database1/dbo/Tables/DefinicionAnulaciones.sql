CREATE TABLE [dbo].[DefinicionAnulaciones] (
    [IdDefinicionAnulacion] INT IDENTITY (1, 1) NOT NULL,
    [IdFormulario]          INT NULL,
    CONSTRAINT [PK_DefinicionAnulaciones] PRIMARY KEY CLUSTERED ([IdDefinicionAnulacion] ASC) WITH (FILLFACTOR = 90)
);

