CREATE TABLE [dbo].[TiposOperaciones] (
    [IdTipoOperacion]      INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]               INT          NULL,
    [Descripcion]          VARCHAR (50) NULL,
    [IdTipoOperacionGrupo] INT          NULL,
    CONSTRAINT [PK_TiposOperaciones] PRIMARY KEY CLUSTERED ([IdTipoOperacion] ASC)
);

