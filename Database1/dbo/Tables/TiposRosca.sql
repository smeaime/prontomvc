CREATE TABLE [dbo].[TiposRosca] (
    [IdTipoRosca]                    INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]                    VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]                    VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdArticuloPRONTO_MANTENIMIENTO] INT          NULL,
    CONSTRAINT [PK_TiposRosca] PRIMARY KEY CLUSTERED ([IdTipoRosca] ASC) WITH (FILLFACTOR = 90)
);

