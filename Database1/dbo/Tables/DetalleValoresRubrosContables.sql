CREATE TABLE [dbo].[DetalleValoresRubrosContables] (
    [IdDetalleValorRubrosContables] INT             IDENTITY (1, 1) NOT NULL,
    [IdValor]                       INT             NULL,
    [IdRubroContable]               INT             NULL,
    [Importe]                       NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleValoresRubrosContables] PRIMARY KEY CLUSTERED ([IdDetalleValorRubrosContables] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleValoresRubrosContables]([IdValor] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleValoresRubrosContables]([IdRubroContable] ASC) WITH (FILLFACTOR = 90);

