CREATE TABLE [dbo].[TiposEquipo] (
    [IdTipoEquipo] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]  VARCHAR (50) NULL,
    CONSTRAINT [PK_TiposEquipo] PRIMARY KEY CLUSTERED ([IdTipoEquipo] ASC) WITH (FILLFACTOR = 90)
);

