CREATE TABLE [dbo].[Tree] (
    [IdItem]      VARCHAR (30)  NOT NULL,
    [Clave]       VARCHAR (100) NULL,
    [Descripcion] VARCHAR (100) NULL,
    [ParentId]    VARCHAR (30)  NULL,
    [Orden]       INT           NULL,
    [Parametros]  VARCHAR (50)  NULL,
    [Link]        VARCHAR (200) NULL,
    [Imagen]      VARCHAR (100) NULL,
    [EsPadre]     VARCHAR (2)   NULL,
    [GrupoMenu]   VARCHAR (30)  NULL,
    CONSTRAINT [PK_Tree] PRIMARY KEY CLUSTERED ([IdItem] ASC)
);

