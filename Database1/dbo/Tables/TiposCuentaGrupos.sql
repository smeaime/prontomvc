CREATE TABLE [dbo].[TiposCuentaGrupos] (
    [IdTipoCuentaGrupo]              INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]                    VARCHAR (50) NULL,
    [EsCajaBanco]                    VARCHAR (2)  NULL,
    [AjustarDiferenciasEnSubdiarios] VARCHAR (2)  NULL,
    CONSTRAINT [PK_Tabla1] PRIMARY KEY CLUSTERED ([IdTipoCuentaGrupo] ASC) WITH (FILLFACTOR = 90)
);

