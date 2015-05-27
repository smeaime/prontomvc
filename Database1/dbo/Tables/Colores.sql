CREATE TABLE [dbo].[Colores] (
    [IdColor]       INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]   VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Codigo]        INT          NULL,
    [Codigo1]       VARCHAR (1)  NULL,
    [IdArticulo]    INT          NULL,
    [IdCliente]     INT          NULL,
    [IdVendedor]    INT          NULL,
    [IdUsuarioAlta] INT          NULL,
    [FechaAlta]     DATETIME     NULL,
    [Codigo2]       VARCHAR (5)  NULL,
    CONSTRAINT [PK_Colores] PRIMARY KEY CLUSTERED ([IdColor] ASC) WITH (FILLFACTOR = 90)
);

