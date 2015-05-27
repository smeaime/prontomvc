CREATE TABLE [dbo].[TiposPoliza] (
    [IdTipoPoliza] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]  VARCHAR (50) NULL,
    CONSTRAINT [PK_TiposPoliza] PRIMARY KEY CLUSTERED ([IdTipoPoliza] ASC) WITH (FILLFACTOR = 90)
);

