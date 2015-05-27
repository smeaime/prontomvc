CREATE TABLE [dbo].[CartasDePorte] (
    [IdCartaDePorte]                                INT             IDENTITY (1, 1) NOT NULL,
    [NumeroCartaDePorte]                            BIGINT          NULL,
    [IdUsuarioIngreso]                              INT             NULL,
    [FechaIngreso]                                  DATETIME        NULL,
    [Anulada]                                       VARCHAR (2)     NULL,
    [IdUsuarioAnulo]                                INT             NULL,
    [FechaAnulacion]                                DATETIME        NULL,
    [Observaciones]                                 VARCHAR (200)   NULL,
    [FechaTimeStamp]                                ROWVERSION      NULL,
    [Vendedor]                                      INT             NULL,
    [CuentaOrden1]                                  INT             NULL,
    [CuentaOrden2]                                  INT             NULL,
    [Corredor]                                      INT             NULL,
    [Entregador]                                    INT             NULL,
    [Procedencia]                                   VARCHAR (30)    NULL,
    [Patente]                                       VARCHAR (30)    NULL,
    [IdArticulo]                                    INT             NULL,
    [IdStock]                                       INT             NULL,
    [Partida]                                       VARCHAR (20)    NULL,
    [IdUnidad]                                      INT             NULL,
    [IdUbicacion]                                   INT             NULL,
    [Cantidad]                                      NUMERIC (12, 2) NULL,
    [Cupo]                                          VARCHAR (30)    NULL,
    [NetoProc]                                      NUMERIC (18, 2) NULL,
    [Calidad]                                       VARCHAR (30)    NULL,
    [BrutoPto]                                      NUMERIC (18, 2) NULL,
    [TaraPto]                                       NUMERIC (18, 2) NULL,
    [NetoPto]                                       NUMERIC (18, 2) NULL,
    [Acoplado]                                      VARCHAR (30)    NULL,
    [Humedad]                                       NUMERIC (18, 2) NULL,
    [Merma]                                         NUMERIC (18, 2) NULL,
    [NetoFinal]                                     NUMERIC (18, 2) NULL,
    [FechaDeCarga]                                  DATETIME        NULL,
    [FechaVencimiento]                              DATETIME        NULL,
    [CEE]                                           VARCHAR (20)    NULL,
    [IdTransportista]                               INT             NULL,
    [TransportistaCUITdesnormalizado]               VARCHAR (13)    NULL,
    [IdChofer]                                      INT             NULL,
    [ChoferCUITdesnormalizado]                      VARCHAR (13)    NULL,
    [CTG]                                           INT             NULL,
    [Contrato]                                      VARCHAR (20)    NULL,
    [Destino]                                       INT             NULL,
    [Subcontr1]                                     INT             NULL,
    [Subcontr2]                                     INT             NULL,
    [Contrato1]                                     INT             NULL,
    [contrato2]                                     INT             NULL,
    [KmARecorrer]                                   NUMERIC (18, 2) NULL,
    [Tarifa]                                        NUMERIC (18, 2) NULL,
    [FechaDescarga]                                 DATETIME        NULL,
    [Hora]                                          DATETIME        NULL,
    [NRecibo]                                       INT             NULL,
    [CalidadDe]                                     INT             NULL,
    [TaraFinal]                                     NUMERIC (18, 2) NULL,
    [BrutoFinal]                                    NUMERIC (18, 2) NULL,
    [Fumigada]                                      NUMERIC (18, 2) NULL,
    [Secada]                                        NUMERIC (18, 2) NULL,
    [Exporta]                                       VARCHAR (2)     NULL,
    [NobleExtranos]                                 NUMERIC (18, 2) NULL,
    [NobleNegros]                                   NUMERIC (18, 2) NULL,
    [NobleQuebrados]                                NUMERIC (18, 2) NULL,
    [NobleDaniados]                                 NUMERIC (18, 2) NULL,
    [NobleChamico]                                  NUMERIC (18, 2) NULL,
    [NobleChamico2]                                 NUMERIC (18, 2) NULL,
    [NobleRevolcado]                                NUMERIC (18, 2) NULL,
    [NobleObjetables]                               NUMERIC (18, 2) NULL,
    [NobleAmohosados]                               NUMERIC (18, 2) NULL,
    [NobleHectolitrico]                             NUMERIC (18, 2) NULL,
    [NobleCarbon]                                   NUMERIC (18, 2) NULL,
    [NoblePanzaBlanca]                              NUMERIC (18, 2) NULL,
    [NoblePicados]                                  NUMERIC (18, 2) NULL,
    [NobleMGrasa]                                   NUMERIC (18, 2) NULL,
    [NobleAcidezGrasa]                              NUMERIC (18, 2) NULL,
    [NobleVerdes]                                   NUMERIC (18, 2) NULL,
    [NobleGrado]                                    INT             NULL,
    [NobleConforme]                                 VARCHAR (2)     NULL,
    [NobleACamara]                                  VARCHAR (2)     NULL,
    [Cosecha]                                       VARCHAR (20)    NULL,
    [HumedadDesnormalizada]                         NUMERIC (18, 2) NULL,
    [Factor]                                        NUMERIC (18, 2) NULL,
    [IdFacturaImputada]                             INT             NULL,
    [PuntoVenta]                                    INT             NULL,
    [SubnumeroVagon]                                INT             NULL,
    [TarifaFacturada]                               NUMERIC (18, 2) NULL,
    [TarifaSubcontratista1]                         NUMERIC (18, 2) NULL,
    [TarifaSubcontratista2]                         NUMERIC (18, 2) NULL,
    [FechaArribo]                                   DATETIME        NULL,
    [Version]                                       INT             NULL,
    [MotivoAnulacion]                               VARCHAR (100)   NULL,
    [NumeroSubfijo]                                 INT             NULL,
    [IdEstablecimiento]                             INT             NULL,
    [EnumSyngentaDivision]                          VARCHAR (10)    NULL,
    [Corredor2]                                     INT             NULL,
    [IdUsuarioModifico]                             INT             NULL,
    [FechaModificacion]                             DATETIME        NULL,
    [FechaEmision]                                  DATETIME        NULL,
    [EstaArchivada]                                 VARCHAR (2)     NULL,
    [ExcluirDeSubcontratistas]                      VARCHAR (2)     NULL,
    [IdTipoMovimiento]                              INT             NULL,
    [IdClienteAFacturarle]                          INT             NULL,
    [SubnumeroDeFacturacion]                        INT             NULL,
    [AgregaItemDeGastosAdministrativos]             VARCHAR (2)     NULL,
    [CalidadGranosQuemados]                         NUMERIC (18, 2) NULL,
    [CalidadGranosQuemadosBonifica_o_Rebaja]        VARCHAR (2)     NULL,
    [CalidadTierra]                                 NUMERIC (18, 2) NULL,
    [CalidadTierraBonifica_o_Rebaja]                VARCHAR (2)     NULL,
    [CalidadMermaChamico]                           NUMERIC (18, 2) NULL,
    [CalidadMermaChamicoBonifica_o_Rebaja]          VARCHAR (2)     NULL,
    [CalidadMermaZarandeo]                          NUMERIC (18, 2) NULL,
    [CalidadMermaZarandeoBonifica_o_Rebaja]         VARCHAR (2)     NULL,
    [FueraDeEstandar]                               VARCHAR (2)     NULL,
    [CalidadPuntaSombreada]                         NUMERIC (18, 2) NULL,
    [CobraAcarreo]                                  VARCHAR (2)     NULL,
    [LiquidaViaje]                                  VARCHAR (2)     NULL,
    [IdClienteAuxiliar]                             INT             NULL,
    [CalidadDescuentoFinal]                         NUMERIC (18, 2) NULL,
    [PathImagen]                                    VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PathImagen2]                                   VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AgrupadorDeTandaPeriodos]                      INT             NULL,
    [ClaveEncriptada]                               VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroCartaEnTextoParaBusqueda]                VARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdClienteEntregador]                           INT             NULL,
    [IdDetalleFactura]                              INT             NULL,
    [SojaSustentableCodCondicion]                   VARCHAR (50)    NULL,
    [SojaSustentableCondicion]                      VARCHAR (50)    NULL,
    [SojaSustentableNroEstablecimientoDeProduccion] VARCHAR (50)    NULL,
    [IdClientePagadorFlete]                         INT             NULL,
    [IdCorredor2]                                   INT             NULL,
    [Acopio1]                                       INT             NULL,
    [Acopio2]                                       INT             NULL,
    [Acopio3]                                       INT             NULL,
    [Acopio4]                                       INT             NULL,
    [Acopio5]                                       INT             NULL,
    [SubnumeroVagonEnTextoParaBusqueda]             VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AcopioFacturarleA]                             INT             NULL,
    [CalidadGranosDanadosRebaja]                    NUMERIC (18, 2) NULL,
    [CalidadGranosExtranosRebaja]                   NUMERIC (18, 2) NULL,
    [CalidadGranosExtranosMerma]                    NUMERIC (18, 2) NULL,
    [CalidadQuebradosMerma]                         NUMERIC (18, 2) NULL,
    [CalidadDanadosMerma]                           NUMERIC (18, 2) NULL,
    [CalidadChamicoMerma]                           NUMERIC (18, 2) NULL,
    [CalidadRevolcadosMerma]                        NUMERIC (18, 2) NULL,
    [CalidadObjetablesMerma]                        NUMERIC (18, 2) NULL,
    [CalidadAmohosadosMerma]                        NUMERIC (18, 2) NULL,
    [CalidadPuntaSombreadaMerma]                    NUMERIC (18, 2) NULL,
    [CalidadHectolitricoMerma]                      NUMERIC (18, 2) NULL,
    [CalidadCarbonMerma]                            NUMERIC (18, 2) NULL,
    [CalidadPanzaBlancaMerma]                       NUMERIC (18, 2) NULL,
    [CalidadPicadosMerma]                           NUMERIC (18, 2) NULL,
    [CalidadVerdesMerma]                            NUMERIC (18, 2) NULL,
    [CalidadQuemadosMerma]                          NUMERIC (18, 2) NULL,
    [CalidadTierraMerma]                            NUMERIC (18, 2) NULL,
    [CalidadZarandeoMerma]                          NUMERIC (18, 2) NULL,
    [CalidadDescuentoFinalMerma]                    NUMERIC (18, 2) NULL,
    [CalidadHumedadMerma]                           NUMERIC (18, 2) NULL,
    [CalidadGastosFumigacionMerma]                  NUMERIC (18, 2) NULL,
    [CalidadQuebradosRebaja]                        NUMERIC (18, 2) NULL,
    [CalidadChamicoRebaja]                          NUMERIC (18, 2) NULL,
    [CalidadRevolcadosRebaja]                       NUMERIC (18, 2) NULL,
    [CalidadObjetablesRebaja]                       NUMERIC (18, 2) NULL,
    [CalidadAmohosadosRebaja]                       NUMERIC (18, 2) NULL,
    [CalidadPuntaSombreadaRebaja]                   NUMERIC (18, 2) NULL,
    [CalidadHectolitricoRebaja]                     NUMERIC (18, 2) NULL,
    [CalidadCarbonRebaja]                           NUMERIC (18, 2) NULL,
    [CalidadPanzaBlancaRebaja]                      NUMERIC (18, 2) NULL,
    [CalidadPicadosRebaja]                          NUMERIC (18, 2) NULL,
    [CalidadVerdesRebaja]                           NUMERIC (18, 2) NULL,
    [CalidadQuemadosRebaja]                         NUMERIC (18, 2) NULL,
    [CalidadTierraRebaja]                           NUMERIC (18, 2) NULL,
    [CalidadZarandeoRebaja]                         NUMERIC (18, 2) NULL,
    [CalidadDescuentoFinalRebaja]                   NUMERIC (18, 2) NULL,
    [CalidadHumedadRebaja]                          NUMERIC (18, 2) NULL,
    [CalidadGastosFumigacionRebaja]                 NUMERIC (18, 2) NULL,
    [CalidadHumedadResultado]                       NUMERIC (18, 2) NULL,
    [CalidadGastosFumigacionResultado]              NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_CartasDePorte] PRIMARY KEY CLUSTERED ([IdCartaDePorte] ASC),
    FOREIGN KEY ([IdCorredor2]) REFERENCES [dbo].[Vendedores] ([IdVendedor]),
    FOREIGN KEY ([IdDetalleFactura]) REFERENCES [dbo].[DetalleFacturas] ([IdDetalleFactura]),
    CONSTRAINT [U_cartasdeporte_SuperBuscador4] UNIQUE NONCLUSTERED ([IdCartaDePorte] ASC, [NumeroCartaDePorte] ASC, [NumeroSubfijo] ASC, [SubnumeroVagon] ASC, [SubnumeroDeFacturacion] ASC, [FechaArribo] ASC, [FechaModificacion] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_Cartasdeporte_Superbuscador]
    ON [dbo].[CartasDePorte]([NumeroCartaDePorte] ASC, [NumeroSubfijo] ASC, [SubnumeroVagon] ASC, [SubnumeroDeFacturacion] ASC, [FechaArribo] ASC, [FechaIngreso] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_CartasDePorte_Filtro4]
    ON [dbo].[CartasDePorte]([IdCartaDePorte] ASC, [AgregaItemDeGastosAdministrativos] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_CartasDePorte_SelectDinamico]
    ON [dbo].[CartasDePorte]([IdCartaDePorte] ASC, [SubnumeroDeFacturacion] ASC, [Vendedor] ASC, [CuentaOrden1] ASC, [CuentaOrden2] ASC, [Corredor] ASC, [Entregador] ASC, [IdArticulo] ASC, [NetoProc] ASC, [IdFacturaImputada] ASC, [Anulada] ASC, [FechaDescarga] ASC, [FechaArribo] ASC, [Exporta] ASC, [EnumSyngentaDivision] ASC, [PuntoVenta] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_Cartasdeporte_PorFecha]
    ON [dbo].[CartasDePorte]([FechaModificacion] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cartasdeporte_AgrupadorDeTandaPeriodos]
    ON [dbo].[CartasDePorte]([IdCartaDePorte] ASC, [AgrupadorDeTandaPeriodos] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador4]
    ON [dbo].[CartasDePorte]([NumeroCartaEnTextoParaBusqueda] ASC, [NumeroCartaDePorte] ASC, [NumeroSubfijo] ASC, [SubnumeroVagon] ASC, [SubnumeroDeFacturacion] ASC, [FechaArribo] ASC, [FechaIngreso] ASC, [FechaModificacion] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_SubNumeroVagon2]
    ON [dbo].[CartasDePorte]([SubnumeroVagon] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador6]
    ON [dbo].[CartasDePorte]([SubnumeroVagon] ASC, [NumeroCartaEnTextoParaBusqueda] ASC, [FechaArribo] ASC, [FechaIngreso] ASC, [FechaModificacion] ASC);

