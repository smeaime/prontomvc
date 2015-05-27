CREATE TABLE [dbo].[AcoHHItemsDocumentacion] (
    [IdAcoHHItemDocumentacion] INT IDENTITY (1, 1) NOT NULL,
    [IdGrupoTareaHH]           INT NULL,
    CONSTRAINT [PK_AcoHHItemsDocumentacion] PRIMARY KEY CLUSTERED ([IdAcoHHItemDocumentacion] ASC) WITH (FILLFACTOR = 90)
);

