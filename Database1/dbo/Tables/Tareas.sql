CREATE TABLE [dbo].[Tareas] (
    [IdTarea]       INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]   VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones] NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TipoTarea]     INT          NULL,
    CONSTRAINT [PK_Tareas] PRIMARY KEY CLUSTERED ([IdTarea] ASC) WITH (FILLFACTOR = 90)
);

