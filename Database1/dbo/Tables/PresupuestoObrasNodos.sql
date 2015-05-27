CREATE TABLE [dbo].[PresupuestoObrasNodos] (
    [IdPresupuestoObrasNodo]           INT             IDENTITY (1, 1) NOT NULL,
    [IdNodoPadre]                      INT             NULL,
    [Depth]                            TINYINT         NULL,
    [Lineage]                          VARCHAR (255)   NULL,
    [TipoNodo]                         INT             NULL,
    [IdObra]                           INT             NULL,
    [Descripcion]                      VARCHAR (200)   NULL,
    [IdUnidad]                         INT             NULL,
    [CantidadAvanzada]                 NUMERIC (18, 2) NULL,
    [Item]                             VARCHAR (20)    NULL,
    [UnidadAvance]                     VARCHAR (1)     NULL,
    [IdPresupuestoObraRubro]           INT             NULL,
    [IdPresupuestoObraGrupoMateriales] INT             NULL,
    [IdCuentaGasto]                    INT             NULL,
    [IdSubrubro]                       INT             NULL,
    [SubItem1]                         VARCHAR (10)    NULL,
    [SubItem2]                         VARCHAR (10)    NULL,
    [SubItem3]                         VARCHAR (10)    NULL,
    [IdNodoAuxiliar]                   INT             NULL,
    [SubItem4]                         VARCHAR (10)    NULL,
    [SubItem5]                         VARCHAR (10)    NULL,
    [IdCuenta]                         INT             NULL,
    [IdArticulo]                       INT             NULL,
    CONSTRAINT [PK_PresupuestoObrasNodos] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodo] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[PresupuestoObrasNodos]([IdNodoPadre] ASC) WITH (FILLFACTOR = 90);

