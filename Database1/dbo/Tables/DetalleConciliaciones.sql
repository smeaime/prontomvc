CREATE TABLE [dbo].[DetalleConciliaciones] (
    [IdDetalleConciliacion]  INT         IDENTITY (1, 1) NOT NULL,
    [IdConciliacion]         INT         NULL,
    [IdValor]                INT         NULL,
    [Conciliado]             VARCHAR (2) NULL,
    [Controlado]             VARCHAR (2) NULL,
    [ControladoNoConciliado] VARCHAR (2) NULL,
    CONSTRAINT [PK_DetalleConciliaciones] PRIMARY KEY CLUSTERED ([IdDetalleConciliacion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleConciliaciones_Conciliaciones] FOREIGN KEY ([IdConciliacion]) REFERENCES [dbo].[Conciliaciones] ([IdConciliacion])
);

