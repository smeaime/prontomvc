CREATE PROCEDURE [dbo].[wArticulos_A]
    @IdArticulo INT,
    @Codigo VARCHAR(20),
    @NumeroInventario VARCHAR(20),
    @Descripcion VARCHAR(256),
    @IdRubro INT,
    @IdSubrubro INT,
    @IdUnidad INT,
    @AlicuotaIVA NUMERIC(6, 2),
    @CostoPPP NUMERIC(18, 2),
    @CostoPPPDolar NUMERIC(18, 2),
    @CostoReposicion NUMERIC(18, 2),
    @CostoReposicionDolar NUMERIC(18, 2),
    @Observaciones NTEXT,
    @AuxiliarString5 VARCHAR(50),
    @AuxiliarString6 VARCHAR(50),
    @AuxiliarString7 VARCHAR(50)
AS 
    IF ISNULL(@IdArticulo, 0) <= 0 
        BEGIN
            INSERT  INTO Articulos
                    (
                      Codigo,
                      NumeroInventario,
                      Descripcion,
                      IdRubro,
                      IdSubrubro,
                      IdUnidad,
                      AlicuotaIVA,
                      CostoPPP,
                      CostoPPPDolar,
                      CostoReposicion,
                      CostoReposicionDolar,
                      Observaciones,
                      AuxiliarString5,
                      AuxiliarString6,
                      AuxiliarString7
	              )
            VALUES  (
                      @Codigo,
                      @NumeroInventario,
                      @Descripcion,
                      @IdRubro,
                      @IdSubrubro,
                      @IdUnidad,
                      @AlicuotaIVA,
                      @CostoPPP,
                      @CostoPPPDolar,
                      @CostoReposicion,
                      @CostoReposicionDolar,
                      @Observaciones,
                      @AuxiliarString5,
                      @AuxiliarString6,
                      @AuxiliarString7
	              )
	
            SELECT  @IdArticulo = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  Articulos
            SET     Codigo = @Codigo,
                    NumeroInventario = @NumeroInventario,
                    Descripcion = @Descripcion,
                    IdRubro = @IdRubro,
                    IdSubrubro = @IdSubrubro,
                    IdUnidad = @IdUnidad,
                    AlicuotaIVA = @AlicuotaIVA,
                    CostoPPP = @CostoPPP,
                    CostoPPPDolar = @CostoPPPDolar,
                    CostoReposicion = @CostoReposicion,
                    CostoReposicionDolar = @CostoReposicionDolar,
                    Observaciones = @Observaciones,
                    AuxiliarString5 = @AuxiliarString5,
                    AuxiliarString6 = @AuxiliarString6,
                    AuxiliarString7 = @AuxiliarString7
            WHERE   ( IdArticulo = @IdArticulo )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdArticulo
