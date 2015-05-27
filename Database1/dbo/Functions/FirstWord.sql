
create FUNCTION [dbo].[FirstWord] (@value VARCHAR(50)) --(@value varchar(max))
RETURNS  VARCHAR(50) --varchar(max)
AS
BEGIN
    RETURN CASE CHARINDEX(' ', @value, 1)
        WHEN 0 THEN @value
        ELSE SUBSTRING(@value, 1, CHARINDEX(' ', @value, 1) - 1) END
END
