CREATE TABLE [dbo].[Stock] (
    [IdStock]              INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]           INT             NULL,
    [Partida]              VARCHAR (20)    NULL,
    [CantidadUnidades]     DECIMAL (18, 2) NULL,
    [CantidadAdicional]    DECIMAL (18, 2) NULL,
    [IdUnidad]             INT             NULL,
    [IdUbicacion]          INT             NULL,
    [IdObra]               INT             NULL,
    [NumeroCaja]           INT             NULL,
    [FechaAlta]            DATETIME        NULL,
    [IdColor]              INT             NULL,
    [Equivalencia]         NUMERIC (18, 6) NULL,
    [CantidadEquivalencia] NUMERIC (18, 2) NULL,
    [Talle]                VARCHAR (2)     NULL,
    CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED ([IdStock] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice100]
    ON [dbo].[Stock]([NumeroCaja] ASC) WITH (FILLFACTOR = 90);

