CREATE TABLE [dbo].[DefinicionesFlujoCaja] (
    [IdDefinicionFlujoCaja] INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]                INT          NULL,
    [Descripcion]           VARCHAR (50) NULL,
    [CodigoInforme]         INT          NULL,
    [TipoConcepto]          INT          NULL,
    CONSTRAINT [PK_DefinicionesFlujoCaja] PRIMARY KEY CLUSTERED ([IdDefinicionFlujoCaja] ASC) WITH (FILLFACTOR = 90)
);

