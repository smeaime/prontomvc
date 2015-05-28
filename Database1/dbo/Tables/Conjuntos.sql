CREATE TABLE [dbo].[Conjuntos] (
    [IdConjunto]     INT          IDENTITY (1, 1) NOT NULL,
    [IdArticulo]     INT          NULL,
    [Observaciones]  NTEXT        NULL,
    [IdRealizo]      INT          NULL,
    [FechaRegistro]  DATETIME     NULL,
    [CodigoConjunto] VARCHAR (10) NULL,
    [IdObra]         INT          NULL,
    [Version]        INT          NULL,
    CONSTRAINT [PK_Conjuntos] PRIMARY KEY CLUSTERED ([IdConjunto] ASC) WITH (FILLFACTOR = 90)
);

