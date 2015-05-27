CREATE TABLE [dbo].[TiposOperacionesGrupos] (
    [IdTipoOperacionGrupo] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]          VARCHAR (50) NULL,
    CONSTRAINT [PK_TiposOperacionGrupos] PRIMARY KEY CLUSTERED ([IdTipoOperacionGrupo] ASC)
);

