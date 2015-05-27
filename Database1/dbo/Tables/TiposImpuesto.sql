CREATE TABLE [dbo].[TiposImpuesto] (
    [IdTipoImpuesto] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]    VARCHAR (50) NULL,
    CONSTRAINT [PK_TiposImpuestos] PRIMARY KEY CLUSTERED ([IdTipoImpuesto] ASC) WITH (FILLFACTOR = 90)
);

