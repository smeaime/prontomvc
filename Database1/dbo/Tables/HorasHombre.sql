CREATE TABLE [dbo].[HorasHombre] (
    [IdHoraHombre]         INT             IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]           INT             NULL,
    [IdObra]               INT             NULL,
    [IdSector]             INT             NULL,
    [IdItemProduccion]     INT             NULL,
    [Horas]                NUMERIC (18, 2) NULL,
    [HoraInicial]          SMALLDATETIME   NULL,
    [HoraFinal]            SMALLDATETIME   NULL,
    [IdEquipo]             INT             NULL,
    [IdTarea]              INT             NULL,
    [IdSectorReasignado]   INT             NULL,
    [IdTareaMantenimiento] INT             NULL,
    [IdOrdenTrabajo]       INT             NULL,
    CONSTRAINT [PK_HorasHombre] PRIMARY KEY CLUSTERED ([IdHoraHombre] ASC) WITH (FILLFACTOR = 90)
);

