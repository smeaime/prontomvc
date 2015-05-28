CREATE TABLE [dbo].[AnticiposAlPersonalSyJ] (
    [IdAnticipoAlPersonalSyJ] INT             IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]              INT             NULL,
    [Fecha]                   DATETIME        NULL,
    [Importe]                 NUMERIC (18, 2) NULL,
    [Detalle]                 VARCHAR (50)    NULL,
    [IdParametroLiquidacion]  INT             NULL,
    CONSTRAINT [PK_AnticiposAlPersonalSyJ] PRIMARY KEY CLUSTERED ([IdAnticipoAlPersonalSyJ] ASC) WITH (FILLFACTOR = 90)
);

