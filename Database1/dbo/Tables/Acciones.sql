CREATE TABLE [dbo].[Acciones] (
    [IdAccion]    INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]      VARCHAR (10)  NULL,
    [Descripcion] VARCHAR (100) NULL,
    CONSTRAINT [PK_Acciones] PRIMARY KEY CLUSTERED ([IdAccion] ASC)
);

