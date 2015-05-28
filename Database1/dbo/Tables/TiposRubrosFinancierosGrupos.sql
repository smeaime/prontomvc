CREATE TABLE [dbo].[TiposRubrosFinancierosGrupos] (
    [IdTipoRubroFinancieroGrupo] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]                VARCHAR (50) NULL,
    [Codigo]                     INT          NULL,
    CONSTRAINT [PK_TiposRubrosFinancierosGrupos] PRIMARY KEY CLUSTERED ([IdTipoRubroFinancieroGrupo] ASC) WITH (FILLFACTOR = 90)
);

