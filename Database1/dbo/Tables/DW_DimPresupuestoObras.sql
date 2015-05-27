CREATE TABLE [dbo].[DW_DimPresupuestoObras] (
    [IdPresupuestoObrasNodo] INT           NOT NULL,
    [IdNodoPadre]            INT           NULL,
    [Descripcion]            VARCHAR (255) NULL,
    [TipoNodo]               INT           NULL,
    [Lineage]                VARCHAR (255) NULL,
    [Item]                   VARCHAR (20)  NULL,
    [SubItem1]               VARCHAR (10)  NULL,
    [SubItem2]               VARCHAR (10)  NULL,
    [SubItem3]               VARCHAR (10)  NULL,
    CONSTRAINT [PK_DW_DimPresupuestoObras] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodo] ASC) WITH (FILLFACTOR = 90)
);

