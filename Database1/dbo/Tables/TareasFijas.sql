CREATE TABLE [dbo].[TareasFijas] (
    [IdTareaFija]      INT             IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]       INT             NULL,
    [FechaInicial]     DATETIME        NULL,
    [FechaFinal]       DATETIME        NULL,
    [IdItemProduccion] INT             NULL,
    [HoraInicial]      NUMERIC (18, 2) NULL,
    [HorasJornada]     NUMERIC (18, 2) NULL,
    [IdObra]           INT             NULL,
    [IdEquipo]         INT             NULL,
    [Idtarea]          INT             NULL,
    [LunesAViernes]    VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sabados]          VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Horasjornada1]    NUMERIC (18, 2) NULL,
    [Domingos]         VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [HorasJornada2]    NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_TareasFijas] PRIMARY KEY CLUSTERED ([IdTareaFija] ASC) WITH (FILLFACTOR = 90)
);

