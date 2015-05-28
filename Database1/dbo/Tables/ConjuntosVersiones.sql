CREATE TABLE [dbo].[ConjuntosVersiones] (
    [IdConjuntoVersiones] INT             IDENTITY (1, 1) NOT NULL,
    [IdConjunto]          INT             NULL,
    [IdDetalleConjunto]   INT             NULL,
    [IdArticuloConjunto]  INT             NULL,
    [Version]             INT             NULL,
    [IdArticulo]          INT             NULL,
    [IdUnidad]            INT             NULL,
    [Cantidad]            NUMERIC (18, 3) NULL,
    [FechaModificacion]   DATETIME        NULL,
    CONSTRAINT [PK_ConjuntosVersiones] PRIMARY KEY CLUSTERED ([IdConjuntoVersiones] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ConjuntosVersiones]
    ON [dbo].[ConjuntosVersiones]([FechaModificacion] ASC);

