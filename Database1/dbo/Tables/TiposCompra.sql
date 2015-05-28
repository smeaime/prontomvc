CREATE TABLE [dbo].[TiposCompra] (
    [IdTipoCompra] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]  VARCHAR (100) NULL,
    [Modalidad]    VARCHAR (2)   NULL,
    CONSTRAINT [PK_TiposCompra] PRIMARY KEY CLUSTERED ([IdTipoCompra] ASC) WITH (FILLFACTOR = 90)
);

